import '../../../../constants/resources.dart';
import '../../application/bluetooth_service.dart';
import '../../domain/bluetooth.dart';

final labelScreenControllerProvider =
    StateNotifierProvider<LabelScreenController, AsyncValue<void>>(
  (ref) => LabelScreenController(
    bluetoothService: ref.read(bluetoothServiceProvider),
  ),
);

class LabelScreenController extends StateNotifier<AsyncValue<void>> {
  LabelScreenController({
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
