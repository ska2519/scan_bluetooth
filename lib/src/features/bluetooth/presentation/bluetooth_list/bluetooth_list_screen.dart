import 'dart:io';

import 'package:bluetooth_on_my_body/src/features/bluetooth/presentation/bluetooth_list/bluetooth_grid.dart';
import 'package:bluetooth_on_my_body/src/features/window_size/data/window_size_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_blue/quick_blue.dart';

import '../../../../common_widgets/responsive_center.dart';
import '../../../../constants/app_sizes.dart';
import '../home_app_bar/home_app_bar.dart';

class BluetoothListScreen extends ConsumerStatefulWidget {
  const BluetoothListScreen({super.key});

  @override
  BluetoothListScreenState createState() => BluetoothListScreenState();
}

class BluetoothListScreenState extends ConsumerState<BluetoothListScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      WidgetsBinding.instance.endOfFrame
          .then((_) => ref.watch(windowSizeProvider));
    }
    QuickBlue.startScan();
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
      appBar: const HomeAppBar(),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: const [
          // ResponsiveSliverCenter(
          //   padding: EdgeInsets.all(Sizes.p16),
          //   child: Text('ResponsiveSliverCenter child 1'),
          // ),
          ResponsiveSliverCenter(
            padding: EdgeInsets.all(Sizes.p16),
            child: BluetoothGrid(),
          ),
        ],
      ),
    );
  }
}
