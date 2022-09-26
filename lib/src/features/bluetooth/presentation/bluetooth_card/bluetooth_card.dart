import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:page_flip_builder/page_flip_builder.dart';

import '../../../../constants/app_sizes.dart';
import '../../domain/bluetooth.dart';
import 'bluetooth_detail_tile.dart';
import 'bluetooth_tile.dart';

class BluetoothCard extends HookConsumerWidget {
  const BluetoothCard({
    required this.bluetooth,
    required this.index,
    required this.onTapLabelEdit,
    super.key,
  });

  final VoidCallback onTapLabelEdit;
  final Bluetooth bluetooth;
  final int index;

  // * Keys for testing using find.byKey()
  static const bluetoothCardKey = Key('bluetooth-card');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageFlipKey = useMemoized(GlobalKey<PageFlipBuilderState>.new);

    return SizedBox(
      height: 84,
      child: InkWell(
        onTap: () => pageFlipKey.currentState?.flip(),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(Sizes.p8),
            child: PageFlipBuilder(
              key: pageFlipKey,
              flipAxis: Axis.vertical,
              frontBuilder: (_) => BluetoothTile(
                index: index,
                bluetooth: bluetooth,
                onTapLabelEdit: onTapLabelEdit,
              ),
              backBuilder: (_) => BluetoothDetailTile(bluetooth),
            ),
          ),
        ),
      ),
    );
  }
}
