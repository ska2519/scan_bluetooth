import 'dart:convert';
import 'dart:io';

import 'package:flutter/scheduler.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../exceptions/error_logger.dart';
import '../../../utils/current_date_provider.dart';
import '../data/bluetooth_repo.dart';
import '../data/scan_bluetooth_repository.dart';
import '../domain/bluetooth.dart';
import '../domain/label.dart';
import '../presentation/scanning_fab/scanning_fab_controller.dart';

final scanBluetoothServiceProvider =
    Provider<ScanBluetoothService>(ScanBluetoothService.new);

class ScanBluetoothService {
  ScanBluetoothService(this.ref);
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

  void updateScanFABState(bool scanning) =>
      ref.read(scanFABStateProvider.notifier).update((state) => scanning);

  void toggleStopWatch(bool scanning) => ref.read(stopWatchProvider(scanning));

  void submitScanning(bool scanning) => scanning ? startScan() : stopScan();

  void updateBluetoothListEmpty() async =>
      ref.read(bluetoothListProvider.notifier).update((state) => []);

  Future<void> connect(String deviceId) async {
    logger.i('QuickBlue.connect');
    ref.read(btRepoProvider).connect(deviceId);
  }

  int unknownBtsCount() =>
      ref.watch(bluetoothListProvider).where((bt) => bt.name.isEmpty).length;

  Stream<List<Bluetooth>> createBluetoothListStream(
    List<Bluetooth> bluetoothList,
    List<Label> labelList,
    bool labelFirst,
  ) async* {
    ref.watch(scanResultStreamProvider).whenData((bluetooth) {
      final scanBluetooth = Bluetooth(
        deviceId: bluetooth.deviceId,
        manufacturerData: bluetooth.manufacturerData,
        manufacturerDataHead: bluetooth.manufacturerDataHead,
        name: bluetooth.name,
        rssi: bluetooth.rssi,
        scannedAt: ref.watch(currentDateBuilderProvider).call(),
      );

      if (bluetoothList.isEmpty) {
        bluetoothList.add(scanBluetooth);
      } else {
        for (var i = 0; i < bluetoothList.length; i++) {
          if (bluetoothList[i].deviceId == scanBluetooth.deviceId) {
            bluetoothList[i] =
                scanBluetooth.copyWith(previousRssi: bluetoothList[i].rssi);
            break;
          } else if (i == bluetoothList.length - 1) {
            bluetoothList.add(scanBluetooth);
          }
        }
      }

      for (var label in labelList) {
        for (var i = 0; i < bluetoothList.length; i++) {
          if (bluetoothList[i].deviceId == label.deviceId) {
            bluetoothList[i] = bluetoothList[i].copyWith(
              userLabel: label,
            );
            break;
          }
        }
      }

      bluetoothList.sort((a, b) => b.rssi.compareTo(a.rssi));

      if (labelFirst) {
        bluetoothList.sort((a, b) => b.userLabel != null ? 1 : -1);
      }
      ref.read(bluetoothListProvider.notifier).update((state) => bluetoothList);
    });

    // createExampleDate(bluetoothList);
    //!! ExmapleData 사용 시 주석 해제
    // ref.read(bluetoothListProvider.notifier).state =
    //     exampleData2.map(Bluetooth.fromJson).toList();
    // bluetoothList = exampleData2.map(Bluetooth.fromJson).toList();

    yield bluetoothList;
  }

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

final unknownBtsCountProvider = StateProvider<int>(
  (ref) => ref.watch(scanBluetoothServiceProvider).unknownBtsCount(),
);
final bluetoothListProvider = StateProvider<List<Bluetooth>>((ref) => []);

final labelFirstProvider = StateProvider<bool>((ref) => true);

final bluetoothListStreamProvider = StreamProvider<List<Bluetooth>>((ref) {
  final bluetoothList = ref.read(bluetoothListProvider);
  final labelList = ref.watch(userLabelListProvider);
  final labelFirst = ref.watch(labelFirstProvider);
  return ref
      .watch(scanBluetoothServiceProvider)
      .createBluetoothListStream(bluetoothList, labelList, labelFirst);
});
