import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../authentication/domain/app_user.dart';
import '../../firebase/cloud_firestore.dart';
import '../../firebase/firebase_path.dart';
import '../domain/bluetooth.dart';
import '../domain/label.dart';

final bluetoothRepoProvider = Provider<BluetoothRepo>((ref) => BluetoothRepo());

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
      merge: true,
    );
  }

  Future<void> deleteBluetooth({required Bluetooth bluetooth}) async =>
      await _firestore.deleteDoc(
        path: FirebasePath.bluetoothes(deviceId: bluetooth.deviceId),
      );

  Future<void> setLabel({
    required String deviceId,
    required Label label,
  }) async =>
      await _firestore.setData(
        path: FirebasePath.labels(deviceId: deviceId, uid: label.user.uid),
        data: label.toJson(),
        merge: true,
      );

  Future<void> deleteLabel({
    required String deviceId,
    required UserId uid,
  }) async =>
      await _firestore.deleteDoc(
        path: FirebasePath.labels(deviceId: deviceId, uid: uid),
      );

  Stream<List<Label>> labelsStream(String uid) {
    return _firestore.collectionGroupStream<Label>(
      path: FirebasePath.collectionGroupLabels(),
      queryBuilder: (query) => query
          .where('uid', isEqualTo: uid)
          .orderBy('createdAt', descending: true),
      builder: (data, documentId) {
        data!.addAll({'documentId': documentId});
        return Label.fromJson(data);
      },
    );
  }
}
