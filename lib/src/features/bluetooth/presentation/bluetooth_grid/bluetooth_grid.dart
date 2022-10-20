import 'dart:math';

import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../constants/resources.dart';
import '../../../../utils/destination_item_index.dart';
import '../../../admob/presentation/native_ad_card.dart';
import '../../../in_app_purchase/application/purchases_service.dart';
import '../../application/scan_bluetooth_service.dart';
import '../../domain/bluetooth.dart';
import '../bluetooth_card/bluetooth_card.dart';
import '../scanning_fab/scanning_fab_controller.dart';
import 'bluetooth_grid_screen_controller.dart';
import 'bluetooth_layout_grid.dart';

class BluetoothGrid extends HookConsumerWidget {
  const BluetoothGrid({super.key});

  static const bluetootGridKey = Key('bluetooth-grid');

  void dismissOnScreenKeyboard(BuildContext context) {
    if (FocusScope.of(context).hasFocus) {
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      // ref
      //     .read(bluetoothServiceProvider)
      //     .textEditingCtr
      //     .addListener(() => dismissOnScreenKeyboard(context));
      return;
    }, []);

    return AsyncValueWidget<List<Bluetooth>>(
      value: ref.watch(bluetoothListStreamProvider),
      data: (bluetoothList) {
        final scanning = ref.watch(scanFABStateProvider);
        final removeAdsUpgrade = ref.watch(removeAdsUpgradeProvider);
        var kAdIndex = 1;
        if (bluetoothList.isNotEmpty && !scanning && !removeAdsUpgrade) {
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
                itemCount: !scanning && !removeAdsUpgrade
                    ? bluetoothList.length + adLength
                    : bluetoothList.length,
                itemBuilder: (_, index) {
                  final i = !scanning && !removeAdsUpgrade
                      ? getDestinationItemIndex(kAdIndex, index)
                      : index;

                  return !scanning && !removeAdsUpgrade && index == kAdIndex
                      ? const NativeAdCard(key: bluetootGridKey)
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
