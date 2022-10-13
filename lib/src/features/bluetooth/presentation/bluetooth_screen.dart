import '../../../common_widgets/notice_screen.dart';
import '../../../constants/resources.dart';
import '../../../utils/toast_context.dart';
import '../data/scan_bluetooth_repository.dart';
import 'bluetooth_grid/bluetooth_grid_screen.dart';

class BluetoothScreen extends HookConsumerWidget {
  const BluetoothScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DateTime? lastPressed;

    final fToast = ref.read(fToastProvider);

    return WillPopScope(
      onWillPop: () async {
        final now = DateTime.now();
        const maxDuration = Duration(seconds: 2);
        final isWarning =
            lastPressed == null || now.difference(lastPressed!) > maxDuration;

        if (isWarning) {
          lastPressed = DateTime.now();
          fToast.showToast(
              child: const ToastContext(
            'Double Tap to Closse App',
          ));
          return false;
        } else {
          return true;
        }
      },
      child: AsyncValueWidget<bool>(
        value: ref.watch(isBTAvailableProvider),
        data: (bool isBluetoothAvailable) {
          return isBluetoothAvailable || Platform.isIOS
              ? BluetoothGridScreen(isBluetoothAvailable)
              : const NoticeScreen('🔔 Turn on Bluetooth');
        },
      ),
    );
  }
}
