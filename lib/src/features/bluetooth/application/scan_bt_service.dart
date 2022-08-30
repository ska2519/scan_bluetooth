import 'package:flutter/scheduler.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../exceptions/error_logger.dart';
import '../data/scan_bt_repository.dart';
import '../domain/bluetooth.dart';
import '../presentation/scanning_fab/scanning_fab_controller.dart';

final scanBluetoothServiceProvider = Provider<ScanBTService>(ScanBTService.new);

class ScanBTService {
  ScanBTService(this.ref);
  final Ref ref;

  int rssiCalculate(int rssi) => (120 - rssi.abs());
  Future<bool> isBluetoothAvailable() async =>
      await ref.read(btRepoProvider).isBluetoothAvailable();

  void startScan() {
    ref.read(btRepoProvider).startScan();

    // TODO: 이게 꼭 필요한지 고민해보자 예)주위에 블루투스가 하나도 없을 때
    //본인 폰도 안잡힐때 리스트가 리셋이 될까?
  }

  void stopScan() => ref.read(btRepoProvider).stopScan();

  Future<void> updateScanFABState(bool scanning) async =>
      ref.read(scanFABStateProvider.notifier).update((state) => scanning);

  Future<void> toggleStopWatch(bool scanning) async =>
      ref.read(stopWatchProvider(scanning));

  Future<void> submitScanning(bool scanning) async =>
      scanning ? startScan() : stopScan();

  Future<void> updateBluetoothListEmpty() async =>
      ref.read(bluetoothListProvider.notifier).update((state) => []);

  Future<void> connect(String deviceId) async {
    logger.i('QuickBlue.connect');
    ref.read(btRepoProvider).connect(deviceId);
  }

  int unknownBtsCount() =>
      ref.watch(bluetoothListProvider).where((bt) => bt.name.isEmpty).length;

  Stream<List<Bluetooth>> createBluetoothListStream(
      List<Bluetooth> bluetoothList) async* {
    final bluetoothList = ref.read(bluetoothListProvider);
    ref.watch(scanResultStreamProvider).whenData((bluetooth) {
      final newScanBluetooth = Bluetooth(
        deviceId: bluetooth.deviceId,
        manufacturerData: bluetooth.manufacturerData,
        manufacturerDataHead: bluetooth.manufacturerDataHead,
        name: bluetooth.name,
        rssi: bluetooth.rssi,
      );
      if (bluetoothList.isEmpty) {
        bluetoothList.add(newScanBluetooth);
      } else {
        for (var i = 0; i < bluetoothList.length; i++) {
          if (bluetoothList[i].deviceId == newScanBluetooth.deviceId) {
            bluetoothList[i] =
                newScanBluetooth.copyWith(previousRssi: bluetoothList[i].rssi);
            break;
          } else if (i == bluetoothList.length - 1) {
            bluetoothList.add(newScanBluetooth);
          }
        }
      }

      bluetoothList.sort((a, b) => b.rssi.compareTo(a.rssi));
      ref.read(bluetoothListProvider.notifier).update((state) => bluetoothList);
    });
    yield bluetoothList;
  }
}

final elapsedProvider =
    StateProvider.autoDispose<Duration>((ref) => Duration.zero);

final stopWatchProvider = Provider.family.autoDispose<void, bool>((ref, start) {
  final ticker = Ticker(
      (onTick) => ref.read(elapsedProvider.notifier).update((state) => onTick));
  start ? ticker.start() : ticker.stop();
});

final unknownBtsCountProvider = StateProvider<int>(
  (ref) => ref.watch(scanBluetoothServiceProvider).unknownBtsCount(),
);
final bluetoothListProvider = StateProvider<List<Bluetooth>>((ref) => []);

final bluetoothListStreamProvider = StreamProvider<List<Bluetooth>>((ref) {
  final bluetoothList = ref.watch(bluetoothListProvider);
  return ref
      .watch(scanBluetoothServiceProvider)
      .createBluetoothListStream(bluetoothList);
});
