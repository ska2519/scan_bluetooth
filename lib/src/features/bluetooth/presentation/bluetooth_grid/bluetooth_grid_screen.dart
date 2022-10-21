import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../common_widgets/loading_animation.dart';
import '../../../../common_widgets/responsive_center.dart';
import '../../../../constants/resources.dart';
import '../../../../routing/scaffold_with_nav_bar.dart';
import '../../../../utils/toast_context.dart';
import '../../../permission/application/permission_service.dart';
import '../../application/bluetooth_service.dart';
import '../../application/scan_bluetooth_service.dart';
import '../bluetooth_available/bluetooth_available.dart';
import '../home_app_bar/home_app_bar.dart';
import '../scanning_fab/scanning_fab.dart';
import 'bluetooth_grid.dart';
import 'bluetooth_grid_screen_controller.dart';

class BluetoothGridScreen extends HookConsumerWidget {
  const BluetoothGridScreen(this.isBluetoothAvailable, {super.key});
  final bool isBluetoothAvailable;

  void dismissOnScreenKeyboard(BuildContext context) {
    if (FocusScope.of(context).hasFocus) {
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(
      bluetoothGridScreenControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final state = ref.watch(bluetoothGridScreenControllerProvider);

    useEffect(() {
      ref.read(fToastProvider).init(scaffoldGlobalKey.currentState!.context);
      return null;
    }, []);

    final scrollController = useScrollController()
      ..addListener(() => dismissOnScreenKeyboard(context));

    final labelList = ref.watch(userLabelListProvider);
    final userLabelCount = ref.watch(userLabelCountProvider);

    return Scaffold(
      floatingActionButton: Platform.isAndroid || Platform.isIOS
          ? AsyncValueWidget<List<Permission>>(
              value: ref.watch(requestPermissionListProvider(
                  defaultBluetoothPermissionList)),
              data: ScanningFAB.new,
            )
          : const ScanningFAB(null),
      appBar: const HomeAppBar(),
      body: Stack(
        children: [
          CustomScrollView(
            controller: scrollController,
            physics: const BouncingScrollPhysics(),
            slivers: [
              ResponsiveSliverCenter(
                padding:
                    const EdgeInsets.fromLTRB(Sizes.p8, Sizes.p8, Sizes.p8, 0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BluetoothAvailable(isBluetoothAvailable),
                      if (labelList.isNotEmpty)
                        FilterChip(
                          label: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Assets.svg.icons8Tag.svg(width: Sizes.p20),
                              gapW4,
                              Text(
                                  'Label ($userLabelCount/${labelList.length})'),
                            ],
                          ),
                          selected: ref.watch(labelFirstProvider),
                          onSelected: (onSelected) => ref
                              .read(labelFirstProvider.notifier)
                              .update((state) => onSelected),
                        ),
                    ],
                  ),
                ),
              ),
              const ResponsiveSliverCenter(
                padding: EdgeInsets.all(Sizes.p8),
                child: BluetoothGrid(),
              ),
            ],
          ),
          if (state.isLoading) const LoadingAnimation(),
        ],
      ),
    );
  }
}