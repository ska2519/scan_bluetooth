import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../admob/application/admob_service.dart';
import '../../application/scan_bluetooth_service.dart';

class ScanningFABController extends StateNotifier<AsyncValue<void>> {
  ScanningFABController({
    required this.bluetoothService,
    this.admobService,
  }) : super(const AsyncData(null));
  final ScanBluetoothService bluetoothService;
  final AdmobService? admobService;

  Future<void> showInterstitialAd(
    bool scanning, {
    void Function()? onSuccess,
  }) async {
    state = const AsyncLoading();
    if (mounted) {
      state = const AsyncData(null);
      if (!scanning && admobService != null) {
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
    bluetoothService: ref.read(scanBluetoothServiceProvider),
    admobService: Platform.isAndroid || Platform.isIOS
        ? ref.read(admobServiceProvider)
        : null,
  ),
);
