import '../../../../constants/resources.dart';
import '../../domain/bluetooth.dart';

class BluetoothDetailTile extends HookConsumerWidget {
  const BluetoothDetailTile(this.bluetooth, {super.key});
  final Bluetooth bluetooth;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: const [
        Text('detail'),
      ],
    );
  }
}
