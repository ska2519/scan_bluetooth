import 'dart:io';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../common_widgets/responsive_center.dart';
import '../../../../constants/resources.dart';
import '../../../../home_screen.dart';
import '../../../../utils/dismiss_on_screen_keyboard.dart';
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(
      bluetoothGridScreenControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final state = ref.watch(bluetoothGridScreenControllerProvider);

    useEffect(() {
      ref.read(fToastProvider).init(globalKey.currentState!.context);
      return null;
    }, []);

    final scrollController = useScrollController()
      ..addListener(() => dismissOnScreenKeyboard(context));

    final labelList = ref.watch(userLabelListProvider);
    final userLabelCount = ref.watch(userLabelCountProvider);
    final theme = Theme.of(context);

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
          if (state.isLoading)
            Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: theme.colorScheme.primary,
                size: 50,
              ),
            ),
        ],
      ),
    );
  }
}
