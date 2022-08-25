import 'dart:io';

import 'common_widgets/notice_screen.dart';
import 'constants/resources.dart';
import 'features/bluetooth/data/bluetooth_repository.dart';
import 'features/bluetooth/presentation/bluetooth_list/bluetooth_list_screen.dart';
import 'features/permission/application/permission_service.dart';

class HomeScreen extends StatefulHookConsumerWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print('didChangeAppLifecycleState state: $state');
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) return;
    final isBackgroud = state == AppLifecycleState.paused;
    if (isBackgroud) {
    } else {
      ref.refresh(isBluetoothAvailableProvider);
      if (Platform.isAndroid || Platform.isIOS) {
        ref.refresh(
            requestPermissionListProvider(defaultBluetoothPermissionList));
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AsyncValueWidget<bool>(
        value: ref.watch(isBluetoothAvailableProvider),
        data: (bool isBluetoothAvailable) => isBluetoothAvailable
            ? BluetoothListScreen(isBluetoothAvailable)
            : const NoticeScreen('🔔 Turn on Bluetooth'),
      ),
    );
  }
}
