import 'package:quick_blue/models.dart';

import '../../../../constants/resources.dart';
import '../../application/scan_bluetooth_service.dart';

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
                  .read(scanBluetoothServiceProvider)
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
