import 'package:firebase_storage/firebase_storage.dart';
import '../../constants/resources.dart';

final firebaseStorageProvider = Provider<CloudStorage>((ref) => CloudStorage());

class CloudStorage {
  static final instance = FirebaseStorage.instance;

  Future<String> downloadURL({required String path}) async =>
      instance.ref(path).getDownloadURL();

  Future<void> uploadFile({String? path, required String filePath}) async {
    final file = File(filePath);
    final task = instance.ref(path).putFile(file);

    task.snapshotEvents.listen((TaskSnapshot snapshot) {
      logger.i('CloudStorage Task state: ${snapshot.state}');
      logger.i(
          'CloudStorage Progress: ${(snapshot.bytesTransferred / snapshot.totalBytes) * 100}%');
    }, onError: (e) {
      // The final snapshot is also available on the task via `.snapshot`,
      // this can include 2 additional states, `TaskState.error` & `TaskState.canceled`
      logger.e('CloudStorage snapshotEvents e:', [task.snapshot.toString()]);
      if (e.code == 'permission-denied') {
        logger.e(
            'CloudStorage User does not have permission to upload to this reference.');
      }
    });

    // We can still optionally use the Future alongside the stream.
    try {
      await task;
      logger.d('CloudStorage Upload complete.');
    } on FirebaseException catch (e) {
      logger.e('CloudStorage uploadFile e: $e', [e]);
      if (e.code == 'permission-denied') {
        logger.e(
            'CloudStorage User does not have permission to upload to this reference.');
      }
      // ...
    }
  }
}

  // Future<void> uploadProfileImage(
  //         {required UserId uid, required String filePath}) async =>
  //     _storage.uploadFile(
  //         path: FirebasePath.profileImages(uid), filePath: filePath);

  // Future<String> profileImageURL({required int userId}) async =>
  //     _storage.downloadURL(path: FirebasePath.profileImages(userId));

  // Future<void> uploadPostImages(
  //         {required int userId, required XFile file}) async =>
  //     _storage.uploadFile(
  //       path: FirebasePath.postImages(userId, file.name),
  //       filePath: file.path,
  //     );

  // Future<String> postImagesURL(
  //         {required int userId, required String fileName}) async =>
  //     _storage.downloadURL(path: FirebasePath.postImages(userId, fileName));

  // Future<void> uploadChatImages(
  //         {required String chatId, required XFile file}) async =>
  //     _storage.uploadFile(
  //       path: FirebasePath.chatImages(chatId, file.name),
  //       filePath: file.path,
  //     );

  // Future<String> chatImagesURL(
  //         {required String chatId, required String fileName}) async =>
  //     _storage.downloadURL(path: FirebasePath.chatImages(chatId, fileName));

  // Future<void> uploadVerificationImage(
  //         {required int userId, required File file}) async =>
  //     _storage.uploadFile(
  //       path: FirebasePath.verificationImages(userId, basename(file.path)),
  //       filePath: file.path,
  //     );

  // Future<String> verificationImageURL(
  //         {required int userId, required File file}) async =>
  //     _storage.downloadURL(
  //         path: FirebasePath.verificationImages(userId, basename(file.path)));
