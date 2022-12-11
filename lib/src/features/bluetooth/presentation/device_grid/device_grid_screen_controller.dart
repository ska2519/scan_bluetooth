import 'package:flutter_blue_plus/flutter_blue_plus.dart' as fbp;

import '../../../../constants/resources.dart';
import '../../application/bluetooth_service.dart';
import '../../data/scan_bluetooth_repository.dart';
// import '../../domain/bluetooth.dart';

class DeviceGridScreenController extends StateNotifier<AsyncValue<void>> {
  DeviceGridScreenController({
    required this.bluetoothService,
  }) : super(const AsyncData(null));
  final BluetoothService bluetoothService;

  Future<void> onTap() async {}

  Future<void> onTapTile(
    fbp.ScanResult bluetooth,
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

final deviceGridScreenControllerProvider = StateNotifierProvider.autoDispose<
    DeviceGridScreenController, AsyncValue<void>>((ref) {
  ref.onDispose(() => ref.read(scanBluetoothRepoProvider).stopScan());
  return DeviceGridScreenController(
    bluetoothService: ref.read(bluetoothServiceProvider),
  );
});
