import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../exceptions/error_logger.dart';
import '../domain/app_user.dart';
import 'firebase_auth_repository.dart';

abstract class AuthRepository {
  Stream<AppUser?> authStateChanges();
  AppUser? get currentUser;
  void userChanges();
  Future<void> signInAnonymously();
  Future<void> signInWithEmailAndPassword(String email, String password);
  Future<void> createUserWithEmailAndPassword(String email, String password);
  Future<void> signOut();
  void dispose();
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final auth = FirebaseAuthRepository();
  // !! macos singout test 시 필요 https://github.com/FirebaseExtended/flutterfire/issues/4661
  // auth.signOut();
  logger.i('auth.currentUser: ${auth.currentUser}');
  if (auth.currentUser == null) {
    auth.signInAnonymously();
    logger.i('called auth.signInAnonymously();');
  }
  ref.onDispose(auth.dispose);
  return auth;
});

final authStateChangesProvider = StreamProvider<AppUser?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges();
});
