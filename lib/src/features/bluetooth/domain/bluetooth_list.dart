import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../../../constants/resources.dart';
import '../application/bluetooth_service.dart';
import '../data/scan_bluetooth_repository.dart';
import 'bluetooth.dart';
import 'label.dart';

final tempBluetoothListProvider = StateProvider<List<ScanResult>>((ref) => []);

final bluetoothListProvider =
    StateNotifierProvider<BluetoothList, List<ScanResult>>(
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
      .where((bt) => bt.device.type == BluetoothDeviceType.unknown)
      .toList()
      .length;
});

/// An object that controls a list of [Bluetooth].
class BluetoothList extends StateNotifier<List<ScanResult>> {
  BluetoothList(
    this.ref,
    this.userLabelList, {
    List<ScanResult>? initalList,
  }) : super(initalList ?? []) {
    _init();
  }

  final List<Label?> userLabelList;

  void _init() async {
    try {
      // await updateStateUserLabel(userLabelList);

      ref.listen<AsyncValue<List<ScanResult>>>(scanResultListStreamProvider,
          (previous, next) {
        var scanResultList = next.valueOrNull ?? [];
        logger.i('scanResultList: $scanResultList');
        logger.i('scanResultList.length: ${scanResultList.length}');

        state = [...scanResultList];
      });
      // ref.listen<AsyncValue<Bluetooth?>>(scanBluetoothStreamProvider,
      //     (previous, next) async {
      //   var scanBluetooth = next.value;
      //   // ** prevent rssi number positive value
      //   if (scanBluetooth != null) {
      //     if (scanBluetooth.rssi > 0) {
      //       return;
      //     }
      //     if (state.isEmpty) {
      //       state.add(scanBluetooth);
      //     } else {
      //       final i = state.indexWhere(
      //           (state) => state.deviceId == scanBluetooth.deviceId);
      //       if (i >= 0) {
      //         state[i] = scanBluetooth.copyWith(previousRssi: state[i].rssi);
      //       } else {
      //         state.add(scanBluetooth);
      //       }
      //     }
      //     await updateStateUserLabel(userLabelList);
      //     sort();
      //     ref.read(tempBluetoothListProvider.notifier).state = state;
      //     state = [...state];
      //   }
      // });
    } catch (e) {
      logger.e('init e: $e');
    }
  }

  Ref ref;

  // void add(Bluetooth bluetooth) {
  //   logger.i('bluetoothService add bluetooth: $bluetooth');
  //   state = [...state, bluetooth];
  // }

  // void change(List<Bluetooth> bluetoothList) {
  //   state = bluetoothList;
  //   logger.i('BluetoothList change state.length: ${state.length}');
  // }

  // Future<void> updateStateUserLabel(List<Label?> labelList) async {
  //   if (labelList.isEmpty) return;

  //   for (var label in labelList) {
  //     for (var i = 0; i < state.length; i++) {
  //       if (label!.bluetooth.deviceId == state[i].device.id.id) {
  //         state[i] = state[i].copyWith(userLabel: label);
  //         // state[i] = state[i].copyWith(userLabel: label);
  //       }
  //     }
  //   }
  // }

  void sort() => state.sort((a, b) => b.rssi.compareTo(a.rssi));

  // void remove(Bluetooth bluetooth) {
  //   state = state
  //       .where((bluetooth) => bluetooth.deviceId != bluetooth.deviceId)
  //       .toList();
  // }

  void removeAll() => state = [];
}
