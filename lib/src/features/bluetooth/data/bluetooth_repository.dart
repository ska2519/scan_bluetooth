import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_blue/models.dart';

import 'quick_blue_bluetooth_repository.dart';

/// API for reading, watching and writing local cart data (guest user)
abstract class BluetoothRepository {
  Future<bool> isBluetoothAvailable();
  void startScan();
  void stopScan();
  Stream<BlueScanResult> scanResultStream();
}

final bluetoothRepositoryProvider = Provider<BluetoothRepository>(
  (ref) => QuickBlueBluetoothRepository(),
);

final isBluetoothAvailableProvider = FutureProvider<bool>(
  (ref) async => ref.read(bluetoothRepositoryProvider).isBluetoothAvailable(),
);

final scanResultStreamProvider = StreamProvider<BlueScanResult>(
  (ref) => ref.read(bluetoothRepositoryProvider).scanResultStream(),
);
