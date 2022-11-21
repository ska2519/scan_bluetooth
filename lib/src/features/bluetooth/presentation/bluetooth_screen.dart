import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../common_widgets/notice_screen.dart';
import '../../../constants/resources.dart';
import '../../../routing/scaffold_with_nav_bar.dart';
import '../../../utils/toast_context.dart';
import '../data/scan_bluetooth_repository.dart';
import 'bluetooth_grid/bluetooth_grid_screen.dart';

class BluetoothScreen extends HookConsumerWidget {
  const BluetoothScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      ref.read(fToastProvider).init(scaffoldGlobalKey.currentState!.context);
      return null;
    }, []);

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
