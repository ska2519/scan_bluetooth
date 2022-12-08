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
    final auth = ref.watch(authRepositoryProvider);
    final authStateChanges = auth.authStateChanges();

    return authStateChanges.asyncMap<AppUser?>((user) async {
      logger.i('authStateChanges user: $user');
      try {
        if (user == null) {
          await auth.signInAnonymously();
        } else {
          await auth.setAppUser(user);
          return await auth.getAppUser(user.uid);
        }
      } catch (e) {
        logger.e('authStateChanges e: $e', e);
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
      logger.e('signOut e: $e');
    }
  }
}
