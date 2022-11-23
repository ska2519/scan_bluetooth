import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../exceptions/error_logger.dart';
import '../data/auth_repository.dart';
import '../domain/app_user.dart';

final authServiceProvider = Provider<AuthService>(AuthService.new);
final authStateChangesProvider = StreamProvider<AppUser?>((ref) {
  return ref.watch(authServiceProvider).authStateChanges();
});

class AuthService {
  AuthService(this.ref);
  final Ref ref;

  Stream<AppUser?> authStateChanges() {
    User? previousUser;
    logger.i('authStateChanges tempUser1: $previousUser');
    final auth = ref.watch(authRepositoryProvider);
    final authStateChanges = auth.authStateChanges();
    return authStateChanges.asyncMap((user) async {
      logger.i('authStateChanges user: $user');
      try {
        if (user == null || user != previousUser) {
          previousUser = user;
          logger.i('authStateChanges tempUser2: $previousUser');
          if (user == null) {
            await auth.signInAnonymously();
          } else {
            final appUser = await auth.getAppUser(user.uid);
            logger.i('authStateChanges appUser: $appUser');
            if (appUser == null) {
              await auth.setAppUser(user);
              return await auth.getAppUser(user.uid);
            }
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
    ref.invalidate(authStateChangesProvider);
  }

  Future<void> signOut() async {
    try {
      await ref.read(authRepositoryProvider).signOut();
    } catch (e) {
      logger.i('signOut e: e');
    }
  }
}
