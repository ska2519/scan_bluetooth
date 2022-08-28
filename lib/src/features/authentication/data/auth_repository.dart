import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../domain/app_user.dart';
import 'firebase_auth_repository.dart';

abstract class AuthRepository {
  Stream<AppUser?> authStateChanges();
  AppUser? get currentUser;
  Future<void> signInAnonymously();
  Future<void> signInWithEmailAndPassword(String email, String password);
  Future<void> createUserWithEmailAndPassword(String email, String password);
  Future<void> signOut();
  void dispose();
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final auth = FirebaseAuthRepository();
  print('auth.currentUser: ${auth.currentUser}');
  if (auth.currentUser == null) {
    auth.signInAnonymously();
  }

  // final user = ref.watch(authStateChangesProvider).value;
  // print('user1: ${user.toString()}');
  // if (user == null) ref.read(authRepositoryProvider).signInAnonymously();
  // print('user2: ${user.toString()}');
  ref.onDispose(auth.dispose);
  return auth;
});

final authStateChangesProvider = StreamProvider.autoDispose<AppUser?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges();
});
