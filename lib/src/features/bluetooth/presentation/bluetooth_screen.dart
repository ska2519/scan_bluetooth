import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../constants/resources.dart';
import '../../../routing/scaffold_with_nav_bar.dart';
import '../../../utils/toast_context.dart';
import '../data/scan_bluetooth_repository.dart';
import 'bluetooth_off_screen.dart';
import 'device_grid/device_grid_screen.dart';

class BluetoothScreen extends HookConsumerWidget {
  const BluetoothScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      ref.read(fToastProvider).init(scaffoldGlobalKey.currentState!.context);
      return null;
    }, []);

    return AsyncValueWidget<BluetoothState>(
      value: ref.watch(bluetoothStateStreamProvider),
      data: (BluetoothState state) {
        return state == BluetoothState.on
            ? const DeviceGridScreen(true)
            : BluetoothOffScreen(state: state);
        // : const NoticeScreen('🔔 Turn on Bluetooth');
      },
    );
  }
}
