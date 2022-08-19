import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../common_widgets/notice_screen.dart';
import '../../../../common_widgets/responsive_center.dart';
import '../../../../constants/app_sizes.dart';
import '../../../permission/presentation/permission_card.dart';
import '../home_app_bar/home_app_bar.dart';
import 'bluetooth_available.dart';
import 'bluetooth_grid.dart';
import 'bluetooth_searching_fab.dart';

class BluetoothListScreen extends StatefulHookConsumerWidget {
  const BluetoothListScreen(
    this.isBluetoothAvailable,
    this.permissionListStatus, {
    super.key,
  });
  final bool isBluetoothAvailable;
  final bool permissionListStatus;

  @override
  BluetoothListScreenState createState() => BluetoothListScreenState();
}

class BluetoothListScreenState extends ConsumerState<BluetoothListScreen> {
  final _scrollController = ScrollController();
  bool get isBluetoothAvailable => super.widget.isBluetoothAvailable;
  bool get permissionListStatus => super.widget.permissionListStatus;

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
      floatingActionButton: permissionListStatus
          ? const BluetoothSearchingFAB()
          : const RequestPemissionsCard(),
      appBar: const HomeAppBar(),
      body: permissionListStatus
          ? CustomScrollView(
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
            )
          : const NoticeScreen(
              '🔔 Location permission is required to determine the exact location of Bluetooth devices.\n Click the button below to enable location permission ↘︎',
            ),
    );
  }
}
