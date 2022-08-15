import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../flavors.dart';
import '../../../../common_widgets/async_value_widget.dart';
import '../../../../common_widgets/flavor_banner.dart';
import '../../../../common_widgets/responsive_center.dart';
import '../../../../constants/app_sizes.dart';
import '../../../ad_mob/banner.dart';
import '../../data/bluetooth_repository.dart';
import '../home_app_bar/home_app_bar.dart';
import 'bluetooth_searching_fab.dart';
import 'scan_button_row.dart';

class BluetoothListScreen extends StatefulHookConsumerWidget {
  const BluetoothListScreen({super.key});

  @override
  BluetoothListScreenState createState() => BluetoothListScreenState();
}

class BluetoothListScreenState extends ConsumerState<BluetoothListScreen> {
  final _scrollController = ScrollController();
  late final AdWidget adWidget;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_dismissOnScreenKeyboard);
    myBanner.listener;
    print('myBanner: $myBanner');
    adWidget = AdWidget(ad: myBanner);
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
    return FlavorBanner(
      show: F.appFlavor != Flavor.PROD,
      child: AsyncValueWidget(
        value: ref.watch(isBluetoothAvailableProvider),
        data: (bool isBluetoothAvailable) => Scaffold(
          floatingActionButton: BluetoothSearchingFAB(isBluetoothAvailable),
          appBar: const HomeAppBar(),
          body: CustomScrollView(
            controller: _scrollController,
            slivers: [
              ResponsiveSliverCenter(
                padding: const EdgeInsets.all(Sizes.p8),
                child: ScanButtonRow(isBluetoothAvailable),
              ),
              ResponsiveSliverCenter(
                padding: const EdgeInsets.all(Sizes.p8),
                child: adWidget,
              ),
              // const ResponsiveSliverCenter(
              //   padding: EdgeInsets.all(Sizes.p8),
              //   child: BluetoothGrid(),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
