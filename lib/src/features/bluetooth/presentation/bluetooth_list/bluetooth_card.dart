import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_blue/quick_blue.dart';

import '../../../../constants/app_sizes.dart';

/// Used to show a single product inside a card.
class BluetoothCard extends ConsumerWidget {
  const BluetoothCard({super.key, required this.bluetooth, this.onPressed});
  final BlueScanResult bluetooth;
  final VoidCallback? onPressed;

  // * Keys for testing using find.byKey()
  static const bluetoothCardKey = Key('bluetooth-card');

  String rssiCalculate(int rssi) => (100 - rssi.abs()).toStringAsFixed(0);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      child: InkWell(
        key: bluetoothCardKey,
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(Sizes.p16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                bluetooth.name.isNotEmpty ? bluetooth.name : 'Unknown',
                style: bluetooth.name.isNotEmpty
                    ? textTheme.bodyMedium
                    : textTheme.titleMedium!.copyWith(color: Colors.black45),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        'SIGNAL',
                        style: textTheme.caption,
                      ),
                      gapH4,
                      Text(
                        '📡 ${rssiCalculate(bluetooth.rssi)}%',
                        style: textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'CONNECTION',
                        style: textTheme.caption,
                      ),
                      IconButton(
                        onPressed: () {
                          QuickBlue.connect(bluetooth.deviceId);
                          print('QuickBlue.connect');
                          // QuickBlue.disconnect(bluetooth.deviceId);
                          // print('QuickBlue.disconnect');
                        },
                        iconSize: 16,
                        splashRadius: 16,
                        icon: const Icon(Icons.bluetooth_connected),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
