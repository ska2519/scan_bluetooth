import '../../../../constants/resources.dart';
import '../../application/bluetooth_service.dart';
import '../../application/scan_bluetooth_service.dart';
import '../../domain/bluetooth.dart';

class BluetoothGridScreenController extends StateNotifier<AsyncValue<void>> {
  BluetoothGridScreenController({
    required this.scanBluetoothService,
    required this.bluetoothService,
  }) : super(const AsyncData(null));
  final ScanBluetoothService scanBluetoothService;
  final BluetoothService bluetoothService;

  Future<void> onTapTile(
    Bluetooth bluetooth,
    BuildContext context,
  ) async {
    final isUpdate = await bluetoothService.openLabelDialog(bluetooth, context);

    if (isUpdate != null && isUpdate) {
      state = const AsyncLoading();
      final newState =
          await AsyncValue.guard(() => bluetoothService.updateLabel(bluetooth));

      if (newState.hasError) {
        state = AsyncError(newState.error!);
      } else {
        state = newState;
      }
    }
  }
}

final bluetoothGridScreenControllerProvider =
    StateNotifierProvider<BluetoothGridScreenController, AsyncValue<void>>(
  (ref) => BluetoothGridScreenController(
    scanBluetoothService: ref.read(scanBluetoothServiceProvider),
    bluetoothService: ref.read(bluetoothServiceProvider),
  ),
);
