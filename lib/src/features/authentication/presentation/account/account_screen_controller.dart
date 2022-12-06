import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../application/auth_service.dart';
import '../../data/auth_repository.dart';
import '../../domain/sign_in_type.dart';

class AccountScreenController extends StateNotifier<AsyncValue<void>> {
  AccountScreenController({
    required this.authRepository,
    required this.authService,
  }) : super(const AsyncData(null));
  final AuthRepository authRepository;
  final AuthService authService;

  Future<void> signInWith(SignInType signInType) async {
    AsyncValue<void>? newState;
    state = const AsyncLoading();
    switch (signInType) {
      case SignInType.google:
        newState = await AsyncValue.guard(authRepository.signInWithGoogle);
        break;
      case SignInType.apple:
        newState = await AsyncValue.guard(authRepository.signInWithApple);
        break;
    }
    if (mounted) state = newState;
  }

  Future<void> signOut() async {
    state = const AsyncLoading();
    if (mounted) state = await AsyncValue.guard(authService.signOut);
  }
}

final accountScreenControllerProvider = StateNotifierProvider.autoDispose<
    AccountScreenController, AsyncValue<void>>((ref) {
  return AccountScreenController(
    authRepository: ref.read(authRepositoryProvider),
    authService: ref.read(authServiceProvider),
  );
});
