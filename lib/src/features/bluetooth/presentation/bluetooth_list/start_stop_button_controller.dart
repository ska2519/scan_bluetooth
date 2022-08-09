import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../application/bluetooth_service.dart';

class StartStopButtonController extends StateNotifier<AsyncValue<void>> {
  StartStopButtonController({
    required this.bluetoothService,
  }) : super(const AsyncData(null));
  final BluetoothService bluetoothService;

  Future<void> submitStartScan({
    void Function()? onSuccess,
  }) async {
    state = const AsyncLoading();
    final newState = await AsyncValue.guard(bluetoothService.startScan);
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

  Future<void> submitStopScan({
    void Function()? onSuccess,
  }) async {
    state = const AsyncLoading();
    final newState = await AsyncValue.guard(bluetoothService.stopScan);
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
}

final startStopButtonControllerProvider = StateNotifierProvider.autoDispose<
    StartStopButtonController, AsyncValue<void>>((ref) {
  return StartStopButtonController(
    bluetoothService: ref.watch(bluetoothServiceProvider),
  );
});
