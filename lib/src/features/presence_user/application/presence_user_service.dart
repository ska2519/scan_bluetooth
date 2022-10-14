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

class PresenceUserService {
  PresenceUserService(this.ref) {
    _init();
  }
  final Ref ref;

  void _init() {
    _listenToLogin();
  }

  void _listenToLogin() {
    ref.listen<AsyncValue<AppUser?>>(authStateChangesProvider,
        (previous, next) async {
      final previousUser = previous?.value;
      final user = next.value;
      logger.i('PresenceUserService _init user: $user');
      if (previousUser != user && user != null) {
        logger.i('PresenceUserService previousUser != user && user != null');
        _updatePresence();
      }
    });
  }

  void _updatePresence() {
    logger.i('PresenceUserService _updatePresence');
    final user = ref.read(authStateChangesProvider).value!;
    final uid = user.uid;

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

    database.ref('.info/connected').onValue.listen((event) {
      if (event.snapshot.value == false) {
        userStatusFirestoreRef.set(isOfflineForFirestore);
        return;
      }

      userStatusDatabaseRef.onDisconnect().set(isOfflineForDatabase).then((_) {
        userStatusDatabaseRef.set(isOnlineForDatabase);
        userStatusFirestoreRef.set(isOnlineForFirestore);
      });
    });
  }
}

final statusStateOnlineStreamProvider = StreamProvider<List<UserState>>((ref) {
  final presenceUserRepo = ref.read(presenceUserRepoProvider);
  return presenceUserRepo.userStateStream();
});
