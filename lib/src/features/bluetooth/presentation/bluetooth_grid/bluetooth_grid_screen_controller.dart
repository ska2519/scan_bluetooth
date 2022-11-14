import '../../../../constants/resources.dart';
import '../../application/bluetooth_service.dart';
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
    final isUpdate = await bluetoothService.openLabelDialog(
      context: context,
      bluetooth: bluetooth,
    );
    logger.i('isUpdate: $isUpdate');
    if (isUpdate != null && isUpdate) {
      // state = const AsyncLoading();
      // if (bluetooth.userLabel == null) {
      // } else {
      //   await AsyncValue.guard(() => bluetoothService.updateLabel(bluetooth));
      // }
      // final newState =
      //     await AsyncValue.guard(() =>
      await bluetoothService.updateLabel(bluetooth);
      //  );

      // if (newState.hasError) {
      //   // state = AsyncError(newState.error!);
      //   state = AsyncError(newState.error!, newState.stackTrace!);
      // } else {
      //   state = newState;
      // }
    }
  }
}

final bluetoothGridScreenControllerProvider =
    StateNotifierProvider<BluetoothGridScreenController, AsyncValue<void>>(
  (ref) => BluetoothGridScreenController(
    bluetoothService: ref.read(bluetoothServiceProvider),
  ),
);
