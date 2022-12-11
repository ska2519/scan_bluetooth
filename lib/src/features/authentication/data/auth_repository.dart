import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../application/auth_service.dart';
import '../domain/app_user.dart';
import 'firebase_auth_repository.dart';

abstract class AuthRepository {
  Stream<User?> authStateChanges();
  AppUser? get currentUser;
  void userChanges();
  Future<void> signInAnonymously();
  Future<void> signInWithGoogle();
  Future<void> signInWithApple();
  Future<void> signInWithEmailAndPassword(String email, String password);
  Future<void> createUserWithEmailAndPassword(String email, String password);
  Future<void> signOut();
  Future<AppUser?> getAppUser(UserId uid);
  Future<void> setAppUser(User user);
  Future<void> updateAppUser(AppUser user);
  void dispose();
}

final authStateChangesProvider = StreamProvider<User?>((ref) {
  final auth = ref.read(authRepositoryProvider);
  return auth.authStateChanges();
});

final fetchAppUserProvider =
    FutureProvider.family.autoDispose<AppUser?, UserId>((ref, uid) async {
  final auth = ref.read(authRepositoryProvider);
  return await auth.getAppUser(uid);
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final authService = ref.read(authServiceProvider);
  final auth = FirebaseAuthRepository(authService);
  // !! macos singout test 시 필요 https://github.com/FirebaseExtended/flutterfire/issues/4661
  // auth.signOut();
  // ref.onDispose(auth.dispose);
  return auth;
});
