import 'dart:math';

import '../../../../constants/resources.dart';
import '../../../../utils/destination_item_index.dart';
import '../../../admob/presentation/native_ad_card.dart';
import '../../../in_app_purchase/application/purchases_service.dart';
import '../../application/bluetooth_service.dart';
import '../../domain/bluetooth.dart';
import '../bluetooth_card/bluetooth_card.dart';
import '../scanning_fab/scanning_fab_controller.dart';
import 'bluetooth_grid_screen_controller.dart';
import 'bluetooth_layout_grid.dart';

class BluetoothGrid extends HookConsumerWidget {
  const BluetoothGrid({super.key});
  static const bluetootGridKey = Key('bluetooth-grid');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// ** google Ads package support only 1 ADS now. **
    const adLength = 1;
    final scanning = ref.watch(scanFABStateProvider);
    final removeAds = ref.watch(removeAdsProvider);
    final bluetoothList = ref.watch(bluetoothListProvider);

    var kAdIndex = 1;
    if (bluetoothList.isNotEmpty && !scanning) {
      kAdIndex = Random()
          .nextInt(bluetoothList.length >= 7 ? 7 : bluetoothList.length);
    }

    return bluetoothList.isEmpty
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

              return BluetoothLayoutGrid(
                key: bluetootGridKey,
                itemCount: !removeAds && !scanning
                    ? bluetoothList.length + adLength
                    : bluetoothList.length,
                itemBuilder: (_, index) {
                  final i = !removeAds && !scanning
                      ? getItemIndex(kAdIndex, index)
                      : index;

                  return !scanning && (index == kAdIndex && !removeAds)
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
  }
}
