import '../../../constants/resources.dart';
import '../../firebase/cloud_firestore.dart';
import '../../firebase/firebase_path.dart';
import '../domain/user_state.dart';

final presenceUserRepoProvider =
    Provider.autoDispose<PresenceUserRepo>((ref) => PresenceUserRepo());

class PresenceUserRepo {
  final _firestore = CloudFirestore();

  Stream<List<UserState>> userStateStream() {
    logger.i('userStateStream start');
    return _firestore.collectionStream<UserState>(
      path: FirebasePath.collectionStatus(),
      builder: (data, documentId) {
        data?.addAll({'uid': documentId});
        return UserState.fromJson(data!);
      },
    );
  }
}
