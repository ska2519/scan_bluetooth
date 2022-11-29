import '../../../../constants/resources.dart';
import '../../application/bluetooth_service.dart';
import '../../data/scan_bluetooth_repository.dart';
import '../../domain/bluetooth.dart';

class BluetoothGridScreenController extends StateNotifier<AsyncValue<void>> {
  BluetoothGridScreenController({
    required this.bluetoothService,
  }) : super(const AsyncData(null));
  final BluetoothService bluetoothService;

  Future<void> onTap() async {}

  Future<void> onTapTile(
    Bluetooth bluetooth,
    BuildContext context,
  ) async {
    final isUpdateLabel = await bluetoothService.openLabelDialog(
      context: context,
      bluetooth: bluetooth,
    );
    logger.i('isUpdate: $isUpdateLabel');
    if (isUpdateLabel != null && isUpdateLabel) {
      state = const AsyncLoading();
      state =
          await AsyncValue.guard(() => bluetoothService.updateLabel(bluetooth));
    }
  }
}

final bluetoothGridScreenControllerProvider = StateNotifierProvider.autoDispose<
    BluetoothGridScreenController, AsyncValue<void>>((ref) {
  ref.onDispose(() => ref.read(scanBluetoothRepoProvider).stopScan());
  return BluetoothGridScreenController(
    bluetoothService: ref.read(bluetoothServiceProvider),
  );
});
