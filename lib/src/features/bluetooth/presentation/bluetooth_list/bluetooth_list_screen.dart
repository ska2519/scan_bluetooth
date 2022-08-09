import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common_widgets/async_value_widget.dart';
import '../../../../common_widgets/primary_button.dart';
import '../../../../common_widgets/responsive_center.dart';
import '../../../../constants/app_sizes.dart';
import '../../../../localization/string_hardcoded.dart';
import '../../../../utils/async_value_ui.dart';
import '../../data/bluetooth_repository.dart';
import '../home_app_bar/home_app_bar.dart';
import 'bluetooth_grid.dart';
import 'bluetooth_list_controller.dart';

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
    ref.listen<AsyncValue>(
      bluetoothListControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final state = ref.watch(bluetoothListControllerProvider);
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
                    const Text('Bluetooth Available: '),
                    isBluetoothAvailable
                        ? const Icon(
                            Icons.bluetooth_connected,
                            color: Colors.blue,
                          )
                        : const Icon(
                            Icons.bluetooth_disabled,
                            color: Colors.red,
                          ),
                    PrimaryButton(
                      text: 'startScan'.hardcoded,
                      isLoading: state.isLoading,
                      onPressed: state.isLoading
                          ? null
                          : ref
                              .read(bluetoothListControllerProvider.notifier)
                              .submitStartScan,
                    ),
                    PrimaryButton(
                      text: 'stopScan'.hardcoded,
                      isLoading: state.isLoading,
                      onPressed: state.isLoading
                          ? null
                          : ref
                              .read(bluetoothListControllerProvider.notifier)
                              .submitStopScan,
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
