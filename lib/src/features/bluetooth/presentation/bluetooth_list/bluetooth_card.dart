import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
                bluetooth.name.isNotEmpty
                    ? bluetooth.name
                    : bluetooth.deviceId.substring(0, 8),
                style: bluetooth.name.isNotEmpty
                    ? textTheme.bodyMedium
                    : textTheme.titleSmall!.copyWith(color: Colors.black38),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Tooltip(
                    message: 'SIGNAL',
                    child: Row(
                      children: [
                        if (bluetooth.rssi < 20)
                          const FaIcon(
                            FontAwesomeIcons.signal,
                            // color: Colors.blue,
                            size: Sizes.p12,
                            semanticLabel: 'SIGNAL',
                          ),
                        // gapW4,
                        Text(
                          ' ${rssiCalculate(bluetooth.rssi)}%',
                          style: textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  Tooltip(
                    message: 'CONNECTION',
                    child: Row(
                      children: [
                        // const FaIcon(
                        //   FontAwesomeIcons.signal,
                        //   // color: Colors.blue,
                        //   size: Sizes.p12,
                        //   semanticLabel: 'SIGNAL',
                        // ),
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
