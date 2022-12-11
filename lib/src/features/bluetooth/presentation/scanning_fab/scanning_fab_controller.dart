import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../admob/application/admob_service.dart';
import '../../../in_app_purchase/application/purchases_service.dart';
import '../../application/scan_device_service.dart';
import '../../domain/bluetooth_list.dart';

class ScanningFABController extends StateNotifier<AsyncValue<void>> {
  ScanningFABController(
    this.ref, {
    this.admobService,
  }) : super(const AsyncData(null));

  final AdmobService? admobService;
  final Ref ref;

  Future<void> showInterstitialAd(
    bool scanning, {
    void Function()? onSuccess,
  }) async {
    state = const AsyncLoading();
    if (mounted) {
      state = const AsyncData(null);
      if (!scanning &&
          admobService != null &&
          !admobService!.disableInterstitialAd) {
        admobService!.showInterstitialAd();
      }
      if (state.hasError == false) {
        if (onSuccess != null) onSuccess();
      }
    } else {
      if (onSuccess != null) onSuccess();
    }
  }

  Future<void> submit(bool scanning) async {
    if (scanning) {
      ref.invalidate(tempBluetoothListProvider);
      ref.read(bluetoothListProvider.notifier).removeAll();
    } else {
      await ref
          .read(scanningFABControllerProvider.notifier)
          .showInterstitialAd(scanning);
      ref.read(tempBluetoothListProvider.notifier).state =
          ref.read(bluetoothListProvider);
    }
    ref.read(scanningProvider.notifier).state = scanning;
    ref.read(scanDeviceServiceProvider).submitScanning(scanning);
  }
}

final scanningProvider = StateProvider<bool>((ref) => false);

final scanningFABControllerProvider =
    StateNotifierProvider.autoDispose<ScanningFABController, AsyncValue<void>>(
        (ref) {
  final removeAdsUpgrade = ref.watch(removeAdsProvider);

  ref.onDispose(() {
    ref.read(tempBluetoothListProvider.notifier).state =
        ref.read(bluetoothListProvider);
    ref.read(scanningProvider.notifier).state = false;
  });
  return ScanningFABController(
    ref,
    admobService: (Platform.isAndroid || Platform.isIOS) && !removeAdsUpgrade
        ? ref.watch(admobServiceProvider)
        : null,
  );
});
