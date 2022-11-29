import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../exceptions/error_logger.dart';
import '../application/bluetooth_service.dart';
import '../application/scan_bluetooth_service.dart';
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
      .where((bt) => bt.name.isEmpty)
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
    _init();
  }

  final List<Label?> userLabelList;

  void _init() async {
    await updateStateUserLabel(userLabelList);
    try {
      if (!mounted) return;

      ref.listen<AsyncValue<Bluetooth?>>(scanBluetoothStreamProvider,
          (previous, next) async {
        var scanBluetooth = next.value;
        // ** prevent rssi number positive value
        if (scanBluetooth != null) {
          if (scanBluetooth.rssi > 0) {
            return;
          }
          if (state.isEmpty) {
            state.add(scanBluetooth);
          } else {
            final i = state.indexWhere(
                (state) => state.deviceId == scanBluetooth.deviceId);
            if (i >= 0) {
              state[i] = scanBluetooth.copyWith(previousRssi: state[i].rssi);
            } else {
              state.add(scanBluetooth);
            }
          }
          await updateStateUserLabel(userLabelList);
          sort();
          ref.read(tempBluetoothListProvider.notifier).state = state;
          state = [...state];
        }
      });
    } catch (e) {
      logger.e('init e: $e');
    }
  }

  Ref ref;

  void add(Bluetooth bluetooth) {
    logger.i('bluetoothService add bluetooth: $bluetooth');
    state = [...state, bluetooth];
  }

  void change(List<Bluetooth> bluetoothList) {
    state = bluetoothList;
    logger.i('BluetoothList change state.length: ${state.length}');
  }

  Future<void> updateStateUserLabel(List<Label?> labelList) async {
    if (labelList.isEmpty) return;

    for (var label in labelList) {
      for (var i = 0; i < state.length; i++) {
        if (label!.bluetooth.deviceId == state[i].deviceId) {
          state[i] = state[i].copyWith(userLabel: label);
        }
      }
    }
  }

  void sort() => state.sort((a, b) => b.rssi.compareTo(a.rssi));

  void remove(Bluetooth bluetooth) {
    state = state
        .where((bluetooth) => bluetooth.deviceId != bluetooth.deviceId)
        .toList();
  }

  void removeAll() => state = [];
}
