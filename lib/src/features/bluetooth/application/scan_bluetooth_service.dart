import 'dart:convert';
import 'dart:io';

import 'package:flutter/scheduler.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../exceptions/error_logger.dart';
import '../../../utils/current_date_provider.dart';
import '../data/scan_bluetooth_repository.dart';
import '../domain/bluetooth.dart';
import '../presentation/scanning_fab/scanning_fab_controller.dart';

final scanBluetoothStreamProvider = StreamProvider<Bluetooth?>(
    (ref) => ref.watch(scanBluetoothServiceProvider).scanBluetoothStream());

final scanBluetoothServiceProvider =
    Provider<ScanBluetoothService>(ScanBluetoothService.new);

class ScanBluetoothService {
  ScanBluetoothService(this.ref);
  final Ref ref;
  late final scanBluetoothRepo = ref.read(scanBluetoothRepoProvider);

  int rssiCalculate(int rssi) => (120 - rssi.abs());

  Future<bool> isBluetoothAvailable() async =>
      await ref.read(scanBluetoothRepoProvider).isBluetoothAvailable();

  void startScan() {
    ref.read(scanBluetoothRepoProvider).startScan();

    // TODO: 이게 꼭 필요한지 고민해보자 예)주위에 블루투스가 하나도 없을 때
    //본인 폰도 안잡힐때 리스트가 리셋이 될까?
  }

  void stopScan() => ref.read(scanBluetoothRepoProvider).stopScan();

  void updateScanFABState(bool scanning) =>
      ref.read(scanFABStateProvider.notifier).update((state) => scanning);

  void toggleStopWatch(bool scanning) => ref.read(stopWatchProvider(scanning));

  Stream<Bluetooth?> scanBluetoothStream() {
    Bluetooth? scanBluetooth;
    try {
      ref.watch(scanResultStreamProvider).whenData((bluetooth) {
        scanBluetooth = Bluetooth(
          deviceId: bluetooth.deviceId,
          manufacturerData: bluetooth.manufacturerData,
          manufacturerDataHead: bluetooth.manufacturerDataHead,
          name: bluetooth.name,
          rssi: bluetooth.rssi,
          scannedAt: ref.watch(currentDateBuilderProvider).call(),
        );
      });
    } catch (e) {
      logger.i('ScanBluetoothService scanBluetoothStream e: $e');
    }
    return Stream.value(scanBluetooth);
  }

  void submitScanning(bool scanning) => (scanning) ? startScan() : stopScan();

  void connect(String deviceId) => scanBluetoothRepo.connect(deviceId);

  void disconnect(String deviceId) => scanBluetoothRepo.disconnect(deviceId);

  void discoverServices(String deviceId) =>
      scanBluetoothRepo.discoverServices(deviceId);

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
