import 'dart:io';
import 'dart:ui';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:string_to_color/string_to_color.dart';

import '../../../../constants/resources.dart';
import '../../application/scan_bluetooth_service.dart';
import '../../domain/bluetooth.dart';
import '../scanning_fab/scanning_fab_controller.dart';
import 'rssi_icon.dart';

class BluetoothTile extends HookConsumerWidget {
  const BluetoothTile({
    super.key,
    required this.index,
    required this.bluetooth,
    required this.onTapLabelEdit,
  });

  final int index;
  final Bluetooth bluetooth;

  final VoidCallback onTapLabelEdit;

  Color? get rssiAnimationColor => bluetooth.previousRssi != null
      ? bluetooth.rssi > bluetooth.previousRssi!
          ? Colors.green.withOpacity(0.1)
          : bluetooth.rssi < bluetooth.previousRssi!
              ? Colors.red.withOpacity(0.1)
              : null
      : null;

  MaterialColor? get rssiColor => bluetooth.previousRssi != null
      ? bluetooth.rssi > bluetooth.previousRssi!
          ? Colors.green
          : Colors.red
      : null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showID = useState<bool>(false);
    final controller = useAnimationController(
      duration: const Duration(milliseconds: 300),
    );

    final scanning = ref.watch(scanFABStateProvider);
    final animation = useAnimation(
        ColorTween(begin: rssiAnimationColor, end: Colors.transparent)
            .animate(controller));

    useEffect(() {
      controller.forward();
      controller.reset();
      return null;
    }, [bluetooth.previousRssi]);

    final intRssi =
        ref.read(scanBluetoothServiceProvider).rssiCalculate(bluetooth.rssi);
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  ' ${index + 1}.',
                  style: textTheme.bodyText2!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                AnimatedBuilder(
                  animation: controller,
                  builder: (context, child) => Container(
                    padding: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: scanning ? animation : Colors.transparent,
                    ),
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
                Flexible(
                  child: Row(
                    children: [
                      if (bluetooth.userLabel != null)
                        Assets.svg.icons8Tag.svg(width: Sizes.p20),
                      gapW4,
                      Text(
                        bluetooth.userLabel != null
                            ? bluetooth.userLabel!.name
                            : bluetooth.name.isNotEmpty && !showID.value
                                ? bluetooth.name
                                : Platform.isIOS || Platform.isMacOS
                                    ? '🆔 ${bluetooth.deviceId.substring(0, 8)}'
                                    : '🆔 ${bluetooth.deviceId}',
                        style: bluetooth.userLabel != null
                            ? textTheme.titleMedium!
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
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      if (bluetooth.userLabel != null &&
                          ref
                                  .read(scanBluetoothServiceProvider)
                                  .rssiCalculate(bluetooth.userLabel!.rssi) >
                              70)
                        Padding(
                          padding: const EdgeInsets.only(left: Sizes.p4),
                          child: Assets.svg.icons8VerifiedAccount
                              .svg(width: Sizes.p20),
                        ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ' ${intRssi <= 0 ? 1 : 99 <= intRssi ? 99 : intRssi}%',
                      style: textTheme.bodyMedium,
                    ),
                    gapW24,
                    // if (bluetooth.userLabel != null)
                    //   Text(bluetooth.userLabel.labelCount.toString()),
                  ],
                ),
                // ConnectButton(bluetooth: bluetooth),
              ],
            ),
          ],
        ),
        if (intRssi > 50)
          FloatingActionButton(
            elevation: 1,
            onPressed: onTapLabelEdit,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black87,
            mini: true,
            heroTag: null,
            shape: const CircleBorder(),
            splashColor: Colors.lightBlueAccent,
            child: bluetooth.userLabel != null
                ? Assets.svg.icons8UpdateTag.svg(width: Sizes.p28)
                : Assets.svg.icons8AddTag.svg(width: Sizes.p28),
          ),
        // Fab.icon(
        //     onPressed: onTapLabelEdit,
        //     icon: LineIcon.pen(),
        //     label: const Text('')),
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
    );
  }
}
