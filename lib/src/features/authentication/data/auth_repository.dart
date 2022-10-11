import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../application/auth_service.dart';
import '../domain/app_user.dart';
import 'firebase_auth_repository.dart';

abstract class AuthRepository {
  Stream<User?> authStateChanges();
  // Stream<AppUser?> authStateChanges();
  AppUser? get currentUser;
  void userChanges();
  Future<void> signInAnonymously();
  Future<void> signInWithGoogle();
  Future<void> signInWithApple();
  Future<void> signInWithEmailAndPassword(String email, String password);
  Future<void> createUserWithEmailAndPassword(String email, String password);
  Future<void> signOut();
  Future<AppUser?> getAppUser(String uid);
  void dispose();
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final auth = FirebaseAuthRepository(ref.read(authServiceProvider));
  // !! macos singout test 시 필요 https://github.com/FirebaseExtended/flutterfire/issues/4661
  // auth.signOut();
  ref.onDispose(auth.dispose);
  return auth;
});
