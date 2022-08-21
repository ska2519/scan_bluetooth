import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../common_widgets/async_value_widget.dart';
import '../../../../common_widgets/responsive_center.dart';
import '../../../../constants/app_sizes.dart';
import '../../../permission/application/permission_service.dart';
import '../home_app_bar/home_app_bar.dart';
import 'bluetooth_available.dart';
import 'bluetooth_grid.dart';
import 'bluetooth_searching_fab.dart';

class BluetoothListScreen extends StatefulHookConsumerWidget {
  const BluetoothListScreen(this.isBluetoothAvailable, {super.key});
  final bool isBluetoothAvailable;

  @override
  BluetoothListScreenState createState() => BluetoothListScreenState();
}

class BluetoothListScreenState extends ConsumerState<BluetoothListScreen> {
  final _scrollController = ScrollController();
  bool get isBluetoothAvailable => super.widget.isBluetoothAvailable;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_dismissOnScreenKeyboard);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_dismissOnScreenKeyboard);
    super.dispose();
  }

  void _dismissOnScreenKeyboard() {
    if (FocusScope.of(context).hasFocus) {
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AsyncValueWidget<List<Permission>>(
        value: ref.watch(
            requestPermissionListProvider(defaultBluetoothPermissionList)),
        data: (list) {
          print('refresh requestPermissionListProvider: $list');
          return BluetoothSearchingFAB(list);
        },
      ),
      appBar: const HomeAppBar(),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          ResponsiveSliverCenter(
            padding: const EdgeInsets.all(Sizes.p8),
            child: BluetoothAvailable(isBluetoothAvailable),
          ),
          // if (Platform.isAndroid || Platform.isIOS)
          //   const ResponsiveSliverCenter(
          //     padding: EdgeInsets.symmetric(horizontal: Sizes.p12),
          //     child: NativeAdCard(),
          //   ),
          const ResponsiveSliverCenter(
            padding: EdgeInsets.all(Sizes.p8),
            child: BluetoothGrid(),
          ),
        ],
      ),
    );
  }
}
