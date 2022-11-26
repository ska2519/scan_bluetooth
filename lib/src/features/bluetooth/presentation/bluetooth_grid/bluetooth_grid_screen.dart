import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../common_widgets/responsive_center.dart';
import '../../../../constants/resources.dart';
import '../../../permission/application/permission_service.dart';
import '../bluetooth_available/bluetooth_available_and_label_count.dart';
import '../home_app_bar/home_app_bar.dart';
import '../scanning_fab/scanning_fab.dart';
import 'bluetooth_grid.dart';

class BluetoothGridScreen extends HookConsumerWidget {
  const BluetoothGridScreen(this.isBluetoothAvailable, {super.key});
  final bool isBluetoothAvailable;

  // void dismissOnScreenKeyboard(BuildContext context) {
  //   if (FocusScope.of(context).hasFocus) {
  //     FocusScope.of(context).unfocus();
  //   }
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();
    // ..addListener(() => dismissOnScreenKeyboard(context));

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
                  child: BluetoothAvailableAndLabelCount(isBluetoothAvailable),
                ),
              ),
              const ResponsiveSliverCenter(
                padding: EdgeInsets.all(Sizes.p8),
                child: BluetoothGrid(),
              ),
            ],
          ),
          // if (state.isLoading) const LoadingAnimation(),
        ],
      ),
    );
  }
}
