import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../admob/application/admob_service.dart';
import '../../application/bluetooth_service.dart';

class ScanningFABController extends StateNotifier<AsyncValue<void>> {
  ScanningFABController({
    required this.bluetoothService,
    this.admobService,
  }) : super(const AsyncData(null));
  final BluetoothService bluetoothService;
  final AdmobService? admobService;

  Future<void> submitScanning(
    bool scanning, {
    void Function()? onSuccess,
  }) async {
    state = const AsyncLoading();

    /// !! ref.watch(scanningFABControllerProvider)가 읽을 수 있게 state 전달할 딜레이 시간 필요
    await Future.delayed(const Duration(milliseconds: 100));

    print('before newState state: $state');
    final newState =
        await AsyncValue.guard(() => bluetoothService.submitScanning(scanning));

    if (newState.hasError == false) {
      await AsyncValue.guard(
          () => bluetoothService.updateScanFABState(scanning));
      await AsyncValue.guard(() => bluetoothService.toggleStopWatch(scanning));
    }

    if (mounted) {
      // * only set the state if the controller hasn't been disposed
      state = newState;
      print('after newState state: $state');
      if (!scanning && admobService != null) {
        print('scanning: $scanning');
        admobService!.showInterstitialAd();
      }
      if (state.hasError == false) {
        if (onSuccess != null) onSuccess();
      }
    } else {
      if (onSuccess != null) onSuccess();
    }
  }
}

final scanFABStateProvider = StateProvider<bool>((ref) => false);

final scanningFABControllerProvider =
    StateNotifierProvider<ScanningFABController, AsyncValue<void>>(
  (ref) => ScanningFABController(
    bluetoothService: ref.read(bluetoothServiceProvider),
    admobService: Platform.isAndroid || Platform.isIOS
        ? ref.read(admobServiceProvider)
        : null,
  ),
);
