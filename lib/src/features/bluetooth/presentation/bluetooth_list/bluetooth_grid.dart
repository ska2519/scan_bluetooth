import 'dart:math';

import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_blue/models.dart';

import '../../../../common_widgets/async_value_widget.dart';
import '../../../../constants/resources.dart';
import '../../application/bluetooth_service.dart';
import 'bluetooth_card.dart';

class BluetoothGrid extends StatefulHookConsumerWidget {
  const BluetoothGrid({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BluetoothGridState();
}

class _BluetoothGridState extends ConsumerState<BluetoothGrid> {
  @override
  Widget build(BuildContext context) {
    final bluetoothListValue = ref.watch(bluetoothListStreamProvider);
    return AsyncValueWidget<List<BlueScanResult>>(
      value: bluetoothListValue,
      data: (bluetoothList) => bluetoothList.isEmpty
          ? Center(
              child: Text(
                'No Bluetooth found'.hardcoded,
                style: Theme.of(context).textTheme.headline4,
              ),
            )
          : BluetoothLayoutGrid(
              itemCount: bluetoothList.length,
              itemBuilder: (_, index) {
                final bluetooth = bluetoothList[index];
                return BluetoothCard(
                  index: index,
                  bluetooth: bluetooth,
                  // () =>
                  // context.goNamed(
                  //   AppRoute.bluetooth.name,
                  //   params: {'id': bluetooth.deviceId},
                  // ),
                );
              },
            ),
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
