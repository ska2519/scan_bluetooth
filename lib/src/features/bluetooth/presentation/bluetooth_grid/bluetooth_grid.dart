import 'dart:math';

import '../../../../common_widgets/loading_stack_body.dart';
import '../../../../constants/resources.dart';
import '../../../../utils/destination_item_index.dart';
import '../../../admob/presentation/native_ad_card.dart';
import '../../../in_app_purchase/application/purchases_service.dart';
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
    ref.listen<AsyncValue>(
      bluetoothGridScreenControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final state = ref.watch(bluetoothGridScreenControllerProvider);

    /// ** google Ads package support only 1 ADS now. **
    const adLength = 1;
    final scanning = ref.watch(scanFABStateProvider);
    final removeAds = ref.watch(removeAdsProvider);
    final bluetoothList = ref.watch(bluetoothListProvider);
    // final blueConnectionStateStream = ref.watch(blueConnectionStateStreamProvider);
    var kAdIndex = 1;
    if (!scanning && bluetoothList.isNotEmpty) {
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
        : LoadingStackBody(
            isLoading: state.isLoading,
            child: BluetoothLayoutGrid(
              key: bluetootGridKey,
              itemCount: !scanning && !removeAds
                  ? bluetoothList.length + adLength
                  : bluetoothList.length,
              itemBuilder: (_, index) {
                final i = !scanning && !removeAds
                    ? getItemIndex(kAdIndex, index)
                    : index;

                return !scanning && (index == kAdIndex && !removeAds)
                    ? const NativeAdCard()
                    : BluetoothCard(
                        onTapLabelEdit: () async => await ref
                            .read(
                                bluetoothGridScreenControllerProvider.notifier)
                            .onTapTile(bluetoothList[i], context),
                        bluetooth: bluetoothList[i],
                        index: i,
                      );
              },
            ),
          );
  }
}
