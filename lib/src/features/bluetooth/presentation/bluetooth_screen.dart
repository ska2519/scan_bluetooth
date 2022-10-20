import '../../../common_widgets/notice_screen.dart';
import '../../../constants/resources.dart';
import '../data/scan_bluetooth_repository.dart';
import 'bluetooth_grid/bluetooth_grid_screen.dart';

class BluetoothScreen extends HookConsumerWidget {
  const BluetoothScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueWidget<bool>(
      value: ref.watch(isBTAvailableProvider),
      data: (bool isBluetoothAvailable) {
        return isBluetoothAvailable || Platform.isIOS
            ? BluetoothGridScreen(isBluetoothAvailable)
            : const NoticeScreen('🔔 Turn on Bluetooth');
      },
    );
  }
}
