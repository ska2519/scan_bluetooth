// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../exceptions/error_logger.dart';
import '../../firebase/firestore_json_converter.dart';
import '../application/bluetooth_service.dart';
import '../application/scan_bluetooth_service.dart';
import 'label.dart';

part 'bluetooth.freezed.dart';
part 'bluetooth.g.dart';

@freezed
class Bluetooth with _$Bluetooth {
  const factory Bluetooth({
    required String name,
    required String deviceId,
    required List<dynamic> manufacturerDataHead,
    required List<dynamic> manufacturerData,
    required int rssi,
    int? previousRssi,
    @TimestampNullableConverter() DateTime? scannedAt,
    @TimestampNullableConverter() DateTime? createdAt,
    @TimestampNullableConverter() DateTime? updatedAt,
    @Default(0) int labelCount,
    Label? firstUpdatedLabel,
    Label? userLabel,
    @Default(false) bool canConnect,
  }) = _Bluetooth;

  factory Bluetooth.fromJson(Map<String, dynamic> json) =>
      _$BluetoothFromJson(json);

  //  int rssiCalculate(int rssi) => (120 - rssi.abs());

}

final tempBluetoothListProvider = StateProvider<List<Bluetooth>>((ref) => []);

final bluetoothListProvider =
    StateNotifierProvider<BluetoothList, List<Bluetooth>>(
  (ref) {
    List<Label>? userLabelList;
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
    _bluetoothListInit();
  }

  final List<Label>? userLabelList;

  void _bluetoothListInit() {
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
          if (userLabelList != null) updateStateUserLabel(userLabelList!);
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

  void updateStateUserLabel(List<Label> labelList) {
    logger.i(
        'labelList.length: ${labelList.length} / state.length: ${state.length}');
    if (labelList.isNotEmpty) {
      for (var label in labelList) {
        for (var i = 0; i < state.length; i++) {
          if (state[i].deviceId == label.bluetooth.deviceId) {
            state[i] = state[i].copyWith(userLabel: label);
            break;
          }
        }
      }
    }
  }

  void sort() => state.sort((a, b) => b.rssi.compareTo(a.rssi));

  void labelFirstSort() =>
      state.sort((a, b) => b.userLabel != null ? 1 : b.rssi.compareTo(a.rssi));

  // void toggle(String deviceId) {
  //   state = [
  //     for (final bluetooth in state)
  //       if (bluetooth.deviceId == deviceId)
  //         Bluetooth(
  //           deviceId: bluetooth.deviceId,
  //         )
  //       else
  //         bluetooth,
  //   ];
  // }

  // void edit({required String deviceId, required String description}) {
  //   state = [
  //     for (final bluetooth in state)
  //       if (bluetooth.deviceId == deviceId)
  //         Bluetooth(
  //           deviceId: bluetooth.deviceId,
  //         )
  //       else
  //         bluetooth,
  //   ];
  // }

  void remove(Bluetooth bluetooth) {
    state = state
        .where((bluetooth) => bluetooth.deviceId != bluetooth.deviceId)
        .toList();
  }

  void removeAll() => state = [];
}
