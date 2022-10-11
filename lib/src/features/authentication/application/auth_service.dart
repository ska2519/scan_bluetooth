import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../exceptions/error_logger.dart';
import '../data/auth_repository.dart';
import '../domain/app_user.dart';

final authServiceProvider = Provider<AuthService>(AuthService.new);
final trySignOutProvider = StateProvider<bool>((ref) => false);
final authStateChangesProvider = StreamProvider<AppUser?>((ref) {
  return ref.watch(authServiceProvider).authStateChanges();
});

class AuthService {
  AuthService(this.ref);
  final Ref ref;

  Stream<AppUser?> authStateChanges() {
    User? tempUser;
    logger.i('authStateChanges tempUser1: $tempUser');
    final auth = ref.watch(authRepositoryProvider);
    final authStateChanges = auth.authStateChanges();
    return authStateChanges.asyncMap((user) async {
      logger.i('authStateChanges user: $user');
      try {
        if (user == null || user != tempUser) {
          tempUser = user;
          logger.i('authStateChanges tempUser2: $tempUser');
          if (user == null) {
            await auth.signInAnonymously();
            logger.i('authStateChanges called auth.signInAnonymously();');
          } else {
            final appUser = await auth.getAppUser(user.uid);
            logger.w('authStateChanges appUser: $appUser');
            return appUser;
          }
        }
      } catch (e) {
        logger.e('authStateChanges getAppUser failed: $e');
      }
      return null;
    });
  }

  void refreshAuthStateChangesProvider() {
    logger.i('refreshAuthStateChangesProvider');
    ref.refresh(authStateChangesProvider);
  }

  Future<void> signOut() async {
    try {
      ref.read(trySignOutProvider.notifier).update((state) => true);
      logger.i('signOut trySignOut: ${ref.read(trySignOutProvider)}');
      await Future.delayed(const Duration(seconds: 1), () async {});
      await ref.read(authRepositoryProvider).signOut();
      refreshAuthStateChangesProvider();
      ref.read(trySignOutProvider.notifier).update((state) => false);
    } catch (e) {
      logger.i('signOut e: e');
    }
  }
}
