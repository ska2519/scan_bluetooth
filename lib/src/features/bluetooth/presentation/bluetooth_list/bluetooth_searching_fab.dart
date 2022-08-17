import 'package:duration/duration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../utils/async_value_ui.dart';
import '../../application/bluetooth_service.dart';
import 'animation_searching_icon.dart';
import 'scan_button_controller.dart';

class BluetoothSearchingFAB extends StatefulHookConsumerWidget {
  const BluetoothSearchingFAB(this.isBluetoothAvailable, {super.key});
  final bool isBluetoothAvailable;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BluetoothSearchingFABState();
}

class _BluetoothSearchingFABState extends ConsumerState<BluetoothSearchingFAB>
    with SingleTickerProviderStateMixin {
  bool get isBluetoothAvailable => super.widget.isBluetoothAvailable;
  Duration previouslyElapsed = Duration.zero;
  Duration currentlyElapsed = Duration.zero;
  Duration get _elapsed => previouslyElapsed + currentlyElapsed;
  late final Ticker _ticker;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker((elapsed) {
      setState(() {
        currentlyElapsed = elapsed;
      });
    });
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _submitScanButton(false));
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  void _toggleRunning() {
    setState(() {
      if (!_ticker.isActive) {
        _ticker.start();
      } else {
        _ticker.stop();
        previouslyElapsed += currentlyElapsed;
        currentlyElapsed = Duration.zero;
      }
    });
  }

  void _reset() {
    _ticker.stop();
    setState(() {
      previouslyElapsed = Duration.zero;
      currentlyElapsed = Duration.zero;
    });
  }

  Future<void> _submitScanButton(bool scanButtonState) async {
    print('scanButtonState: $scanButtonState');
    scanButtonState = !scanButtonState;
    if (scanButtonState) {
      if (await ref.read(bluetoothServiceProvider).isBluetoothAvailable()) {
        _toggleRunning();
        ref.read(scanButtonStateProvider.notifier).state = true;
        await ref
            .read(scanButtonControllerProvider.notifier)
            .submitScanButton(scanButtonState);
      }
    } else {
      _reset();
      ref.read(scanButtonStateProvider.notifier).state = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(
      scanButtonControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );

    final scanButtonState = ref.watch(scanButtonStateProvider);

    return FloatingActionButton.extended(
      tooltip: 'Bluetooth Search',
      onPressed: () async => await _submitScanButton(scanButtonState),
      label: scanButtonState
          ? Text(
              prettyDuration(
                _elapsed,
                abbreviated: true,
              ),
            )
          : const Text('Stopped'),
      icon: scanButtonState
          ? const AnimationSearchingIcon()
          : const Icon(Icons.search),
    );
  }
}
