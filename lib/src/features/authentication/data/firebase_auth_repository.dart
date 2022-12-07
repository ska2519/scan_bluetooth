import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../exceptions/error_logger.dart';
// Needed because we can't import `dart:html` into a mobile app,
// while on the flip-side access to `dart:io` throws at runtime (hence the `kIsWeb` check below)
import '../../../utils/html_shim.dart' if (dart.library.html) 'dart:html'
    show window;
import '../../firebase/cloud_firestore.dart';
import '../../firebase/firebase_path.dart';
import '../application/auth_service.dart';
import '../domain/app_user.dart';
import 'auth_repository.dart';

class FirebaseAuthRepository implements AuthRepository {
  FirebaseAuthRepository(this.authService, {this.addDelay = true});
  final bool addDelay;
  static final _firebaseAuth = FirebaseAuth.instance;
  final _firestore = CloudFirestore();
  final AuthService authService;

  AppUser? _fromFirebaseUser(User? user) =>
      user != null ? AppUser.transformFirebaseUser(user) : null;

  @override
  AppUser? get currentUser => _fromFirebaseUser(_firebaseAuth.currentUser);

  @override
  void userChanges() => _firebaseAuth.userChanges();

  @override
  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();

  @override
  Future<void> signInAnonymously() async {
    try {
      final userCredential = await _firebaseAuth.signInAnonymously();
      logger.i('signInAnonymously userCredential: $userCredential');
      if (userCredential.user != null) {
        final appUser = await getAppUser(userCredential.user!.uid);
        logger.i('signInAnonymously appUser: $appUser');
        if (appUser == null) {
          await setAppUser(userCredential.user!);
        }
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'operation-not-allowed':
          logger.e('e.code: ${e.code}', e);
          logger.i("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          logger.i('signInAnonymously e.code: ${e.code}');
          logger.i(e.message);
      }
    }
  }

  Future<void> _linkWithCredential(OAuthCredential credential) async {
    try {
      final userLinkWithCredential =
          await _firebaseAuth.currentUser?.linkWithCredential(credential);
      if (userLinkWithCredential != null &&
          userLinkWithCredential.user != null) {
        logger.i('_linkWithCredential user: ${userLinkWithCredential.user}');
        final appUser = await getAppUser(userLinkWithCredential.user!.uid);
        if (appUser == null) {
          await setAppUser(userLinkWithCredential.user!);
        }

        authService.refreshAuthStateChangesProvider();
      }
    } on FirebaseAuthException catch (e) {
      logger.e('FirebaseAuthException e.code: ${e.code}');
      logger.e('FirebaseAuthException e.message: ${e.message}');
      switch (e.code) {
        case 'provider-already-linked':
          logger.i('The provider has already been linked to the user.');
          break;
        case 'invalid-credential':
          logger.i("The provider's credential is not valid.");
          break;
        case 'credential-already-in-use':
          logger.d(
              'The account corresponding to the credential already exists, '
              'or is already linked to a Firebase User e.credential: ${e.credential}');
          return await _signInWithCredential(e.credential!);
        case 'email-already-in-use':
          logger.d(
              'email-already-in-use to a Firebase User e.credential: ${e.credential}');
          return await _signInWithCredential(e.credential!);
        case 'user-not-found':
          logger.d('user-not-found e.credential: ${e.credential}');
          break;
        default:
          logger.i(
              'Unknown error. linkWithCredential e.code: ${e.code} / e.message: ${e.message}');
      }
    }
  }

  Future<void> _signInWithCredential(AuthCredential credential) async {
    try {
      final userLinkWithCredential =
          await _firebaseAuth.signInWithCredential(credential);
      if (userLinkWithCredential.user != null) {
        logger.i('_signInWithCredential user: ${userLinkWithCredential.user}');
        final appUser = await getAppUser(userLinkWithCredential.user!.uid);
        if (appUser == null) {
          await setAppUser(userLinkWithCredential.user!);
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signInWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn(
        scopes: ['email'],
      ).signIn();
      logger.i('signInWithGoogle googleUser: $googleUser');
      if (googleUser == null) {
        logger.e('signInWithGoogle googleUser: $googleUser');
        return;
      }

      final googleAuth = await googleUser.authentication;

      final oauthCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      logger.i('signInWithGoogle oauthCredential: $oauthCredential');
      return await _linkWithCredential(oauthCredential);
    } catch (e) {
      logger.e('signInWithGoogle e: $e');
    }
  }

  /// Generates a cryptographically secure random nonce, to be included in a
  /// credential request.
  String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  @override
  Future<void> signInWithApple() async {
    // To prevent replay attacks with the credential returned from Apple,
    // we include a nonce in the credential request.
    // When signing in in with Firebase, the nonce in the id token returned by Apple,
    // is expected to match the sha256 hash of `rawNonce`.
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);
    //TODO:: dev 환경 분리
    const redirectURL =
        'https://bomb-fruitshop.glitch.me/callbacks/sign_in_with_apple';
    const clientID = 'app.bomb.fruitshop';
    try {
      // Request credential for the currently signed in Apple account.
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        webAuthenticationOptions: WebAuthenticationOptions(
          clientId: clientID,
          redirectUri: kIsWeb
              ? Uri.parse('https://${window.location.host}/')
              : Uri.parse(redirectURL),
        ),
        nonce: nonce,
      );
      logger.i('signInWithApple appleCredential: $appleCredential');

      final oauthCredential = OAuthProvider('apple.com').credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
        rawNonce: rawNonce,
      );
      return await _linkWithCredential(oauthCredential);
    } catch (e) {
      logger.e('signInWithApple e: $e');
    }
  }

  @override
  Future<void> setAppUser(User user) async {
    try {
      logger.i('Auth setAppUser: $user');
      await _firestore.setData(
        path: FirebasePath.users(uid: user.uid),
        data: AppUser.transformFirebaseUser(user).toJson(),
        merge: true,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateAppUser(AppUser user) async {
    try {
      logger.d('updateAppUser: $user');
      await _firestore.setData(
        path: FirebasePath.users(uid: user.uid),
        data: user.toJson(),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AppUser?> getAppUser(String uid) async {
    try {
      return await _firestore.getDoc(
        path: FirebasePath.users(uid: uid),
        builder: (data, documentId) =>
            data == null ? null : AppUser.fromJson(data),
      );
    } catch (e) {
      logger.e('getAppUser e: $e');
      return null;
    }
  }

  @override
  Future<void> createUserWithEmailAndPassword(String email, String password) {
    // TODO: implement createUserWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  void dispose() {
    throw UnimplementedError();
  }

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) {
    // TODO: implement signInWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() => _firebaseAuth.signOut();
}
