import 'dart:io';

import 'common_widgets/notice_screen.dart';
import 'constants/resources.dart';
import 'exceptions/error_logger.dart';
import 'features/admob/application/admob_service.dart';
import 'features/bluetooth/data/scan_bluetooth_repository.dart';
import 'features/bluetooth/presentation/bluetooth_grid/bluetooth_grid_screen.dart';
import 'features/permission/application/permission_service.dart';

GlobalKey globalKey = GlobalKey();

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
      if (Platform.isAndroid || Platform.isIOS) {
        logger.i('Platform: ${Platform.operatingSystem}');
        ref.refresh(isBTAvailableProvider);
        if (Platform.isAndroid) {
          ref.refresh(
              requestPermissionListProvider(defaultBluetoothPermissionList));
        }
      }
      if (ref.read(interstitialAdStateProvider)) {
        ref.read(interstitialAdStateProvider.notifier).update((state) => false);
        return;
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
        data: (bool isBluetoothAvailable) => isBluetoothAvailable
            ? BluetoothGridScreen(isBluetoothAvailable)
            : const NoticeScreen('🔔 Turn on Bluetooth'),
      ),
    );
  }
}
