import 'package:flutter/scheduler.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_blue/models.dart';

import '../data/bluetooth_repository.dart';
import '../presentation/searching_fab/searching_fab_controller.dart';

class BluetoothService {
  BluetoothService(this.ref);
  final Ref ref;
  Future<bool> isBluetoothAvailable() async =>
      await ref.read(bluetoothRepositoryProvider).isBluetoothAvailable();

  Future<void> startScan() async {
    final bluetoothAvailable = await isBluetoothAvailable();
    if (bluetoothAvailable) {
      ref.read(bluetoothRepositoryProvider).startScan();
      ref.read(bluetoothListProvider.notifier).state = [];
    }
    // TODO: 이게 꼭 필요한지 고민해보자 예)주위에 블루투스가 하나도 없을 때
    //본인 폰도 안잡힐때 리스트가 리셋이 될까?
  }

  Future<void> stopScan() async =>
      ref.read(bluetoothRepositoryProvider).stopScan();

  Future<void> submitScan(bool searching) async {
    final bluetoothAvailable = await isBluetoothAvailable();
    if (bluetoothAvailable) {
      searching ? await startScan() : await stopScan();
      ref.read(stopWatchProvider(searching));
      ref.read(scanButtonStateProvider.notifier).state = searching;
    }
  }

  Future<void> connect(String deviceId) async {
    print('QuickBlue.connect');
    ref.read(bluetoothRepositoryProvider).connect(deviceId);
  }

  int emptyNameBTCount() =>
      ref.read(bluetoothListProvider).where((bt) => bt.name.isEmpty).length;

  Stream<List<BlueScanResult>> createBluetoothListStream() async* {
    final bluetoothList = ref.read(bluetoothListProvider);
    ref.watch(scanResultStreamProvider).whenData((scanBluetooth) {
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
  }
}

final elapsedProvider =
    StateProvider.autoDispose<Duration>((ref) => Duration.zero);

final stopWatchProvider = Provider.family.autoDispose<void, bool>((ref, start) {
  final ticker =
      Ticker((onTick) => ref.read(elapsedProvider.notifier).state = onTick);
  if (start) {
    ticker.start();
  } else {
    ticker.stop();
  }
});

final bluetoothServiceProvider =
    Provider<BluetoothService>(BluetoothService.new);

final emptyNameBTCountProvider = StateProvider<int>(
  (ref) => ref.watch(bluetoothServiceProvider).emptyNameBTCount(),
);
final bluetoothListProvider = StateProvider<List<BlueScanResult>>((ref) => []);

final bluetoothListStreamProvider = StreamProvider<List<BlueScanResult>>(
  (ref) => ref.watch(bluetoothServiceProvider).createBluetoothListStream(),
);
