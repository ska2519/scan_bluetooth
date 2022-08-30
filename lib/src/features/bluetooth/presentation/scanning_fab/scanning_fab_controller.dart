import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../admob/application/admob_service.dart';
import '../../application/scan_bt_service.dart';

class ScanningFABController extends StateNotifier<AsyncValue<void>> {
  ScanningFABController({
    required this.bluetoothService,
    this.admobService,
  }) : super(const AsyncData(null));
  final ScanBTService bluetoothService;
  final AdmobService? admobService;

  Future<void> submitScanning(
    bool scanning, {
    void Function()? onSuccess,
  }) async {
    state = const AsyncLoading();

    print('before newState state: $state');

    /// !! ref.watch(scanningFABControllerProvider)가 읽을 수 있게 state 전달할 딜레이 시간 필요
    await Future.delayed(const Duration(milliseconds: 100));

    await AsyncValue.guard(() => bluetoothService.updateScanFABState(scanning));

    final newState =
        await AsyncValue.guard(() => bluetoothService.submitScanning(scanning));
    await AsyncValue.guard(() => bluetoothService.toggleStopWatch(scanning));
    if (mounted) {
      // * only set the state if the controller hasn't been disposed
      // await AsyncValue.guard(
      //     () => bluetoothService.updateScanFABState(scanning));
      // await AsyncValue.guard(() => bluetoothService.toggleStopWatch(scanning));
      state = newState;
      if (!scanning && admobService != null) {
        admobService!.showInterstitialAd();
      }
      if (state.hasError == false) {
        if (onSuccess != null) onSuccess();
      } else {
        await AsyncValue.guard(
            () => bluetoothService.updateScanFABState(!scanning));
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
    bluetoothService: ref.read(scanBluetoothServiceProvider),
    admobService: Platform.isAndroid || Platform.isIOS
        ? ref.read(admobServiceProvider)
        : null,
  ),
);
