import 'package:quick_blue/quick_blue.dart';

import '../../../../constants/resources.dart';
import '../../data/scan_bluetooth_repository.dart';
import '../../domain/bluetooth.dart';
import 'connect_button.dart';

class BluetoothDetailTile extends HookConsumerWidget {
  const BluetoothDetailTile(this.bluetooth, {super.key});
  final Bluetooth bluetooth;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Row(
      children: [
        Flexible(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '🆔 ${bluetooth.deviceId}',
                style: textTheme.bodyMedium,
              ),
              RichText(
                text: TextSpan(
                  text: 'Manufacturer : ',
                  style: textTheme.caption!.copyWith(
                    overflow: TextOverflow.ellipsis,
                  ),
                  children: [
                    TextSpan(
                      text: bluetooth.manufacturerData.toString(),
                    ),
                    // const TextSpan(text: ' permission'),
                  ],
                ),
                maxLines: 1,
              ),
            ],
          ),
        ),
        AsyncValueWidget<BlueConnectionState>(
            value: ref.watch(blueConnectionStateStreamProvider),
            data: (connectionState) {
              logger.i('connectionState: ${connectionState.value}');
              return ConnectButton(
                bluetooth: bluetooth,
                blueConnectionState: connectionState,
              );
            }),
      ],
    );
  }
}
