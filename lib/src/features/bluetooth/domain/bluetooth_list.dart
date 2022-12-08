import 'package:flutter_blue_plus/flutter_blue_plus.dart' as fbp;

import '../../../constants/resources.dart';
import '../application/bluetooth_service.dart';
import '../data/scan_bluetooth_repository.dart';
import '../presentation/scanning_fab/scanning_fab_controller.dart';
import 'bluetooth.dart';
import 'label.dart';

final tempBluetoothListProvider = StateProvider<List<Bluetooth>>((ref) => []);

final bluetoothListProvider =
    StateNotifierProvider<BluetoothList, List<Bluetooth>>(
  (ref) {
    var userLabelList = <Label?>[];
    ref
        .watch(userLabelListStreamProvider)
        .whenData((list) => userLabelList = list);
    final tempBluetoothList = ref.read(tempBluetoothListProvider);
    return BluetoothList(
      ref,
      userLabelList,
      initalList: tempBluetoothList,
    );
  },
);

final unknownBtsCountProvider = StateProvider.autoDispose<int>((ref) {
  return ref
      .watch(bluetoothListProvider)
      .where((bt) => bt.type == BluetoothDeviceType.unknown)
      .toList()
      .length;
});

/// An object that controls a list of [Bluetooth].
class BluetoothList extends StateNotifier<List<Bluetooth>> {
  BluetoothList(
    this.ref,
    this.userLabelList, {
    List<Bluetooth>? initalList,
  }) : super(initalList ?? []) {
    _initListenScanStream();
  }

  final Ref ref;
  final List<Label?> userLabelList;

  void _initListenScanStream() async {
    try {
      await updateStateUserLabel(userLabelList);
      final scanning = ref.watch(scanningProvider);
      logger.i('scanning: $scanning');
      if (scanning) {
        ref.listen<AsyncValue<fbp.ScanResult>>(startScanStreamProvider,
            (previous, next) async {
          var scanResult = next.value;
          // ** prevent rssi number positive value
          if (scanResult != null) {
            if (scanResult.rssi > 0) {
              return;
            }
            final bt = Bluetooth(
              deviceId: scanResult.device.id.id,
              name: scanResult.device.name,
              type: scanResult.device.type.name == 'unknown'
                  ? BluetoothDeviceType.unknown
                  : scanResult.device.type.name == 'classic'
                      ? BluetoothDeviceType.classic
                      : scanResult.device.type.name == 'le'
                          ? BluetoothDeviceType.le
                          : BluetoothDeviceType.dual,
              rssi: scanResult.rssi,
              advertisementData: AdvertisementData(
                localName: scanResult.advertisementData.localName,
                txPowerLevel: scanResult.advertisementData.txPowerLevel,
                connectable: scanResult.advertisementData.connectable,
                manufacturerData: scanResult.advertisementData.manufacturerData,
                serviceData: scanResult.advertisementData.serviceData,
                serviceUuids: scanResult.advertisementData.serviceUuids,
              ),
            );
            if (state.isEmpty) {
              state.add(bt);
            } else {
              final i = state.indexWhere(
                  (state) => state.deviceId == scanResult.device.id.id);
              if (i >= 0) {
                state[i] = bt.copyWith(previousRssi: state[i].rssi);
              } else {
                state.add(bt);
              }
            }
            sort();
            await updateStateUserLabel(userLabelList);
            if (mounted) state = [...state];
          }
        });
      }
    } catch (e) {
      logger.e('init e: $e');
    }
  }

  Future<void> updateStateUserLabel(List<Label?> labelList) async {
    if (labelList.isEmpty) return;

    for (var label in labelList) {
      for (var i = 0; i < state.length; i++) {
        if (label!.deviceId == state[i].deviceId) {
          state[i] = state[i].copyWith(userLabel: label);
          break;
        }
      }
    }
  }

  void sort() => state.sort((a, b) => b.rssi.compareTo(a.rssi));

  void removeAll() => state = [];
}
