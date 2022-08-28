import 'package:firebase_auth/firebase_auth.dart';

import '../domain/app_user.dart';
import 'auth_repository.dart';

class FirebaseAuthRepository implements AuthRepository {
  FirebaseAuthRepository({this.addDelay = true});
  final bool addDelay;

  static final _firebaseAuth = FirebaseAuth.instance;

  AppUser? fromFirebaseUser(User? user) =>
      user != null ? AppUser.transformFirebaseUser(user) : null;

  @override
  AppUser? get currentUser => fromFirebaseUser(_firebaseAuth.currentUser);

  @override
  Stream<AppUser?> authStateChanges() {
    final authStateChanges = _firebaseAuth.authStateChanges();
    return authStateChanges.map(fromFirebaseUser);
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
