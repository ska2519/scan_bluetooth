import 'dart:math';

import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:quick_blue/models.dart';

import '../../../../constants/resources.dart';
import '../../../admob/application/admob_service.dart';
import '../../../admob/presentation/native_ad_card.dart';
import '../../application/bluetooth_service.dart';
import '../scanning_fab/scanning_fab_controller.dart';
import 'bluetooth_card.dart';

class BluetoothGrid extends HookConsumerWidget {
  const BluetoothGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bluetoothListValue = ref.watch(bluetoothListStreamProvider);
    final scanning = ref.watch(scanFABStateProvider);
    final interstitialAdState = ref.watch(interstitialAdStateProvider);
    final nativeAd = ref.watch(nativeAdProvider(key));

    return AsyncValueWidget<List<BlueScanResult>>(
      value: bluetoothListValue,
      data: (bluetoothList) {
        var kAdIndex = 1;
        if (bluetoothList.isNotEmpty && !scanning && nativeAd != null) {
          kAdIndex = Random()
              .nextInt(bluetoothList.length > 7 ? 7 : bluetoothList.length - 1);
        }

        int _getDestinationItemIndex(int rawIndex) {
          const adCount = 1;
          // final adCount = rawIndex ~/ kAdIndex;
          return rawIndex > kAdIndex ? rawIndex - adCount : rawIndex;
        }

        const adLength = 1;
        // final adLength = bluetoothList.length ~/ kAdIndex;
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
                  return !scanning &&
                          !interstitialAdState &&
                          nativeAd != null &&
                          index == kAdIndex
                      // (index != 0 && index % kAdIndex == 0)
                      ? NativeAdCard(
                          nativeAd: nativeAd,
                          // nativeAdKey: UniqueKey(),
                        )
                      : BluetoothCard(
                          index: index,
                          bluetooth: !scanning
                              ? bluetoothList[_getDestinationItemIndex(index)]
                              : bluetoothList[index],
                          // () =>
                          // context.goNamed(
                          //   AppRoute.bluetooth.name,
                          //   params: {'id': bluetooth.deviceId},
                          // ),
                        );
                },
              );
      },
    );
  }
}

/// Grid widget with content-sized items.
/// See: https://codewithandrea.com/articles/flutter-layout-grid-content-sized-items/
class BluetoothLayoutGrid extends StatelessWidget {
  const BluetoothLayoutGrid({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
  });

  /// Total number of items to display.
  final int itemCount;

  /// Function used to build a widget for a given index in the grid.
  final Widget Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    // use a LayoutBuilder to determine the crossAxisCount
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      // 1 column for width < 500px
      // then add one more column for each 250px
      final crossAxisCount = max(1, width ~/ 250);
      // once the crossAxisCount is known, calculate the column and row sizes
      // set some flexible track sizes based on the crossAxisCount with 1.fr
      final columnSizes = List.generate(crossAxisCount, (_) => 1.fr);
      final numRows = (itemCount / crossAxisCount).ceil();
      // set all the row sizes to auto (self-sizing height)
      final rowSizes = List.generate(numRows, (_) => auto);
      // Custom layout grid. See: https://pub.dev/packages/flutter_layout_grid
      return LayoutGrid(
        columnSizes: columnSizes,
        rowSizes: rowSizes,
        // rowGap: Sizes.p4, // equivalent to mainAxisSpacing
        // columnGap: Sizes.p24, // equivalent to crossAxisSpacing
        children: [
          // render all the items with automatic child placement
          for (var i = 0; i < itemCount; i++) itemBuilder(context, i),
        ],
      );
    });
  }
}
