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

  Future<void> onTapLabelEdit(
    Bluetooth bluetooth,
    BuildContext context,
  ) async {
    logger.i('isUpdate');
    final isUpdate = await bluetoothService.openLabelDialog(
      context: context,
      bluetooth: bluetooth,
    );
    logger.i('1 isUpdate: $isUpdate / bluetooth: $bluetooth');

    if (isUpdate != null && isUpdate) {
      state = const AsyncLoading();
      logger.i('2 isUpdate: $isUpdate / bluetooth: $bluetooth');
      final newState =
          await AsyncValue.guard(() => bluetoothService.updateLabel(bluetooth));

      if (newState.hasError) {
        state = AsyncError(newState.error!, newState.stackTrace!);
        // state = AsyncError(newState.error!);
      } else {
        state = newState;
      }
    }
  }
}
