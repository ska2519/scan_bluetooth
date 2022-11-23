import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../application/auth_service.dart';
import '../../application/profile_service.dart';
import '../../data/auth_repository.dart';
import '../../domain/app_user.dart';

final profileScreenControllerProvider = StateNotifierProvider.autoDispose<
    ProfileScreenController, AsyncValue<void>>((ref) {
  final auth = ref.read(authRepositoryProvider);
  final profileService = ref.read(profileServiceProvider);
  ref.onDispose(() => ref.refresh(authStateChangesProvider));
  return ProfileScreenController(auth: auth, profileService: profileService);
});

class ProfileScreenController extends StateNotifier<AsyncValue> {
  ProfileScreenController({required this.auth, required this.profileService})
      : super(const AsyncData(null));
  final AuthRepository auth;
  final ProfileService profileService;

  Future<void> uploadProfileImage(
      {required AppUser user, required String filePath}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() =>
        profileService.uploadProfileImage(user: user, filePath: filePath));
  }

  Future<void> updatProfile(appUser) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => auth.updateAppUser(appUser));
  }
}
