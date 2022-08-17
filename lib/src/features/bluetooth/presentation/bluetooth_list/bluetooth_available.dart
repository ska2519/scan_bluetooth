import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../constants/resources.dart';

class BluetoothAvailable extends StatefulHookConsumerWidget {
  const BluetoothAvailable(this.isBluetoothAvailable, {super.key});
  final bool isBluetoothAvailable;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ScanButtonsRowState();
}

class _ScanButtonsRowState extends ConsumerState<BluetoothAvailable> {
  bool get isBluetoothAvailable => super.widget.isBluetoothAvailable;

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    // final screenWidth = size.width;
    // final state = ref.watch(scanButtonControllerProvider);

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
          // gapW8,
        ],
      ),
    );
  }
}
