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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.p8),
      child: Tooltip(
        message: isBluetoothAvailable ? 'Available' : 'Not available',
        child: isBluetoothAvailable
            ? Assets.svg.icons8Bluetooth.svg(width: 24)
            : Assets.svg.icons8BluetoothRed.svg(width: 24),
      ),
    );
  }
}
