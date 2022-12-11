// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../constants/resources.dart';
import '../../domain/bluetooth.dart';

class BluetoothDetailTile extends HookConsumerWidget {
  const BluetoothDetailTile(this.bluetooth, {super.key});
  final Bluetooth bluetooth;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      return null;
    }, [bluetooth.deviceId]);

    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Row(
      children: [
        Flexible(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '🆔 ${bluetooth.deviceId}',
                style: textTheme.bodyMedium,
              ),
              RichText(
                text: TextSpan(
                  text: 'Manufacturer : ',
                  style: textTheme.caption!.copyWith(
                    overflow: TextOverflow.ellipsis,
                  ),
                  children: const [
                    TextSpan(
                        // text: bluetooth.manufacturerData.toString(),
                        ),
                    // const TextSpan(text: ' permission'),
                  ],
                ),
                maxLines: 1,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
