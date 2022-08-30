import 'dart:io';

import 'package:duration/duration.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../constants/resources.dart';
import '../../../../exceptions/error_logger.dart';
import '../../../../utils/async_value_ui.dart';
import '../../../../utils/toast_context.dart';
import '../../../permission/presentation/request_permission_dialog.dart';
import '../../application/scan_bt_service.dart';
import '../bluetooth_list/animation_scanning_icon.dart';
import 'scanning_fab_controller.dart';

class ScanningFAB extends HookConsumerWidget {
  const ScanningFAB(this.requestPermissionList, {super.key});
  final List<Permission>? requestPermissionList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(scanningFABControllerProvider, (_, state) {
      logger.i('statestatestatestate: $state');
      return state.showAlertDialogOnError(context);
    });

    final state = ref.watch(scanningFABControllerProvider);
    final theme = Theme.of(context);
    final fToast = ref.read(fToastProvider);

    useEffect(() {
      if ((requestPermissionList != null && requestPermissionList!.isEmpty) ||
          (Platform.isAndroid || Platform.isIOS) == false) {
        WidgetsBinding.instance.addPostFrameCallback((_) => ref
            .read(scanningFABControllerProvider.notifier)
            .submitScanning(true));
      }
      return null;
    }, [requestPermissionList]);

    // ** Test 용 코드
    // return ElevatedButton(
    //     onPressed: state.isLoading
    //         ? null
    //         : () => ref
    //             .read(scanningFABControllerProvider.notifier)
    //             .submitScanning(true),
    //     child: const Text('scan button'));

    return Consumer(
      builder: (context, ref, child) {
        final scanning = ref.watch(scanFABStateProvider);
        final elapsed = ref.watch(elapsedProvider);
        if (elapsed.inSeconds >= 4) {
          fToast.removeQueuedCustomToasts();
        }
        return FloatingActionButton.extended(
          backgroundColor: elapsed.inSeconds < 4
              ? theme.errorColor
              : !scanning
                  ? theme.primaryColorLight
                  : theme.primaryColorDark,
          tooltip: 'Search Bluetooth',
          onPressed: state.isLoading
              ? null
              : scanning && elapsed.inSeconds < 4
                  ? () => fToast.showToast(
                          child: const ToastContext(
                        'Scan minumun time 4s ⌛️',
                      ))
                  : requestPermissionList != null &&
                          requestPermissionList!.isNotEmpty
                      ? () => showDialog(
                            context: context,
                            builder: (context) =>
                                RequestPermissionDialog(requestPermissionList!),
                          )
                      : () async {
                          if (!scanning) {
                            ref.read(bluetoothListProvider.notifier).state = [];
                          } else {
                            //TODO: Is it necessary to clear the list?
                            // ref.invalidate(bluetoothListStreamProvider);
                          }

                          await ref
                              .read(scanningFABControllerProvider.notifier)
                              .submitScanning(!scanning);
                        },
          label:
              requestPermissionList != null && requestPermissionList!.isNotEmpty
                  ? const Text('🔔 Setting Permission')
                  : scanning
                      ? Text(prettyDuration(elapsed, abbreviated: true))
                      : const Text('Stopped'),
          icon:
              requestPermissionList != null && requestPermissionList!.isNotEmpty
                  ? null
                  : scanning
                      ? const AnimationScanningIcon()
                      : const Icon(Icons.search),
        );
      },
    );
  }
}
