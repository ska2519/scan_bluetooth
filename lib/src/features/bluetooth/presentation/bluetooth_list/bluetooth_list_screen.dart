import 'package:flutter/material.dart';

import '../../../../common_widgets/responsive_center.dart';
import '../../../../constants/app_sizes.dart';
import '../home_app_bar/home_app_bar.dart';

class BluetoothListScreen extends StatefulWidget {
  const BluetoothListScreen({super.key});

  @override
  State<BluetoothListScreen> createState() => _BluetoothListScreenState();
}

class _BluetoothListScreenState extends State<BluetoothListScreen> {
  final _scrollController = ScrollController();

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
      appBar: const HomeAppBar(),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: const [
          ResponsiveSliverCenter(
            padding: EdgeInsets.all(Sizes.p16),
            child: Text('ResponsiveSliverCenter child 1'),
          ),
          ResponsiveSliverCenter(
            padding: EdgeInsets.all(Sizes.p16),
            child: Text('ResponsiveSliverCenter child 2'),
          ),
        ],
      ),
    );
  }
}
