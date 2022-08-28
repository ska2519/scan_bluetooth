import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
    return authStateChanges.map(_fromFirebaseUser);
  }

  @override
  Future<void> signInAnonymously() async {
    try {
      await _firebaseAuth.signInAnonymously();
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'operation-not-allowed':
          print('e.code: ${e.code}');
          print("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          print('signInAnonymously e.code: ${e.code}');
          print(e.message);
      }
    }
    return;
  }

  Future<AppUser?> _linkWithCredential(OAuthCredential credential,
      {String? displayName}) async {
    try {
      final userLinkWithCredential =
          await _firebaseAuth.currentUser?.linkWithCredential(credential);
      return userLinkWithCredential?.user != null
          ? setAppUser(userLinkWithCredential!.user!, displayName: displayName)
          : null;
    } catch (e) {
      rethrow;
    }
  }

  Future<AppUser?> _signInWithCredential(OAuthCredential credential) async {
    try {
      final userLinkWithCredential =
          await _firebaseAuth.signInWithCredential(credential);
      return userLinkWithCredential.user != null
          ? getAppUser(userLinkWithCredential.user!.uid)
          : null;
    } catch (e) {
      rethrow;
    }
  }

  Future<AppUser?> signInWithGoogle({String? displayName}) async {
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
      print('e.code: ${e.code}');
      switch (e.code) {
        case 'provider-already-linked':
          print('The provider has already been linked to the user.');
          break;
        case 'invalid-credential':
          print("The provider's credential is not valid.");
          break;
        case 'credential-already-in-use':
          print('The account corresponding to the credential already exists, '
              'or is already linked to a Firebase User.');
          return await _signInWithCredential(credential);
        default:
          print('Unknown error. linkWithCredential e.code: ${e.code}');
      }
    }
    return null;
  }

  // Future<void> signInWithApple() async {
  //   final appleProvider = AppleAuthProvider();
  //   if (kIsWeb) {
  //     await _auth.signInWithPopup(appleProvider);
  //   } else {
  //     await _auth.signInWithAuthProvider(appleProvider);
  //   }
  // }

  Future<AppUser> setAppUser(User user, {String? displayName}) async {
    try {
      await _firestore.setData(
        path: FirebasePath.users(uid: user.uid),
        data: AppUser.transformFirebaseUser(user, displayName: displayName)
            .toJson(),
      );
      return AppUser.transformFirebaseUser(user, displayName: displayName);
    } catch (e) {
      rethrow;
    }
  }

  Future<AppUser?> getAppUser(String uid) async => _firestore.getDoc(
        path: FirebasePath.users(uid: uid),
        builder: (data, documentId) =>
            data.isEmpty ? null : AppUser.fromJson(data),
      );

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
