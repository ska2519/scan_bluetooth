import 'package:duration/duration.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../constants/resources.dart';
import '../../../../utils/toast_context.dart';
import '../../../in_app_purchase/application/purchases_service.dart';
import '../../../permission/presentation/request_permission_dialog.dart';
import '../../application/scan_device_service.dart';
import 'animation_scanning_icon.dart';
import 'scanning_fab_controller.dart';

final initScanProvider = StateProvider<bool>((ref) => false);

class ScanningFAB extends HookConsumerWidget {
  const ScanningFAB(this.requestPermissionList, {super.key});
  final List<Permission>? requestPermissionList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(scanningFABControllerProvider, (_, state) {
      return state.showAlertDialogOnError(context);
    });

    final state = ref.watch(scanningFABControllerProvider);
    final theme = Theme.of(context);
    final fToast = ref.read(fToastProvider);
    final scanning = ref.watch(scanningProvider);

    //* Start scan when lanuch app
    useEffect(() {
      if (!ref.read(initScanProvider)) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ref.read(initScanProvider.notifier).state = true;
          ref.read(scanningProvider.notifier).state = true;
          ref.read(stopWatchProvider(true));
        });
      }
      return null;
    }, []);

    return Consumer(
      builder: (context, ref, child) {
        final elapsed = ref.watch(elapsedProvider);
        final minimumScanInterval = ref.watch(minimumScanIntervalProvider);
        if (elapsed.inSeconds == minimumScanInterval) {
          fToast.removeQueuedCustomToasts();
        }

        return FloatingActionButton.extended(
          backgroundColor: elapsed.inSeconds < minimumScanInterval
              ? theme.errorColor
              : !scanning
                  ? theme.primaryColorLight
                  : theme.primaryColorDark,
          tooltip: 'Search Bluetooth',
          onPressed: state.isLoading
              ? null
              : scanning && elapsed.inSeconds < minimumScanInterval
                  ? () => fToast.showToast(
                      gravity: ToastGravity.TOP,
                      child: ToastContext(
                        'Scan minumun time ${ref.read(minimumScanIntervalProvider)}s ⌛️',
                      ))
                  : requestPermissionList != null &&
                          requestPermissionList!.isNotEmpty
                      ? () => showDialog(
                            context: context,
                            builder: (context) =>
                                RequestPermissionDialog(requestPermissionList!),
                          )
                      : () async => await ref
                          .read(scanningFABControllerProvider.notifier)
                          .submit(!scanning),
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
