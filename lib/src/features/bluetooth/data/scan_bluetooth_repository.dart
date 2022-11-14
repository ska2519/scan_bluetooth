import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_blue/models.dart';

import 'quick_blue_bluetooth_repo.dart';

/// API for reading, watching and writing local cart data (guest user)
abstract class ScanBlueToothRepository {
  Future<bool> isBluetoothAvailable();
  void startScan();
  void stopScan();
  Stream<BlueScanResult> scanResultStream();
  void connect(String deviceId);
}

final btRepoProvider =
    Provider<ScanBlueToothRepository>((ref) => QuickBlueBluetoothRepo());

final isBTAvailableProvider = FutureProvider.autoDispose<bool>(
    (ref) async => await ref.read(btRepoProvider).isBluetoothAvailable());

final scanResultStreamProvider = StreamProvider<BlueScanResult>(
    (ref) => ref.watch(btRepoProvider).scanResultStream());
