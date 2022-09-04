import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_blue/quick_blue.dart';
import 'package:string_to_color/string_to_color.dart';

import '../../../../constants/app_sizes.dart';
import '../../application/scan_bluetooth_service.dart';
import '../../domain/bluetooth.dart';
import 'rssi_icon.dart';

class BluetoothCardTile extends HookConsumerWidget {
  const BluetoothCardTile({
    required this.bluetooth,
    required this.index,
    this.onPressed,
    super.key,
  });
  final VoidCallback? onPressed;
  final Bluetooth bluetooth;
  final int index;

  // * Keys for testing using find.byKey()
  static const bluetoothCardKey = Key('bluetooth-card');
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final intRssi =
        ref.read(scanBluetoothServiceProvider).rssiCalculate(bluetooth.rssi);
    final showID = useState<bool>(false);

    return SizedBox(
      height: 80,
      child: Card(
        child: InkWell(
          key: bluetoothCardKey,
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(Sizes.p8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            ' ${index + 1}.  ',
                            style: textTheme.bodyText2!.copyWith(
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                          ),
                        ),
                        Material(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(30),
                            // onTap: () => onSubmit,

                            // crossFadeState: bluetooth.rssi > bluetooth.previousRssi!
                            //     ? CrossFadeState.showSecond
                            //     : CrossFadeState.showFirst,
                            // duration: const Duration(seconds: 1),
                            // canRequestFocus: bluetooth.previousRssi != null &&
                            //     bluetooth.rssi != bluetooth.previousRssi!,
                            splashColor: bluetooth.previousRssi != null &&
                                    bluetooth.rssi > bluetooth.previousRssi!
                                ? Colors.red.withOpacity(0.4)
                                : Colors.green.withOpacity(0.4),

                            child: Tooltip(
                              message: 'SIGNAL',
                              child: RssiIcon(
                                intRssi: intRssi,
                                rssiColor: rssiColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          bluetooth.userLabel != null
                              ? '🏷${bluetooth.userLabel!.name}'
                              : bluetooth.name.isNotEmpty && !showID.value
                                  ? bluetooth.name
                                  : Platform.isIOS || Platform.isMacOS
                                      ? '🆔 ${bluetooth.deviceId.substring(0, 8)}'
                                      : '🆔 ${bluetooth.deviceId}',
                          style: bluetooth.userLabel != null
                              ? textTheme.titleMedium!.copyWith()
                              : bluetooth.name.isNotEmpty
                                  ? textTheme.titleSmall
                                  : textTheme.titleSmall!.copyWith(
                                      color: ColorUtils.stringToColor(
                                        bluetooth.deviceId,
                                      ),
                                      fontFeatures: [
                                        const FontFeature.tabularFigures()
                                      ],
                                    ),
                        ),
                        Text(
                          ' ${intRssi <= 0 ? 1 : 99 <= intRssi ? 99 : intRssi}%',
                          style: textTheme.bodyMedium,
                        ),
                        // ConnectButton(bluetooth: bluetooth),
                      ],
                    ),
                  ],
                ),
                // Row(
                //   children: [
                //     if (bluetooth.name.isNotEmpty)
                //       Column(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           IconButton(
                //             tooltip: 'Change Name',
                //             padding: const EdgeInsets.symmetric(
                //               horizontal: Sizes.p8,
                //             ),
                //             splashRadius: 20,
                //             constraints: const BoxConstraints(),
                //             icon: const Icon(Icons.change_circle_outlined),
                //             onPressed: () => showID.value = !showID.value,
                //           ),
                //           const SizedBox(height: 1),
                //         ],
                //       ),
                //     gapW64,
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  MaterialColor? get rssiColor => bluetooth.previousRssi != null
      ? bluetooth.rssi > bluetooth.previousRssi!
          ? Colors.red
          : Colors.green
      : null;
}
