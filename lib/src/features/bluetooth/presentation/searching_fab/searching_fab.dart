import 'package:duration/duration.dart';
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
    ref.listen<AsyncValue>(
      searchingFABControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );

    final searching = ref.watch(scanButtonStateProvider);
    final elapsed = ref.watch(elapsedProvider);

    useEffect(() {
      if (requestPermissionList.isEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) => ref
            .read(searchingFABControllerProvider.notifier)
            .submitScanButton(true));
      }
      return null;
    }, [requestPermissionList]);

    return FloatingActionButton.extended(
      tooltip: 'Search Bluetooth',
      onPressed: requestPermissionList.isEmpty
          ? () => ref
              .read(searchingFABControllerProvider.notifier)
              .submitScanButton(!searching)
          : () => showDialog(
                context: context,
                builder: (context) =>
                    RequestPermissionDialog(requestPermissionList),
              ),
      label: requestPermissionList.isNotEmpty
          ? const Text('🔔 Setting Permission')
          : searching
              ? Text(prettyDuration(elapsed, abbreviated: true))
              : const Text('Stopped'),
      icon: requestPermissionList.isNotEmpty
          ? null
          : searching
              ? const AnimationSearchingIcon()
              : const Icon(Icons.search),
    );
  }
}
