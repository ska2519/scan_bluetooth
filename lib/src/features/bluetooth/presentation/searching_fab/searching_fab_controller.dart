import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../application/bluetooth_service.dart';

class SearchingFABController extends StateNotifier<AsyncValue<void>> {
  SearchingFABController({
    required this.bluetoothService,
  }) : super(const AsyncData(null));
  final BluetoothService bluetoothService;

  Future<void> submitScanButton(
    bool searching, {
    void Function()? onSuccess,
  }) async {
    state = const AsyncLoading();
    final newState = await _submitScan(searching);
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

  Future<AsyncValue> _submitScan(bool searching) async =>
      await AsyncValue.guard(() => bluetoothService.submitScan(searching));
}

final scanButtonStateProvider = StateProvider<bool>((ref) => false);

final searchingFABControllerProvider =
    StateNotifierProvider.autoDispose<SearchingFABController, AsyncValue<void>>(
        (ref) => SearchingFABController(
            bluetoothService: ref.watch(bluetoothServiceProvider)));
