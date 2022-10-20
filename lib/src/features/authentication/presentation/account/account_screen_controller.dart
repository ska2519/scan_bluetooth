import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../application/auth_service.dart';

class AccountScreenController extends StateNotifier<AsyncValue<void>> {
  AccountScreenController({
    // required this.authRepository,
    required this.authService,
  }) : super(const AsyncData(null));
  // final AuthRepository authRepository;
  final AuthService authService;

  Future<void> signOut() async {
    state = const AsyncLoading();
    final newState = await AsyncValue.guard(authService.signOut);
    if (mounted) {
      state = newState;
    }
  }
}

final accountScreenControllerProvider =
    StateNotifierProvider<AccountScreenController, AsyncValue<void>>((ref) {
  return AccountScreenController(
    // authRepository: ref.watch(authRepositoryProvider),
    authService: ref.read(authServiceProvider),
  );
});
