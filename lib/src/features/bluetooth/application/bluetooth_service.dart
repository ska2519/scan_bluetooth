import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_blue/models.dart';

import '../data/bluetooth_repository.dart';

class BluetoothService {
  BluetoothService(this.ref);
  final Ref ref;

  Future<void> startScan() async {
    ref.read(bluetoothRepositoryProvider).startScan();
    await ref.read(bluetoothRepositoryProvider).isBluetoothAvailable();
  }

  Future<void> stopScan() async {
    ref.read(bluetoothRepositoryProvider).stopScan();
    await ref.read(bluetoothRepositoryProvider).isBluetoothAvailable();
  }
}

final bluetoothServiceProvider =
    Provider<BluetoothService>(BluetoothService.new);

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

final bluetoothListStreamProvider =
    StreamProvider<List<BlueScanResult>>((ref) async* {
  final bluetoothList = ref.read(bluetoothListProvider);

  ref.watch(scanResultStreamProvider).whenData((scanBluetooth) {
    print('bluetooth: ${scanBluetooth.name} / ${scanBluetooth.deviceId}');
    print('bluetoothList.length: ${bluetoothList.length}');
    if (bluetoothList.isEmpty) {
      bluetoothList.add(scanBluetooth);
    } else {
      for (var i = 0; i < bluetoothList.length; i++) {
        if (bluetoothList[i].deviceId == scanBluetooth.deviceId) {
          bluetoothList[i] = scanBluetooth;
          break;
        } else if (i == bluetoothList.length - 1) {
          bluetoothList.add(scanBluetooth);
        }
      }
    }

    bluetoothList.sort((a, b) => b.rssi.compareTo(a.rssi));
    ref.read(bluetoothListProvider.notifier).state = bluetoothList.toList();
  });
  yield bluetoothList;
});
