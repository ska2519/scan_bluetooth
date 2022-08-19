import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_blue/quick_blue.dart';
import 'package:string_to_color/string_to_color.dart';

import '../../../../../generated/flutter_gen/assets.gen.dart';
import '../../../../constants/app_sizes.dart';
import '../../application/bluetooth_service.dart';

/// Used to show a single product inside a card.
class BluetoothCard extends HookConsumerWidget {
  const BluetoothCard({
    super.key,
    required this.index,
    required this.bluetooth,
    this.onPressed,
  });
  final int index;
  final BlueScanResult bluetooth;
  final VoidCallback? onPressed;

  // * Keys for testing using find.byKey()
  static const bluetoothCardKey = Key('bluetooth-card');

  int rssiCalculate(int rssi) => (120 - rssi.abs());

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final intRssi = rssiCalculate(bluetooth.rssi);
    return Card(
      child: InkWell(
        key: bluetoothCardKey,
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(Sizes.p16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Text(
                    ' ${index + 1}. ',
                    style: textTheme.bodyText2!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    bluetooth.name.isNotEmpty
                        ? bluetooth.name
                        : Platform.isIOS || Platform.isMacOS
                            ? '🆔 ${bluetooth.deviceId.substring(0, 8)}'
                            : '🆔 ${bluetooth.deviceId}',
                    style: bluetooth.name.isNotEmpty
                        ? textTheme.bodyMedium
                        : textTheme.titleSmall!.copyWith(
                            color: ColorUtils.stringToColor(bluetooth.deviceId),
                          ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Tooltip(
                    message: 'SIGNAL',
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (intRssi < 20)
                          Assets.svg.icSignalWeakSka144.svg(width: 30)
                        else if (20 <= intRssi && intRssi < 40)
                          Assets.svg.icSignalFairSka144.svg(width: 30)
                        else if (40 <= intRssi && intRssi < 60)
                          Assets.svg.icSignalGoodSka144.svg(width: 30)
                        else if (60 <= intRssi && intRssi < 80)
                          Assets.svg.icSignalStrongSka144.svg(width: 30)
                        else if (80 <= intRssi)
                          Assets.svg.icSignalSka144.svg(width: 30),
                        Text(
                          ' ${intRssi <= 0 ? 1 : 99 <= intRssi ? 99 : intRssi}%',
                          style: textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: false,
                    child: Tooltip(
                      message: 'CONNECTION',
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () => ref
                                .read(bluetoothServiceProvider)
                                .connect(bluetooth.deviceId),
                            iconSize: 16,
                            splashRadius: 16,
                            icon: const Icon(Icons.bluetooth_connected),
                          ),
                        ],
                      ),
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
