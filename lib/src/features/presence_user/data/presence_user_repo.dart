import '../../../constants/resources.dart';
import '../../firebase/cloud_firestore.dart';
import '../../firebase/firebase_path.dart';
import '../domain/user_state.dart';

final presenceUserRepoProvider =
    Provider.autoDispose<PresenceUserRepo>((ref) => PresenceUserRepo());

class PresenceUserRepo {
  final _firestore = CloudFirestore();

  Stream<List<UserState?>> userStateStream() {
    var collectionGroupStream = Stream<List<UserState?>>.value([]);
    try {
      collectionGroupStream = _firestore.collectionGroupStream<UserState?>(
        path: FirebasePath.collectionStatus(),
        builder: (data, documentId) {
          if (data != null) data.addAll({'documentId': documentId});
          return data != null ? UserState.fromJson(data) : null;
        },
      );
    } catch (e) {
      logger.e('userStateStream e: $e');
    }
    return collectionGroupStream;
  }
}
