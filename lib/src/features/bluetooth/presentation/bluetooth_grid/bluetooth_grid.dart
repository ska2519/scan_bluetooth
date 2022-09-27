import 'dart:math';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../../constants/resources.dart';
import '../../../../utils/destination_item_index.dart';
import '../../../../utils/dismiss_on_screen_keyboard.dart';
import '../../../admob/application/admob_service.dart';
import '../../../admob/presentation/native_ad_card.dart';
import '../../application/bluetooth_service.dart';
import '../../application/scan_bluetooth_service.dart';
import '../../domain/bluetooth.dart';
import '../bluetooth_card/bluetooth_card.dart';
import '../scanning_fab/scanning_fab_controller.dart';
import 'bluetooth_grid_screen_controller.dart';
import 'bluetooth_layout_grid.dart';

class BluetoothGrid extends HookConsumerWidget {
  const BluetoothGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      ref
          .read(bluetoothServiceProvider)
          .textEditingCtr
          .addListener(() => dismissOnScreenKeyboard(context));
      return null;
    }, []);

    return AsyncValueWidget<List<Bluetooth>>(
      value: ref.watch(bluetoothListStreamProvider),
      data: (bluetoothList) {
        final scanning = ref.watch(scanFABStateProvider);
        final interstitialAdState = ref.watch(interstitialAdStateProvider);
        late final NativeAd? nativeAd;
        if (!scanning) {
          nativeAd = ref.watch(nativeAdProvider(key));
        }

        final nativeAdState = ref.watch(nativeAdStateProvider);

        var kAdIndex = 1;
        if (bluetoothList.isNotEmpty && !scanning && nativeAd != null) {
          kAdIndex = Random()
              .nextInt(bluetoothList.length >= 7 ? 7 : bluetoothList.length);
        }

        /// ** google Ads package support only 1 ADS now. **
        const adLength = 1;
        return bluetoothList.isEmpty
            ? Center(
                child: Text(
                  'No Bluetooth found'.hardcoded,
                  style: Theme.of(context).textTheme.headline4,
                ),
              )
            : BluetoothLayoutGrid(
                itemCount: !scanning && !interstitialAdState && nativeAd != null
                    ? bluetoothList.length + adLength
                    : bluetoothList.length,
                itemBuilder: (_, index) {
                  final i = !scanning
                      ? getDestinationItemIndex(kAdIndex, index)
                      : index;

                  return nativeAdState &&
                          !interstitialAdState &&
                          nativeAd != null &&
                          index == kAdIndex
                      ? NativeAdCard(nativeAd)
                      : BluetoothCard(
                          onTapLabelEdit: () async => await ref
                              .read(bluetoothGridScreenControllerProvider
                                  .notifier)
                              .onTapTile(bluetoothList[i], context),
                          bluetooth: bluetoothList[i],
                          index: i,
                        );
                },
              );
      },
    );
  }
}
