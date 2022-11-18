// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../exceptions/error_logger.dart';
import '../../firebase/firestore_json_converter.dart';
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
  }) = _Bluetooth;

  factory Bluetooth.fromJson(Map<String, dynamic> json) =>
      _$BluetoothFromJson(json);
}

final bluetoothListProvider =
    StateNotifierProvider.autoDispose<BluetoothList, List<Bluetooth>>(
        BluetoothList.new);

final unknownBtsCountProvider = StateProvider.autoDispose<int>((ref) {
  ref.watch(bluetoothListProvider);
  return ref.read(bluetoothListProvider.notifier).unknownBtsCount;
});

/// An object that controls a list of [Bluetooth].
class BluetoothList extends StateNotifier<List<Bluetooth>> {
  BluetoothList(this.ref, {List<Bluetooth>? initalList})
      : super(initalList ?? []) {
    logger.i('BluetoothList start');
    init();
  }
  void init() {
    if (!mounted) return;

    ref.listen<AsyncValue<Bluetooth?>>(scanBluetoothStreamProvider,
        (previous, next) {
      final scanBluetooth = next.value;
      // ** prevent rssi number positive value
      if (scanBluetooth != null) {
        // logger.i('state scanBluetooth: $scanBluetooth');
        if (scanBluetooth.rssi > 0) {
          return;
        }
        if (state.isEmpty) {
          state.add(scanBluetooth);
        } else {
          for (var i = 0; i < state.length; i++) {
            if (state[i].deviceId == scanBluetooth.deviceId) {
              state[i] = scanBluetooth.copyWith(previousRssi: state[i].rssi);

              break;
            } else if (i == state.length - 1) {
              state.add(scanBluetooth);
            }
          }
          state.sort((a, b) => b.rssi.compareTo(a.rssi));
        }

        state = [...state];
      }
    });
  }

  Ref ref;
  void setVal(String val) {}

  void add(Bluetooth bluetooth) {
    logger.i('bluetoothService add bluetooth: $bluetooth');
    state = [...state, bluetooth];
  }

  void change(List<Bluetooth> bluetoothList) {
    state = bluetoothList;
    logger.i('BluetoothList change state.length: ${state.length}');
  }

  void labelFrist(
    bool labelFirst,
    List<Label> labelList,
  ) {
    logger.i(
        'labelFirst: $labelFirst / labelList.length: ${labelList.length} / state.length: ${state.length}');
    if (labelList.isNotEmpty) {
      for (var label in labelList) {
        for (var i = 0; i < state.length; i++) {
          if (state[i].deviceId == label.bluetooth.deviceId) {
            state[i] = state[i].copyWith(
              userLabel: label,
            );
            break;
          }
        }
      }
      if (labelFirst) {
        state.sort((a, b) => b.userLabel != null ? 1 : 0);
      }
      state = [...state];
    }
  }

  //

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

  int get unknownBtsCount =>
      state.where((bt) => bt.name.isEmpty).toList().length;
}
