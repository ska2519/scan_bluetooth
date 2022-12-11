import 'dart:convert';

import 'package:flutter/scheduler.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../../../constants/resources.dart';
import '../data/scan_bluetooth_repository.dart';
import '../domain/bluetooth.dart';
import '../presentation/scanning_fab/scanning_fab_controller.dart';

final scanDeviceServiceProvider =
    Provider<ScanDeviceService>(ScanDeviceService.new);

class ScanDeviceService {
  ScanDeviceService(this.ref);
  final Ref ref;

  int rssiCalculate(int rssi) => (120 - rssi.abs());

  //* unused
  Future<bool> isBluetoothAvailable() =>
      ref.read(scanBluetoothRepoProvider).isBluetoothAvailable;

  void startScan() {
    ref.invalidate(startScanStreamProvider);
    ref.read(stopWatchProvider(true));
  }

  Stream<List<BluetoothDevice>> connectedDevices() {
    final connectedDevices =
        ref.read(scanBluetoothRepoProvider).connectedDevices;
    return Stream.periodic(const Duration(seconds: 1))
        .asyncMap((_) => connectedDevices);
  }

  //
  void stopScan() => ref.read(scanBluetoothRepoProvider).stopScan();

  void updateScanFABState(bool scanning) =>
      ref.read(scanningProvider.notifier).state = scanning;

  void submitScanning(bool scanning) => (scanning) ? startScan() : stopScan();

  // void connect(String deviceId) => scanBluetoothRepo.connect();

  // void disconnect(String deviceId) => scanBluetoothRepo.disconnect();

  // void discoverServices(String deviceId) =>
  //     scanBluetoothRepo.discoverServices(deviceId);

  //!! ExmapleData 사용 시 주석 해제
  // ref.read(bluetoothListProvider.notifier).state =
  //     exampleData2.map(Bluetooth.fromJson).toList();
  // bluetoothList = exampleData2.map(Bluetooth.fromJson).toList();

  // return bluetoothList;

  void createExampleDate(List<Bluetooth> bluetoothList) {
    final file = File('example_bluetooth_list.txt');
    file.writeAsStringSync(json.encode(bluetoothList));
  }
}

final elapsedProvider =
    StateProvider.autoDispose<Duration>((ref) => Duration.zero);

final stopWatchProvider = Provider.family.autoDispose<void, bool>((ref, start) {
  final ticker = Ticker(
      (onTick) => ref.read(elapsedProvider.notifier).update((state) => onTick));
  start ? ticker.start() : ticker.stop();
});

final connectedDevicesProvider = StreamProvider<List<BluetoothDevice>>(
    (ref) => ref.watch(scanDeviceServiceProvider).connectedDevices());
