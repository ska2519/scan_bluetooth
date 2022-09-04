import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_blue/models.dart';

import '../../../exceptions/error_logger.dart';
import 'quick_blue_bluetooth_repo.dart';

/// API for reading, watching and writing local cart data (guest user)
abstract class ScanBlueToothRepository {
  Future<bool> isBluetoothAvailable();
  void startScan();
  void stopScan();
  Stream<BlueScanResult> scanResultStream();
  void connect(String deviceId);
}

final btRepoProvider = Provider<ScanBlueToothRepository>(
  (ref) => QuickBlueBluetoothRepo(),
);

final isBTAvailableProvider = FutureProvider.autoDispose<bool>((ref) async {
  final isBluetoothAvailable =
      await ref.read(btRepoProvider).isBluetoothAvailable();
  logger.i('isBluetoothAvailable: $isBluetoothAvailable');
  return isBluetoothAvailable;
});

final scanResultStreamProvider = StreamProvider<BlueScanResult>(
  (ref) => ref.read(btRepoProvider).scanResultStream(),
);
