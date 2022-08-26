import 'dart:io';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../common_widgets/responsive_center.dart';
import '../../../../constants/resources.dart';
import '../../../admob/presentation/native_ad_card.dart';
import '../../../permission/application/permission_service.dart';
import '../home_app_bar/home_app_bar.dart';
import '../searching_fab/searching_fab.dart';
import 'bluetooth_available.dart';
import 'bluetooth_grid.dart';

class BluetoothListScreen extends HookConsumerWidget {
  const BluetoothListScreen(this.isBluetoothAvailable, {super.key});
  final bool isBluetoothAvailable;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void _dismissOnScreenKeyboard() {
      if (FocusScope.of(context).hasFocus) {
        FocusScope.of(context).unfocus();
      }
    }

    final scrollController = useScrollController()
      ..addListener(_dismissOnScreenKeyboard);

    return Scaffold(
      floatingActionButton: Platform.isAndroid || Platform.isIOS
          ? AsyncValueWidget<List<Permission>>(
              value: ref.watch(requestPermissionListProvider(
                  defaultBluetoothPermissionList)),
              data: SearchingFAB.new,
            )
          : const SearchingFAB(null),
      appBar: const HomeAppBar(),
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          ResponsiveSliverCenter(
            padding: const EdgeInsets.all(Sizes.p8),
            child: BluetoothAvailable(isBluetoothAvailable),
          ),
          if (Platform.isAndroid || Platform.isIOS)
            const ResponsiveSliverCenter(
              padding: EdgeInsets.symmetric(horizontal: Sizes.p12),
              child: NativeAdCard(),
            ),
          const ResponsiveSliverCenter(
            padding: EdgeInsets.all(Sizes.p8),
            child: BluetoothGrid(),
          ),
        ],
      ),
    );
  }
}
