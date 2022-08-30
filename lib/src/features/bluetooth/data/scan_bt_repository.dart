import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_blue/models.dart';

import 'quick_blue_bt_repo.dart';

/// API for reading, watching and writing local cart data (guest user)
abstract class ScanBTRepository {
  Future<bool> isBluetoothAvailable();
  void startScan();
  void stopScan();
  Stream<BlueScanResult> scanResultStream();
  void connect(String deviceId);
}

final btRepoProvider = Provider<ScanBTRepository>(
  (ref) => QuickBlueBTRepo(),
);

final isBTAvailableProvider = FutureProvider.autoDispose<bool>(
    (ref) => ref.read(btRepoProvider).isBluetoothAvailable());

final scanResultStreamProvider = StreamProvider<BlueScanResult>(
  (ref) => ref.read(btRepoProvider).scanResultStream(),
);
