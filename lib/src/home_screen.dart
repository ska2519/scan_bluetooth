import 'dart:io';

import 'common_widgets/notice_screen.dart';
import 'constants/resources.dart';
import 'exceptions/error_logger.dart';
import 'features/bluetooth/data/scan_bluetooth_repository.dart';
import 'features/bluetooth/presentation/bluetooth_grid/bluetooth_grid_screen.dart';
import 'features/permission/application/permission_service.dart';

final globalKey = GlobalKey();

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
    logger.i('didChangeAppLifecycleState state: $state');
    if (state == AppLifecycleState.detached) return;
    final isBackgroud = state == AppLifecycleState.paused;
    logger.i('isBackgroud: $isBackgroud');
    if (!isBackgroud) {
      logger.i('Platform: ${Platform.operatingSystem}');
      if (Platform.isAndroid || Platform.isIOS) {
        ref.refresh(isBTAvailableProvider);
        ref.refresh(
            requestPermissionListProvider(defaultBluetoothPermissionList));
        // ref.read(interstitialAdStateProvider.notifier).update((state) => false);
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
      key: globalKey,
      body: AsyncValueWidget<bool>(
        value: ref.watch(isBTAvailableProvider),
        data: (bool isBluetoothAvailable) {
          if (Platform.isIOS) {
            return BluetoothGridScreen(isBluetoothAvailable);
          }
          return isBluetoothAvailable
              ? BluetoothGridScreen(isBluetoothAvailable)
              : const NoticeScreen('🔔 Turn on Bluetooth');
        },
      ),
    );
  }
}
