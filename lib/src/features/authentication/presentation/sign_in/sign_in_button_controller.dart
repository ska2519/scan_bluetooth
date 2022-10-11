import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/auth_repository.dart';
import 'sign_in_type.dart';

class SignInButtonController extends StateNotifier<AsyncValue<void>> {
  SignInButtonController({required this.authRepository})
      : super(const AsyncData(null));
  final AuthRepository authRepository;

  Future<void> signInWith(SignInType signInType) async {
    AsyncValue<void> newState;
    state = const AsyncLoading();
    switch (signInType) {
      case SignInType.google:
        newState = await AsyncValue.guard(authRepository.signInWithGoogle);
        break;
      case SignInType.apple:
        newState = await AsyncValue.guard(authRepository.signInWithApple);
        break;
    }
    if (mounted) {
      state = newState;
    }
  }
}

final signInButtonControllerProvider =
    StateNotifierProvider.autoDispose<SignInButtonController, AsyncValue<void>>(
        (ref) => SignInButtonController(
            authRepository: ref.read(authRepositoryProvider)));
