import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_blue/quick_blue.dart';

class BluetoothRepository {
  BluetoothRepository({this.addDelay = true});
  final bool addDelay;

  // void handleConnectionChange(String deviceId, BlueConnectionState state) {
  //   print('_handleConnectionChange $deviceId, $state');
  // }
  void isBluetoothAvailable() {}
  // void quickBlueSetConnectionHandler(handleConnectionChange) {
  //   QuickBlue.setConnectionHandler(handleConnectionChange);
  // }
}

final bluetoothListProvider = StateProvider<List<BlueScanResult>>((ref) => []);

final blueScanResultProvider =
    StreamProvider<BlueScanResult>((ref) => QuickBlue.scanResultStream);

final bluetoothListStreamProvider = StreamProvider((ref) async* {
  final scanResults = ref.watch(bluetoothListProvider);
  ref.watch(blueScanResultProvider).whenData((bluetooth) {
    log('bluetooth.deviceId: ${bluetooth.deviceId}');
    if (!scanResults.any((result) => result.deviceId == bluetooth.deviceId)) {
      ref.watch(bluetoothListProvider).add(bluetooth);
    }
    log(' ref.watch(bluetoothListProvider).length: ${ref.watch(bluetoothListProvider).length}');
  });
  yield scanResults;
});

final bluetoothRepositoryProvider = Provider<BluetoothRepository>((ref) {
  return BluetoothRepository(addDelay: false);
});
