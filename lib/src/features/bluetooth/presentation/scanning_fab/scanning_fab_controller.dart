import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../exceptions/error_logger.dart';
import '../../../admob/application/admob_service.dart';
import '../../../in_app_purchase/application/purchases_service.dart';
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
    StateNotifierProvider.autoDispose<ScanningFABController, AsyncValue<void>>(
        (ref) {
  final removeAdsUpgrade = ref.watch(removeAdsUpgradeProvider);
  logger.i('scanningFABControllerProvider removeAdsUpgrade: $removeAdsUpgrade');
  return ScanningFABController(
    bluetoothService: ref.read(scanBluetoothServiceProvider),
    admobService: (Platform.isAndroid || Platform.isIOS) && !removeAdsUpgrade
        ? ref.read(admobServiceProvider)
        : null,
  );
});
