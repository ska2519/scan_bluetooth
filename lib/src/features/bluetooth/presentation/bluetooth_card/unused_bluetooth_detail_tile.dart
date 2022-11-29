// ignore_for_file: depend_on_referenced_packages

import 'package:convert/convert.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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
    void handleConnectionChange(String deviceId, BlueConnectionState state) {
      logger.i('handleConnectionChange $deviceId, ${state.value}');
      if (state.value == BlueConnectionState.connected.value) {
        ref.read(scanBluetoothRepoProvider).discoverServices(deviceId);
      }
    }

    void handleServiceDiscovery(
        String deviceId, String serviceId, List<String> characteristicIds) {
      logger.i('handleServiceDiscovery $deviceId, $serviceId');
      logger.i(
          'handleServiceDiscovery characteristicIds ${characteristicIds.map((e) => e).toList()}');
    }

    void handleValueChange(
        String deviceId, String characteristicId, Uint8List value) {
      logger.i(
          'handleValueChange $deviceId, $characteristicId, ${hex.encode(value)}');
    }

    useEffect(() {
      QuickBlue.setConnectionHandler(handleConnectionChange);
      QuickBlue.setServiceHandler(handleServiceDiscovery);
      QuickBlue.setValueHandler(handleValueChange);
      return null;
    }, [bluetooth.deviceId]);

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
        ConnectButton(
          bluetooth: bluetooth,
          connected:
              true, // blueConnectionState == BlueConnectionState.disconnected,
        ),
      ],
    );
  }
}
