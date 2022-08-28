import 'package:flutter/scheduler.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/bluetooth_repository.dart';
import '../domain/new_bluetooth.dart';
import '../presentation/scanning_fab/scanning_fab_controller.dart';

final bluetoothServiceProvider =
    Provider<BluetoothService>(BluetoothService.new);

class BluetoothService {
  BluetoothService(this.ref);
  final Ref ref;

  int rssiCalculate(int rssi) => (120 - rssi.abs());
  Future<bool> isBluetoothAvailable() async =>
      await ref.read(bluetoothRepositoryProvider).isBluetoothAvailable();

  void startScan() {
    ref.read(bluetoothRepositoryProvider).startScan();

    // TODO: 이게 꼭 필요한지 고민해보자 예)주위에 블루투스가 하나도 없을 때
    //본인 폰도 안잡힐때 리스트가 리셋이 될까?
  }

  void stopScan() => ref.read(bluetoothRepositoryProvider).stopScan();

  Future<void> updateScanFABState(bool scanning) async =>
      ref.read(scanFABStateProvider.notifier).update((state) => scanning);

  Future<void> toggleStopWatch(bool scanning) async =>
      ref.read(stopWatchProvider(scanning));

  Future<void> submitScanning(bool scanning) async =>
      scanning ? startScan() : stopScan();

  Future<void> updateBluetoothListEmpty() async =>
      ref.read(bluetoothListProvider.notifier).update((state) => []);

  Future<void> connect(String deviceId) async {
    print('QuickBlue.connect');
    ref.read(bluetoothRepositoryProvider).connect(deviceId);
  }

  int unknownBtsCount() =>
      ref.watch(bluetoothListProvider).where((bt) => bt.name.isEmpty).length;

  Stream<List<NewBluetooth>> createBluetoothListStream(
      List<NewBluetooth> bluetoothList) async* {
    final bluetoothList = ref.read(bluetoothListProvider);
    ref.watch(scanResultStreamProvider).whenData((bluetooth) {
      final newScanBluetooth = NewBluetooth(
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
  (ref) => ref.watch(bluetoothServiceProvider).unknownBtsCount(),
);
final bluetoothListProvider = StateProvider<List<NewBluetooth>>((ref) => []);

final bluetoothListStreamProvider = StreamProvider<List<NewBluetooth>>((ref) {
  final bluetoothList = ref.watch(bluetoothListProvider);
  return ref
      .watch(bluetoothServiceProvider)
      .createBluetoothListStream(bluetoothList);
});
