import 'dart:math';

import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../constants/resources.dart';
import '../../../../utils/destination_item_index.dart';
import '../../../admob/presentation/native_ad_card.dart';
import '../../../in_app_purchase/application/purchases_service.dart';
import '../../application/bluetooth_service.dart';
import '../../application/scan_bluetooth_service.dart';
import '../../domain/bluetooth.dart';
import '../bluetooth_card/bluetooth_card.dart';
import '../scanning_fab/scanning_fab_controller.dart';
import 'bluetooth_grid_screen_controller.dart';
import 'bluetooth_layout_grid.dart';

class BluetoothGrid extends HookConsumerWidget {
  const BluetoothGrid({super.key});

  static const bluetootGridKey = Key('bluetooth-grid');

  // void dismissOnScreenKeyboard(BuildContext context) {
  //   if (FocusScope.of(context).hasFocus) {
  //     FocusScope.of(context).unfocus();
  //   }
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.listen<AsyncValue>(
    //   bluetoothGridScreenControllerProvider,
    //   (_, state) => state.showAlertDialogOnError(context),
    // );
    // final state = ref.watch(bluetoothGridScreenControllerProvider);

    useEffect(() {
      // ref
      //     .read(bluetoothServiceProvider)
      //     .textEditingCtr
      //     .addListener(() => dismissOnScreenKeyboard(context));

      return;
    }, []);

    /// ** google Ads package support only 1 ADS now. **
    const adLength = 1;
    final scanning = ref.watch(scanFABStateProvider);
    final removeAdsUpgrade = ref.watch(removeAdsUpgradeProvider);
    logger.i(
        'BluetoothGrid scanning $scanning / removeAdsUpgrade: $removeAdsUpgrade');
    // return AsyncValueWidget(
    //   value: ref.watch(bluetoothStreamProvider),
    //   data: (bluetooth) {
    final bluetoothList = ref.watch(bluetoothListProvider);

    var kAdIndex = 1;
    if (bluetoothList.isNotEmpty && !scanning && !removeAdsUpgrade) {
      kAdIndex = Random()
          .nextInt(bluetoothList.length >= 7 ? 7 : bluetoothList.length);
    }
    // logger.i('bluetooth: $bluetooth');
    return
        // if (state.isLoading) const LoadingAnimation(),
        bluetoothList.isEmpty
            ? Center(
                child: Text(
                  'No Bluetooth found'.hardcoded,
                  style: Theme.of(context).textTheme.headline4,
                ),
              )
            : Consumer(
                builder: (context, ref, child) {
                  final labelFirst = ref.watch(labelFirstProvider);
                  final labelList = ref.watch(userLabelListStreamProvider);

                  labelList.whenData((labelList) {
                    if (labelList.isNotEmpty) {
                      for (var label in labelList) {
                        for (var i = 0; i < bluetoothList.length; i++) {
                          if (bluetoothList[i].deviceId ==
                              label.bluetooth.deviceId) {
                            bluetoothList[i] = bluetoothList[i].copyWith(
                              userLabel: label,
                            );
                            break;
                          }
                        }
                      }
                    }
                    if (labelFirst) {
                      bluetoothList.sort((a, b) => b.userLabel != null ? 1 : 0);
                    }
                  });

                  // WidgetsBinding.instance.addPostFrameCallback((_) {
                  // labelList.whenData((labelList) => ref
                  //     .read(bluetoothListProvider.notifier)
                  //     .labelFrist(labelFirst, labelList));
                  // });

                  return BluetoothLayoutGrid(
                    key: bluetootGridKey,
                    itemCount: !scanning && !removeAdsUpgrade
                        ? bluetoothList.length + adLength
                        : bluetoothList.length,
                    itemBuilder: (_, index) {
                      final i = !scanning && !removeAdsUpgrade
                          ? getDestinationItemIndex(kAdIndex, index)
                          : index;

                      return !scanning && !removeAdsUpgrade && index == kAdIndex
                          ? const NativeAdCard()
                          : BluetoothCard(
                              onTapLabelEdit: () async {
                                logger.i('onTapLabelEdit');
                                await ref
                                    .read(bluetoothGridScreenControllerProvider
                                        .notifier)
                                    .onTapTile(bluetoothList[i], context);
                              },
                              bluetooth: bluetoothList[i],
                              index: i,
                            );
                    },
                  );
                },
              );

    // },
    // );
  }
}
