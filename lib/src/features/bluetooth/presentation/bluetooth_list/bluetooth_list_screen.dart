import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_blue/quick_blue.dart';

import '../../../../common_widgets/async_value_widget.dart';
import '../../../../common_widgets/responsive_center.dart';
import '../../../../constants/app_sizes.dart';
import '../../data/bluetooth_repository.dart';
import '../home_app_bar/home_app_bar.dart';
import 'bluetooth_grid.dart';

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
    // if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    //   WidgetsBinding.instance.endOfFrame
    //       .then((_) => ref.watch(windowSizeProvider));
    // }
    // QuickBlue.startScan();
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
      body: AsyncValueWidget(
        value: ref.watch(isBluetoothAvailableProvider),
        data: (bool isBluetoothAvailable) => CustomScrollView(
          controller: _scrollController,
          slivers: [
            ResponsiveSliverCenter(
              padding: const EdgeInsets.all(Sizes.p8),
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(' Bluetooth Available: '),
                    isBluetoothAvailable
                        ? const Icon(
                            Icons.bluetooth_connected,
                            color: Colors.blue,
                          )
                        : const Icon(
                            Icons.bluetooth_disabled,
                            color: Colors.red,
                          ),
                    ElevatedButton(
                      onPressed: () =>
                          ref.read(bluetoothRepositoryProvider).startScan(),
                      child: const Text('startScan'),
                    ),
                    const ElevatedButton(
                      onPressed: QuickBlue.stopScan,
                      child: Text('stopScan'),
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
      ),
    );
  }
}
