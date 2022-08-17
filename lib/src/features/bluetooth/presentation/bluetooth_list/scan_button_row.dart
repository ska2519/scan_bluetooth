import 'package:duration/duration.dart';
import 'package:flutter/scheduler.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rolling_switch/rolling_switch.dart';

import '../../../../constants/resources.dart';
import '../../../../utils/async_value_ui.dart';
import '../../application/bluetooth_service.dart';
import 'scan_button_controller.dart';

class ScanButtonRow extends StatefulHookConsumerWidget {
  const ScanButtonRow(this.isBluetoothAvailable, {super.key});
  final bool isBluetoothAvailable;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ScanButtonsRowState();
}

class _ScanButtonsRowState extends ConsumerState<ScanButtonRow>
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
        .addPostFrameCallback((_) => _submitScanButton(true));
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

  Future<void> _submitScanButton(bool rollingSwitchState) async {
    await ref
        .read(startStopButtonControllerProvider.notifier)
        .submitScanButton(rollingSwitchState);

    if (rollingSwitchState) {
      if (await ref.read(bluetoothServiceProvider).isBluetoothAvailable()) {
        _toggleRunning();
      }
    } else {
      _reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(
      startStopButtonControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );

    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    final state = ref.watch(startStopButtonControllerProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.p8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          isBluetoothAvailable
              ? const Icon(
                  Icons.bluetooth_connected,
                  color: Colors.blue,
                )
              : const Icon(
                  Icons.bluetooth_disabled,
                  color: Colors.red,
                ),
          gapW8,
          Flexible(
            child: Text(
              isBluetoothAvailable ? 'Available' : 'Not available',
              style: Theme.of(context).textTheme.titleSmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          gapW8,
          IgnorePointer(
            // ignoring: !isBluetoothAvailable,
            child: RollingSwitch.icon(
              initialState: isBluetoothAvailable ? true : false,
              width: screenWidth / 2,
              onChanged: (bool rollingSwitchState) {
                if (!state.isLoading) {
                  _submitScanButton(rollingSwitchState);
                }
              },
              rollingInfoLeft: const RollingIconInfo(
                icon: Icons.search_off,
                backgroundColor: Colors.grey,
                text: Text('Stop'),
              ),
              rollingInfoRight: RollingIconInfo(
                icon: Icons.search,
                text: Text(
                  'Searching... ${prettyDuration(
                    _elapsed,
                    abbreviated: true,
                  )}',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
