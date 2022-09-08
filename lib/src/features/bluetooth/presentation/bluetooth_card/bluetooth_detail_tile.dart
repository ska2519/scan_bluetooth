import '../../../../constants/resources.dart';
import '../../domain/bluetooth.dart';

class BluetoothDetailTile extends HookConsumerWidget {
  const BluetoothDetailTile(this.bluetooth, {super.key});
  final Bluetooth bluetooth;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(bluetooth.deviceId),
        RichText(
          text: TextSpan(
            text: 'Manufacturer : ',
            style: textTheme.bodyMedium!.copyWith(
              overflow: TextOverflow.ellipsis,
            ),
            children: [
              TextSpan(
                text: bluetooth.manufacturerData.toString(),
              ),
              // const TextSpan(text: ' permission'),
            ],
          ),
          maxLines: 1,
        ),
      ],
    );
  }
}
