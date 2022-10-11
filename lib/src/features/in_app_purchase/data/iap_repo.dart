import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../authentication/application/auth_service.dart';
import '../../authentication/domain/app_user.dart';
import '../../firebase/cloud_firestore.dart';
import '../../firebase/firebase_path.dart';
import '../domain/past_purchase.dart';

final iapRepoProvider = Provider.autoDispose<IAPRepo>((ref) => IAPRepo());

class IAPRepo {
  final _firestore = CloudFirestore();

  Stream<List<PastPurchase>> watchPurchases(UserId uid) {
    return _firestore.collectionStream<PastPurchase>(
      path: FirebasePath.collectionPurchases(),
      queryBuilder: (query) => query.where('userId', isEqualTo: uid),
      builder: (data, documentID) => PastPurchase.fromJson(data!),
    );
  }
}

final pastPurchasesStreamProvider = StreamProvider<List<PastPurchase>>((ref) {
  final iapRepo = ref.read(iapRepoProvider);
  final user = ref.watch(authStateChangesProvider).value;

  return user == null || user.isAnonymous!
      ? const Stream<List<PastPurchase>>.empty()
      : iapRepo.watchPurchases(user.uid);
});
