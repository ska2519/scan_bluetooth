import 'package:duration/duration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../utils/async_value_ui.dart';
import '../../application/bluetooth_service.dart';
import 'animation_searching_icon.dart';
import 'scan_button_controller.dart';

class BluetoothSearchingFAB extends StatefulHookConsumerWidget {
  const BluetoothSearchingFAB({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BluetoothSearchingFABState();
}

class _BluetoothSearchingFABState extends ConsumerState<BluetoothSearchingFAB>
    with SingleTickerProviderStateMixin {
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
    _submitScanButton(true);
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

  void _resetTicker() {
    _ticker.stop();
    setState(() {
      previouslyElapsed = Duration.zero;
      currentlyElapsed = Duration.zero;
    });
  }

  Future<void> _submitScanButton(bool isSearching) async {
    if (isSearching) {
      if (await ref.read(bluetoothServiceProvider).isBluetoothAvailable()) {
        _toggleRunning();
        await ref
            .read(scanButtonControllerProvider.notifier)
            .submitScanButton(isSearching);
        ref.read(scanButtonStateProvider.notifier).state = isSearching;
      }
    } else {
      _resetTicker();
      await ref
          .read(scanButtonControllerProvider.notifier)
          .submitScanButton(isSearching);
      ref.read(scanButtonStateProvider.notifier).state = isSearching;
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(
      scanButtonControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final isSearching = ref.watch(scanButtonStateProvider);

    return FloatingActionButton.extended(
      tooltip: 'Bluetooth Search',
      onPressed: () async => await _submitScanButton(!isSearching),
      label: isSearching
          ? Text(
              prettyDuration(
                _elapsed,
                abbreviated: true,
              ),
            )
          : const Text('Stopped'),
      icon: isSearching
          ? const AnimationSearchingIcon()
          : const Icon(Icons.search),
    );
  }
}
