import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../../../../constants/resources.dart';
import 'floating_icon_button.dart';

class ConnectButton extends ConsumerWidget {
  const ConnectButton({
    super.key,
    required this.scanResult,
    this.connected = false,
  });

  final ScanResult scanResult;
  final bool connected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Visibility(
      // ref.read(scanDeviceServiceProvider).rssiCalculate(bluetooth.rssi) >
      //     50,
      child: Tooltip(
        triggerMode: TooltipTriggerMode.tap,
        message: 'CONNECT',
        child: Row(
          children: [
            FloatingIconButton(
              onPressed: scanResult.device.connect,
              // onPressed: () => ref.read(scanBluetoothServiceProvider).connect(),
              child: connected
                  ? Assets.svg.icons8Disconnected.svg(width: Sizes.p28)
                  : Assets.svg.icons8Connected.svg(width: Sizes.p28),
            ),
          ],
        ),
      ),
    );
  }
}
