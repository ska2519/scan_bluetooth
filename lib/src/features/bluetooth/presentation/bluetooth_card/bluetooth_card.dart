import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../../../../constants/resources.dart';
import '../../../../utils/toast_context.dart';
import '../bluetooth_detail_screen/bluetooth_detail_screen.dart';
import 'bluetooth_tile.dart';

class BluetoothCard extends HookConsumerWidget {
  const BluetoothCard({
    required this.bluetooth,
    required this.index,
    required this.onPressed,
    this.canDelete = false,
    super.key,
  });

  final VoidCallback onPressed;
  final ScanResult bluetooth;
  final int index;
  final bool canDelete;

  // * Keys for testing using find.byKey()
  static const bluetoothCardKey = Key('bluetooth-card');

  String get deviceId => bluetooth.device.id.id;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final pageFlipKey = useMemoized(GlobalKey<PageFlipBuilderState>.new);
    final insideCardWidget = InsideCard(
      // pageFlipKey: pageFlipKey,
      index: index,
      bluetooth: bluetooth,
      onPressed: onPressed,
    );
    return SizedBox(
      height: 84,
      child: InkWell(
        onTap: canDelete
            ? null
            : () =>
                // context.goNamed(AppRoute.device.name, extra: bluetooth.device),
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FindDevicesScreen())),

        // onTap: () => pageFlipKey.currentState?.flip(),
        child: Card(
          elevation: 0.4,
          child: canDelete
              ? Dismissible(
                  direction: DismissDirection.endToStart,
                  key: Key(deviceId),
                  onDismissed: (direction) {
                    // ref.read(bluetoothServiceProvider).deleteLabel(bluetooth);
                    final fToast = ref.read(fToastProvider);
                    fToast.showToast(
                        child: const ToastContext(
                      '␡ Deleted Label 🏷',
                    ));
                  },
                  background: Container(
                    color: Colors.red,
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  child: insideCardWidget,
                )
              : insideCardWidget,
        ),
      ),
    );
  }
}

class InsideCard extends StatelessWidget {
  const InsideCard({
    super.key,
    // required this.pageFlipKey,
    required this.index,
    required this.bluetooth,
    required this.onPressed,
  });

  // final GlobalKey<PageFlipBuilderState> pageFlipKey;
  final int index;
  final ScanResult bluetooth;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.p8),
      child: BluetoothTile(
        index: index,
        scanResult: bluetooth,
        onPressed: onPressed,
      ),
      // PageFlipBuilder(
      //   key: pageFlipKey,
      //   flipAxis: Axis.vertical,
      //   frontBuilder: (_) => BluetoothTile(
      //     index: index,
      //     bluetooth: bluetooth,
      //     onTapLabelEdit: onTapLabelEdit,
      //   ),
      //   backBuilder: (_) => BluetoothDetailTile(bluetooth),
      // ),
    );
  }
}
