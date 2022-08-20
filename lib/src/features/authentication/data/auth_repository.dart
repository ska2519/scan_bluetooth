import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../domain/app_user.dart';
import 'fake_auth_repository.dart';

abstract class AuthRepository {
  Stream<AppUser?> authStateChanges();
  AppUser? get currentUser;
  Future<void> signInWithEmailAndPassword(String email, String password);
  Future<void> createUserWithEmailAndPassword(String email, String password);
  Future<void> signOut();
  void dispose();
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final auth = FakeAuthRepository();
  ref.onDispose(auth.dispose);
  return auth;
});

final authStateChangesProvider = StreamProvider.autoDispose<AppUser?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges();
});
