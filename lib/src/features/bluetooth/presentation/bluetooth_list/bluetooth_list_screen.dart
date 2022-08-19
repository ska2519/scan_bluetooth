import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../common_widgets/async_value_widget.dart';
import '../../../../common_widgets/responsive_center.dart';
import '../../../../constants/app_sizes.dart';
import '../../../admob/ad_helper.dart';
import '../../../permission/application/permission_service.dart';
import '../../../permission/presentation/permission_card.dart';
import '../../data/bluetooth_repository.dart';
import '../home_app_bar/home_app_bar.dart';
import 'bluetooth_available.dart';
import 'bluetooth_grid.dart';
import 'bluetooth_searching_fab.dart';

class BluetoothListScreen extends StatefulHookConsumerWidget {
  const BluetoothListScreen(this.permissionListStatus, {super.key});
  final bool permissionListStatus;

  @override
  BluetoothListScreenState createState() => BluetoothListScreenState();
}

class BluetoothListScreenState extends ConsumerState<BluetoothListScreen>
    with WidgetsBindingObserver {
  final _scrollController = ScrollController();
  NativeAd? _ad;

  bool get permissionListStatus => super.widget.permissionListStatus;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_dismissOnScreenKeyboard);
    WidgetsBinding.instance.addObserver(this);
    if (Platform.isAndroid || Platform.isIOS) {
      NativeAd(
        adUnitId: AdHelper.nativeAdUnitId,
        factoryId: 'listTile',
        request: const AdRequest(),
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            print('onAdLoaded ad:  ${ad.toString()}');
            // ref.read(admobStatusProvider.notifier).state = admobStatus;
            setState(() {
              _ad = ad as NativeAd;
              print('_ad:  ${_ad.toString()}');
            });
          },
          onAdFailedToLoad: (ad, error) {
            // Releases an ad resource when it fails to load
            ad.dispose();
            print(
                'Ad load failed (code=${error.code} message=${error.message})');
          },
        ),
      ).load();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_dismissOnScreenKeyboard);
    _ad?.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) return;
    final isBackgroud = state == AppLifecycleState.paused;
    if (isBackgroud) {
    } else {
      print('isBackgroud: $isBackgroud');
      ref.refresh(isBluetoothAvailableProvider);
      ref.refresh(checkPermissionListStatusProvider);
    }
  }

  void _dismissOnScreenKeyboard() {
    if (FocusScope.of(context).hasFocus) {
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      floatingActionButton: permissionListStatus
          ? const BluetoothSearchingFAB()
          : const RequestPemissionsCard(),
      appBar: const HomeAppBar(),
      body: permissionListStatus
          ? AsyncValueWidget<bool>(
              value: ref.watch(isBluetoothAvailableProvider),
              data: (bool isBluetoothAvailable) => isBluetoothAvailable
                  ? CustomScrollView(
                      controller: _scrollController,
                      slivers: [
                        ResponsiveSliverCenter(
                          padding: const EdgeInsets.all(Sizes.p8),
                          child: BluetoothAvailable(isBluetoothAvailable),
                        ),
                        if ((Platform.isAndroid || Platform.isIOS) &&
                            _ad != null)
                          ResponsiveSliverCenter(
                            padding: const EdgeInsets.all(Sizes.p8),
                            child: AdWidget(ad: _ad!),
                          ),
                        const ResponsiveSliverCenter(
                          padding: EdgeInsets.all(Sizes.p8),
                          child: BluetoothGrid(),
                        ),
                      ],
                    )
                  : const SizedBox(),
            )
          : Padding(
              padding: const EdgeInsets.all(Sizes.p20),
              child: Center(
                child: Text(
                  '🔔 Location permission is required to determine the exact location of Bluetooth devices.\n Click the button below to enable location permission ↘︎',
                  style: textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
    );
  }
}
