import 'package:quick_blue/quick_blue.dart';

import '../../../../constants/resources.dart';
import '../../application/scan_bluetooth_service.dart';
import '../../domain/bluetooth.dart';
import 'floating_icon_button.dart';

class ConnectButton extends ConsumerWidget {
  const ConnectButton({
    super.key,
    required this.bluetooth,
    required this.blueConnectionState,
  });

  final Bluetooth bluetooth;
  final BlueConnectionState blueConnectionState;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Visibility(
      visible:
          ref.read(scanBluetoothServiceProvider).rssiCalculate(bluetooth.rssi) >
              50,
      child: Tooltip(
        triggerMode: TooltipTriggerMode.tap,
        message: 'CONNECT',
        child: Row(
          children: [
            FloatingIconButton(
              onTapLabelEdit: () => ref
                  .read(scanBluetoothServiceProvider)
                  .connect(bluetooth.deviceId),
              child: blueConnectionState == BlueConnectionState.disconnected
                  ? Assets.svg.icons8Disconnected.svg(width: Sizes.p28)
                  : Assets.svg.icons8Connected.svg(width: Sizes.p28),
            ),
          ],
        ),
      ),
    );
  }
}
