import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_blue/quick_blue.dart';

class BluetoothRepository {
  BluetoothRepository({this.addDelay = true});
  final bool addDelay;

  // void handleConnectionChange(String deviceId, BlueConnectionState state) {
  //   print('_handleConnectionChange $deviceId, $state');
  // }
  Future<bool> isBluetoothAvailable() => QuickBlue.isBluetoothAvailable();

  void startScan() => QuickBlue.startScan();
  void stopScan() => QuickBlue.stopScan();

  // void quickBlueSetConnectionHandler(handleConnectionChange) {
  //   QuickBlue.setConnectionHandler(handleConnectionChange);
  // }
}

final isBluetoothAvailableProvider = FutureProvider<bool>((ref) async {
  print('calling isBluetoothAvailable');
  return ref.read(bluetoothRepositoryProvider).isBluetoothAvailable();
});

final bluetoothListProvider = StateProvider<List<BlueScanResult>>((ref) => []);

final emptyNameBTCountProvider = StateProvider<int>((ref) {
  final scanResults = ref.watch(bluetoothListProvider);
  var emptyBTCount = 0;
  for (var i = 0; i < scanResults.length; i++) {
    if (scanResults[i].name.isEmpty) {
      emptyBTCount++;
    }
  }
  return emptyBTCount;
});

final blueScanResultProvider =
    StreamProvider<BlueScanResult>((ref) => QuickBlue.scanResultStream);

final bluetoothListStreamProvider =
    StreamProvider<List<BlueScanResult>>((ref) async* {
  final scanResults = ref.read(bluetoothListProvider);
  ref.watch(blueScanResultProvider).whenData((bluetooth) {
    log('bluetooth: ${bluetooth.name} / ${bluetooth.deviceId}');

    if (!scanResults.any((result) => result.deviceId == bluetooth.deviceId)) {
      scanResults.add(bluetooth);
      scanResults.sort((a, b) => b.rssi.compareTo(a.rssi));
      ref.read(bluetoothListProvider.notifier).state = scanResults.toList();
    }
  });
  log('scanResults: ${scanResults.length}');
  yield scanResults;
});

final bluetoothRepositoryProvider = Provider<BluetoothRepository>((ref) {
  return BluetoothRepository(addDelay: false);
});
