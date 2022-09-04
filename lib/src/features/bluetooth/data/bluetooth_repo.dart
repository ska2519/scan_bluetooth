import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../exceptions/error_logger.dart';
import '../../authentication/data/auth_repository.dart';
import '../../firebase/cloud_firestore.dart';
import '../../firebase/firebase_path.dart';
import '../domain/bluetooth.dart';
import '../domain/label.dart';

class BluetoothRepo {
  BluetoothRepo({this.addDelay = true});
  final bool addDelay;
  final _firestore = CloudFirestore();

  Future<Bluetooth?> fetchBluetooth({required String deviceId}) async {
    return await _firestore.getDoc(
      path: FirebasePath.bluetoothes(deviceId: deviceId),
      builder: (data, documentId) {
        data.addAll({'documentId': documentId});
        return Bluetooth.fromJson(data);
      },
    );
  }

  Future<void> setBluetooth({
    required Bluetooth bluetooth,
  }) async {
    await _firestore.setData(
      path: FirebasePath.bluetoothes(deviceId: bluetooth.deviceId),
      data: bluetooth.toJson(),
      // merge: true,
    );
  }

  Future<void> setLabel({
    required String deviceId,
    required Label label,
  }) async {
    await _firestore.setData(
      path: FirebasePath.labels(deviceId: deviceId, uid: label.user.uid),
      data: label.toJson(),
      merge: true,
    );
  }

  Stream<List<Label>> labelsStream(String uid) =>
      _firestore.collectionGroupStream<Label>(
        path: FirebasePath.collectionGrouplabels(),
        queryBuilder: (query) => query
            .where('uid', isEqualTo: uid)
            .orderBy('createdAt', descending: true),
        builder: (data, documentId) {
          data!.addAll({'documentId': documentId});
          return Label.fromJson(data);
        },
      );
}

final bluetoothRepoProvider = Provider<BluetoothRepo>((ref) => BluetoothRepo());

final userLabelListProvider = StateProvider<List<Label>>((ref) {
  logger.i('userLabelListProvider start');
  var userLabelList = <Label>[];
  ref
      .watch(userLabelListStreamProvider)
      .whenData((labelList) => userLabelList = labelList);
  return userLabelList;
});

final userLabelListStreamProvider = StreamProvider<List<Label>>((ref) {
  logger.i('userLabelListStreamProvider start');
  final labelBluetoothRepo = ref.watch(bluetoothRepoProvider);
  final user = ref.watch(authRepositoryProvider).currentUser;
  return user != null
      ? labelBluetoothRepo.labelsStream(user.uid)
      : const Stream<List<Label>>.empty();
});
