import '../../../constants/resources.dart';
import '../../firebase/cloud_storage.dart';
import '../../firebase/firebase_path.dart';
import '../data/auth_repository.dart';
import '../domain/app_user.dart';
import '../domain/profile.dart';

final profileServiceProvider =
    Provider.autoDispose<ProfileService>(ProfileService.new);

class ProfileService {
  ProfileService(this.ref) {
    _init();
  }
  final Ref ref;
  late final storage = ref.read(firebaseStorageProvider);
  late final auth = ref.read(authRepositoryProvider);
  late final TextEditingController nicknameEditingCtr;
  late final TextEditingController aboutMeEditingCtr;

  void _init() {
    nicknameEditingCtr = TextEditingController();
    aboutMeEditingCtr = TextEditingController();
  }

  Future<void> uploadProfileImage(
      {required AppUser user, required String filePath}) async {
    try {
      await storage.uploadFile(
        path: FirebasePath.profileImages(user.uid),
        filePath: filePath,
      );
      final newImageUrl =
          await storage.downloadURL(path: FirebasePath.profileImages(user.uid));
      logger.d('uploadProfileImage newImageUrl: $newImageUrl');
      return await auth.updateAppUser(
        user.copyWith(
          profiles: [
            user.profiles.isNotEmpty
                ? user.profiles[0].copyWith(photoUrls: [newImageUrl])
                : Profile(photoUrls: [newImageUrl])
          ],
        ),
      );
    } catch (e) {
      logger.e('uploadProfileImage e: $e');
    }
  }
}
