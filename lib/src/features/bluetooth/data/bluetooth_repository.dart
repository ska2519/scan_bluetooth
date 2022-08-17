import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_blue/models.dart';

import 'quick_blue_bluetooth_repository.dart';

/// API for reading, watching and writing local cart data (guest user)
abstract class BluetoothRepository {
  Future<bool> isBluetoothAvailable();
  void startScan();
  void stopScan();
  Stream<BlueScanResult> scanResultStream();
  void connect(String deviceId);
}

final bluetoothRepositoryProvider = Provider<BluetoothRepository>(
  (ref) => QuickBlueBluetoothRepository(),
);

final isBluetoothAvailableProvider =
    FutureProvider.autoDispose<bool>((ref) async {
  return ref.read(bluetoothRepositoryProvider).isBluetoothAvailable();
});

final scanResultStreamProvider = StreamProvider<BlueScanResult>(
  (ref) => ref.read(bluetoothRepositoryProvider).scanResultStream(),
);
