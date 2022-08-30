import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../exceptions/error_logger.dart';
import '../../firebase/cloud_firestore.dart';
import '../../firebase/firebase_path.dart';
import '../domain/app_user.dart';
import 'auth_repository.dart';

class FirebaseAuthRepository implements AuthRepository {
  FirebaseAuthRepository({this.addDelay = true});
  final bool addDelay;
  static final _firebaseAuth = FirebaseAuth.instance;
  final _firestore = CloudFirestore();

  AppUser? _fromFirebaseUser(User? user) =>
      user != null ? AppUser.transformFirebaseUser(user) : null;

  @override
  AppUser? get currentUser => _fromFirebaseUser(_firebaseAuth.currentUser);

  @override
  void userChanges() => _firebaseAuth.userChanges();

  @override
  Stream<AppUser?> authStateChanges() {
    final authStateChanges = _firebaseAuth.authStateChanges();
    return authStateChanges.asyncMap((user) {
      if (user != null) {
        try {
          getAppUser(user.uid);
        } catch (e) {
          //!! getAppUser failed case error handling
        }
      }
      return null;
    });
  }

  @override
  Future<void> signInAnonymously() async {
    try {
      final userCredential = await _firebaseAuth.signInAnonymously();
      logger.i('signInAnonymously userCredential: $userCredential');
      return userCredential.user != null
          ? await setAppUser(userCredential.user!)
          : null;
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
    return;
  }

  Future<void> _linkWithCredential(OAuthCredential credential,
      {String? displayName}) async {
    try {
      final userLinkWithCredential =
          await _firebaseAuth.currentUser?.linkWithCredential(credential);
      return userLinkWithCredential?.user != null
          ? await setAppUser(userLinkWithCredential!.user!,
              displayName: displayName)
          : null;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _signInWithCredential(OAuthCredential credential,
      {String? displayName}) async {
    try {
      final userLinkWithCredential =
          await _firebaseAuth.signInWithCredential(credential);
      return userLinkWithCredential.user != null
          ? await setAppUser(
              userLinkWithCredential.user!,
              displayName: displayName,
            )
          : null;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signInWithGoogle({String? displayName}) async {
    late OAuthCredential credential;
    try {
      final googleUser = await GoogleSignIn().signIn();
      final googleAuth = await googleUser?.authentication;

      credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return await _linkWithCredential(credential, displayName: displayName);
    } on FirebaseAuthException catch (e) {
      logger.i('e.code: ${e.code}');
      switch (e.code) {
        case 'provider-already-linked':
          logger.i('The provider has already been linked to the user.');
          break;
        case 'invalid-credential':
          logger.i("The provider's credential is not valid.");
          break;
        case 'credential-already-in-use':
          logger
              .d('The account corresponding to the credential already exists, '
                  'or is already linked to a Firebase User.');
          return await _signInWithCredential(credential);
        default:
          logger.i('Unknown error. linkWithCredential e.code: ${e.code}');
      }
    }
    return;
  }

  // Future<void> signInWithApple() async {
  //   final appleProvider = AppleAuthProvider();
  //   if (kIsWeb) {
  //     await _auth.signInWithPopup(appleProvider);
  //   } else {
  //     await _auth.signInWithAuthProvider(appleProvider);
  //   }
  // }

  Future<void> setAppUser(User user, {String? displayName}) async {
    try {
      logger.i('start setAppUser: $user');
      await _firestore.setData(
        path: FirebasePath.users(uid: user.uid),
        data: AppUser.transformFirebaseUser(user, displayName: displayName)
            .toJson(),
      );
      userChanges();
      logger.i('!!CALLED setAppUser userChanges()');
    } catch (e) {
      rethrow;
    }
  }

  Future<AppUser?> getAppUser(String uid) async {
    try {
      logger.i('start getAppUser uid: $uid');
      return await _firestore.getDoc(
        path: FirebasePath.users(uid: uid),
        builder: (data, documentId) =>
            data.isEmpty ? null : AppUser.fromJson(data),
      );
    } catch (e) {
      rethrow;
    } finally {
      logger.i('finally getAppUser currentUser: $currentUser');
    }
  }

  @override
  Future<void> createUserWithEmailAndPassword(String email, String password) {
    // TODO: implement createUserWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) {
    // TODO: implement signInWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }
}
