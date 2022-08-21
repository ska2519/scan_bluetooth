import 'package:duration/duration.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../constants/resources.dart';
import '../../../../utils/async_value_ui.dart';
import '../../../permission/presentation/request_permission_dialog.dart';
import '../../application/bluetooth_service.dart';
import '../bluetooth_list/animation_searching_icon.dart';
import 'searching_fab_controller.dart';

class SearchingFAB extends HookConsumerWidget {
  const SearchingFAB(this.requestPermissionList, {super.key});
  final List<Permission> requestPermissionList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSearching = ref.watch(scanButtonStateProvider);
    final elapsed = useState(Duration.zero);
    final ticker = useState<Ticker>(Ticker((onTick) {
      elapsed.value = onTick;
    }));

    void _toggleRunning() {
      if (!ticker.value.isActive) {
        ticker.value.start();
      } else {
        ticker.value.stop();
        elapsed.value = Duration.zero;
      }
    }

    void _resetTicker() {
      ticker.value.stop();
      elapsed.value = Duration.zero;
    }

    Future<void> _submitScanButton(bool isSearching) async {
      final bluetoothAvailable =
          await ref.read(bluetoothServiceProvider).isBluetoothAvailable();

      if (isSearching) {
        if (bluetoothAvailable) {
          _toggleRunning();
          await ref
              .read(scanButtonControllerProvider.notifier)
              .submitScanButton(isSearching);
          ref.read(scanButtonStateProvider.notifier).state = isSearching;
        }
      } else {
        _resetTicker();
        await ref
            .read(scanButtonControllerProvider.notifier)
            .submitScanButton(isSearching);
        ref.read(scanButtonStateProvider.notifier).state = isSearching;
      }
    }

    useEffect(() {
      if (requestPermissionList.isEmpty) {
        _submitScanButton(true);
      }
      return null;
    }, []);

    ref.listen<AsyncValue>(
      scanButtonControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );

    return FloatingActionButton.extended(
      tooltip: 'Search Bluetooth',
      onPressed: () async => requestPermissionList.isEmpty
          ? await _submitScanButton(!isSearching)
          : showDialog(
              context: context,
              builder: (context) =>
                  RequestPermissionDialog(requestPermissionList),
            ),
      label: isSearching
          ? Text(prettyDuration(elapsed.value, abbreviated: true))
          : const Text('Stopped'),
      icon: isSearching
          ? const AnimationSearchingIcon()
          : const Icon(Icons.search),
    );
  }
}
