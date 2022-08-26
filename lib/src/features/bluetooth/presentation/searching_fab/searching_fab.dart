import 'dart:io';

import 'package:duration/duration.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../constants/resources.dart';
import '../../../admob/application/admob_service.dart';
import '../../../permission/presentation/request_permission_dialog.dart';
import '../../application/bluetooth_service.dart';
import '../bluetooth_list/animation_searching_icon.dart';
import 'searching_fab_controller.dart';

class SearchingFAB extends HookConsumerWidget {
  const SearchingFAB(this.requestPermissionList, {super.key});
  final List<Permission>? requestPermissionList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: error: debug didchangedependencies ==false riverpod
    // ref.listen<AsyncValue>(
    //   searchingFABControllerProvider,
    //   (_, state) => state.showAlertDialogOnError(context),
    // );
    final state = ref.watch(searchingFABControllerProvider);
    final searching = ref.watch(searchingFABStateProvider);
    final elapsed = ref.watch(elapsedProvider);

    useEffect(() {
      if ((requestPermissionList != null && requestPermissionList!.isEmpty) ||
          (Platform.isAndroid || Platform.isIOS) == false) {
        WidgetsBinding.instance.addPostFrameCallback((_) => ref
            .read(searchingFABControllerProvider.notifier)
            .submitSearching(true));
      }

      return null;
    }, [requestPermissionList]);

    return FloatingActionButton.extended(
      tooltip: 'Search Bluetooth',
      onPressed: state.isLoading
          ? null
          : requestPermissionList != null && requestPermissionList!.isNotEmpty
              ? () => showDialog(
                    context: context,
                    builder: (context) =>
                        RequestPermissionDialog(requestPermissionList!),
                  )
              : () {
                  ref
                      .read(searchingFABControllerProvider.notifier)
                      .submitSearching(!searching);

                  if (searching) {
                    print('searching: $searching');
                    ref.read(admobServiceProvider).showInterstitialAd();
                  }
                },
      label: requestPermissionList != null && requestPermissionList!.isNotEmpty
          ? const Text('🔔 Setting Permission')
          : searching
              ? Text(prettyDuration(elapsed, abbreviated: true))
              : const Text('Stopped'),
      icon: requestPermissionList != null && requestPermissionList!.isNotEmpty
          ? null
          : searching
              ? const AnimationSearchingIcon()
              : const Icon(Icons.search),
    );
  }
}
