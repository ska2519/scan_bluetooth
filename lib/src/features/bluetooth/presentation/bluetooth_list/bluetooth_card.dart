import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:page_flip_builder/page_flip_builder.dart';
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageFlipKey = useMemoized(GlobalKey<PageFlipBuilderState>.new);

    useEffect(() {
      WidgetsBinding.instance
          .addPostFrameCallback((_) => pageFlipKey.currentState?.flip());
      return null;
    }, [bluetooth.deviceId]);

    return SizedBox(
      height: 80,
      child: PageFlipBuilder(
        nonInteractiveAnimationDuration: const Duration(milliseconds: 385),
        interactiveFlipEnabled: false,
        key: pageFlipKey,
        flipAxis: Axis.vertical,
        frontBuilder: (_) => BluetoothCardTile(bluetooth, index),
        backBuilder: (_) => BluetoothCardTile(bluetooth, index),
      ),
    );
  }
}

class BluetoothCardTile extends HookConsumerWidget {
  const BluetoothCardTile(
    this.bluetooth,
    this.index, {
    this.onPressed,
    super.key,
  });
  final VoidCallback? onPressed;
  final BlueScanResult bluetooth;
  final int index;

  // * Keys for testing using find.byKey()
  static const bluetoothCardKey = Key('bluetooth-card');
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final intRssi =
        ref.read(bluetoothServiceProvider).rssiCalculate(bluetooth.rssi);
    final showID = useState<bool>(false);

    return Card(
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
                      Text(
                        ' ${index + 1}.  ',
                        style: textTheme.bodyText2!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
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
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        bluetooth.name.isNotEmpty && !showID.value
                            ? bluetooth.name
                            : Platform.isIOS || Platform.isMacOS
                                ? '🆔 ${bluetooth.deviceId.substring(0, 8)}'
                                : '🆔 ${bluetooth.deviceId}',
                        style: bluetooth.name.isNotEmpty
                            ? textTheme.bodyMedium
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
              Row(
                children: [
                  Row(children: [
                    if (bluetooth.name.isNotEmpty)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            tooltip: 'Change Name',
                            padding: EdgeInsets.zero,
                            splashRadius: 24,
                            constraints: const BoxConstraints(),
                            icon: const Icon(Icons.change_circle_outlined),
                            onPressed: () => showID.value = !showID.value,
                          ),
                          const SizedBox(height: 1),
                        ],
                      )
                  ]),
                  gapW64,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ConnectButton extends ConsumerWidget {
  const ConnectButton({
    super.key,
    required this.bluetooth,
  });

  final BlueScanResult bluetooth;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Visibility(
      visible: false,
      child: Tooltip(
        message: 'CONNECT',
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
    );
  }
}
