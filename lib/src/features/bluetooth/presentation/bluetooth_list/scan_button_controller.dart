import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../application/bluetooth_service.dart';

class ScanButtonController extends StateNotifier<AsyncValue<void>> {
  ScanButtonController({
    required this.bluetoothService,
  }) : super(const AsyncData(null));
  final BluetoothService bluetoothService;

  Future<void> submitScanButton(
    bool rollingSwitchState, {
    void Function()? onSuccess,
  }) async {
    state = const AsyncLoading();
    final newState =
        rollingSwitchState ? await _startScan() : await _stopScan();
    if (mounted) {
      // * only set the state if the controller hasn't been disposed
      state = newState;
      if (state.hasError == false) {
        if (onSuccess != null) onSuccess();
      }
    } else {
      if (onSuccess != null) onSuccess();
    }
  }

  Future<AsyncValue> _startScan() async =>
      await AsyncValue.guard(bluetoothService.startScan);

  Future<AsyncValue> _stopScan() async =>
      await AsyncValue.guard(bluetoothService.stopScan);
}

final startStopButtonControllerProvider =
    StateNotifierProvider.autoDispose<ScanButtonController, AsyncValue<void>>(
        (ref) {
  return ScanButtonController(
    bluetoothService: ref.watch(bluetoothServiceProvider),
  );
});
