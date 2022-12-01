import 'dart:ui';

import 'package:badges/badges.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:string_to_color/string_to_color.dart';

import '../../../../constants/resources.dart';
import '../../application/scan_bluetooth_service.dart';
import '../../domain/bluetooth.dart';
import '../scanning_fab/scanning_fab_controller.dart';
import 'floating_icon_button.dart';
import 'rssi_icon.dart';

class BluetoothTile extends HookConsumerWidget {
  const BluetoothTile({
    super.key,
    this.index,
    required this.bluetooth,
    this.onPressed,
  });

  final int? index;
  final Bluetooth bluetooth;
  final VoidCallback? onPressed;

  Color? get rssiAnimationColor => bluetooth.previousRssi != null
      ? bluetooth.rssi > bluetooth.previousRssi!
          ? Colors.green.withOpacity(0.1)
          : bluetooth.rssi < bluetooth.previousRssi!
              ? Colors.red.withOpacity(0.1)
              : bluetooth.rssi == bluetooth.previousRssi
                  ? null
                  : null
      : Colors.blueAccent.withOpacity(0.1);

  Color? get rssiColor => bluetooth.previousRssi != null
      ? bluetooth.rssi > bluetooth.previousRssi!
          ? Colors.green
          : bluetooth.rssi < bluetooth.previousRssi!
              ? Colors.red
              : bluetooth.rssi == bluetooth.previousRssi
                  ? null
                  : null
      : Colors.blueAccent;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scanning = ref.watch(scanFABStateProvider);
    final showID = useState<bool>(false);
    final controller = useAnimationController(
      duration: const Duration(seconds: 1),
    );

    final animationColor =
        useAnimation(ColorTween(begin: rssiAnimationColor).animate(controller));

    useEffect(() {
      controller.addStatusListener((status) {
        if (bluetooth.previousRssi != null) {
          logger.i('bluetooth.previousRssi != null');
          controller.forward();
        }
        if (status == AnimationStatus.completed) {
          logger.i('status == AnimationStatus.completed');
          controller.reset();
        }
      });
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
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (index != null)
                  Text(
                    ' ${index! + 1}.',
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
                      color: scanning ? animationColor : null,
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                            ? textTheme.bodyLarge!
                            : bluetooth.name.isNotEmpty
                                ? textTheme.bodyMedium
                                : textTheme.bodyMedium!.copyWith(
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
                          ref.read(scanBluetoothServiceProvider).rssiCalculate(
                                  bluetooth.userLabel!.bluetooth.rssi) >
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
              ],
            ),
          ],
        ),
        Badge(
          showBadge: false,
          // showBadge: bluetooth.userLabel != null
          //     ? bluetooth.userLabel!.bluetooth.labelCount > 0
          //     : false,
          animationType: BadgeAnimationType.scale,
          elevation: 1,
          badgeColor: theme.colorScheme.primaryContainer,
          position: BadgePosition.bottomEnd(bottom: 0, end: 0),
          badgeContent: Text(
            bluetooth.labelCount > 0 ? bluetooth.labelCount.toString() : '',
            style: textTheme.caption!.copyWith(
              color: theme.colorScheme.onPrimaryContainer,
            ),
          ),
          child: FloatingIconButton(
            onPressed: onPressed,
            child: bluetooth.userLabel != null
                ? Assets.svg.icons8UpdateTag.svg(width: Sizes.p28)
                : Assets.svg.icons8AddTag.svg(width: Sizes.p28),
          ),
        ),
      ],
    );
  }
}
