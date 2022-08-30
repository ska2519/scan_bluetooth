import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../firebase/cloud_firestore.dart';
import '../../firebase/firebase_path.dart';
import '../domain/bluetooth.dart';
import '../domain/nickname.dart';

class NicknameBTRepo {
  NicknameBTRepo({this.addDelay = true});
  final bool addDelay;
  final _firestore = CloudFirestore();

  Future<void> updateBluetooth({
    required Bluetooth bluetooth,
  }) async {
    await _firestore.setData(
      path: FirebasePath.bluetoothes(deviceId: bluetooth.deviceId),
      data: bluetooth.toMap(),
      merge: true,
    );
  }

  Future<void> updateNickname({
    required String deviceId,
    required Nickname nickname,
  }) async {
    await _firestore.setData(
      path: FirebasePath.nicknames(deviceId: deviceId, uid: nickname.user.uid),
      data: nickname.toJson(),
      merge: true,
    );
  }
}

final nickNameBluetoothRepoProvider =
    Provider<NicknameBTRepo>((ref) => NicknameBTRepo());
