import '../../../../constants/resources.dart';
import '../../../../utils/toast_context.dart';
import '../../application/bluetooth_service.dart';
import '../../domain/bluetooth.dart';
import 'bluetooth_tile.dart';

class BluetoothCard extends HookConsumerWidget {
  const BluetoothCard({
    required this.bluetooth,
    required this.index,
    required this.onTapLabelEdit,
    this.canDelete = false,
    super.key,
  });

  final VoidCallback onTapLabelEdit;
  final Bluetooth bluetooth;
  final int index;
  final bool canDelete;

  // * Keys for testing using find.byKey()
  static const bluetoothCardKey = Key('bluetooth-card');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final pageFlipKey = useMemoized(GlobalKey<PageFlipBuilderState>.new);
    final insideCardWidget = InsideCard(
      // pageFlipKey: pageFlipKey,
      index: index,
      bluetooth: bluetooth,
      onTapLabelEdit: onTapLabelEdit,
    );
    return SizedBox(
      height: 84,
      child: InkWell(
        onTap: canDelete
            ? null
            : () => context.pushNamed(
                  AppRoute.detail.name,
                  extra: bluetooth,
                ),
        // onTap: () => pageFlipKey.currentState?.flip(),
        child: Card(
          elevation: 0.4,
          child: canDelete
              ? Dismissible(
                  direction: DismissDirection.endToStart,
                  key: Key(bluetooth.deviceId),
                  onDismissed: (direction) {
                    ref.read(bluetoothServiceProvider).deleteLabel(bluetooth);
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
    required this.onTapLabelEdit,
  });

  // final GlobalKey<PageFlipBuilderState> pageFlipKey;
  final int index;
  final Bluetooth bluetooth;
  final VoidCallback onTapLabelEdit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.p8),
      child: BluetoothTile(
        index: index,
        bluetooth: bluetooth,
        onTapLabelEdit: onTapLabelEdit,
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
