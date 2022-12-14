import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../exceptions/error_logger.dart';
import '../../authentication/application/auth_service.dart';
import '../../authentication/domain/app_user.dart';
import '../data/presence_user_repo.dart';
import '../domain/user_state.dart';

enum OnlineState { online, offline }

final presenceUserServiceProvider =
    Provider<PresenceUserService>(PresenceUserService.new);

// final userLabelListStreamProvider = StreamProvider<List<Label?>>((ref) {
//   final bluetoothRepo = ref.read(bluetoothRepoProvider);
//   final user = ref.watch(authStateChangesProvider).value;

//   if (user == null) return const Stream<List<Label?>>.empty();

//   final labelListStream = bluetoothRepo.labelsStream(user.uid);

//   labelListStream.listen((labelList) =>
//       ref.read(userLabelListCountProvider.notifier).state = labelList.length);
//   return labelListStream;
// });

final statusStateOnlineStreamProvider = StreamProvider<List<UserState?>>((ref) {
  final presenceUserRepo = ref.read(presenceUserRepoProvider);
  final user = ref.watch(appUserStateChangesProvider).value;

  return user == null
      ? const Stream<List<UserState>>.empty()
      : presenceUserRepo.userStateStream();
});

class PresenceUserService {
  PresenceUserService(this.ref) {
    _init();
  }
  final Ref ref;

  void _init() {
    _listenToLogin();
  }

  void _listenToLogin() {
    ref.listen<AsyncValue<AppUser?>>(appUserStateChangesProvider,
        (previous, next) async {
      final user = next.value;
      logger.i('PresenceUserService _init user: $user');
      if (user != null) await _updatePresence(user);
    });
  }

  Future<void> _updatePresence(AppUser user) async {
    try {
      final uid = user.uid;
      logger.i('PresenceUserService _updatePresence uid: $uid');

      final isOfflineForDatabase = {
        'state': OnlineState.offline.name,
        'is_anonymous': user.isAnonymous,
        'last_changed': ServerValue.timestamp
      };
      final isOnlineForDatabase = {
        'state': OnlineState.online.name,
        'is_anonymous': user.isAnonymous,
        'last_changed': ServerValue.timestamp
      };

      final database = FirebaseDatabase.instance;
      final userStatusDatabaseRef = database.ref('/status/$uid');

      final firestore = FirebaseFirestore.instance;
      final userStatusFirestoreRef = firestore.doc('/status/$uid');

      var isOfflineForFirestore = {
        'state': OnlineState.offline.name,
        'is_anonymous': user.isAnonymous,
        'last_changed': FieldValue.serverTimestamp(),
      };

      var isOnlineForFirestore = {
        'state': OnlineState.online.name,
        'is_anonymous': user.isAnonymous,
        'last_changed': FieldValue.serverTimestamp(),
      };

      database.ref('.info/connected').onValue.listen((event) async {
        logger.i('???? PresenceUserService  event: ${event.snapshot.value}');
        if (event.snapshot.value == false) {
          await userStatusFirestoreRef.set(isOfflineForFirestore);
          return;
        }

        await userStatusDatabaseRef
            .onDisconnect()
            .set(isOfflineForDatabase)
            .then((_) async {
          logger.i(
              'PresenceUserService userStatusDatabaseRef.onDisconnect().set().then((_)');
          await userStatusDatabaseRef.set(isOnlineForDatabase);
          await userStatusFirestoreRef.set(isOnlineForFirestore);
        });
      });
    } catch (e) {
      logger.e('PresenceUserService _updatePresence e: $e');
    }
  }
}
