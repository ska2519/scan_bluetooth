import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_blue/quick_blue.dart';

import 'quick_blue_bluetooth_repo.dart';

/// API for reading, watching and writing local cart data (guest user)
abstract class ScanBlueToothRepository {
  Future<bool> isBluetoothAvailable();
  void startScan();
  void stopScan();
  Stream<BlueScanResult> scanResultStream();
  void connect(String deviceId);
  void disconnect(String deviceId);
  void setConnectionHandler();
  void handleConnectionChange(String deviceId, BlueConnectionState state);
  void setServiceHandler(String deviceId);
  void handleServiceDiscovery(String deviceId, String serviceId);
  void discoverServices(String deviceId);
  void readValue(String deviceId, String serviceId, String characteristicId);
  void writeValue({
    required String deviceId,
    required String serviceId,
    required String characteristicId,
    required Uint8List value,
    required BleOutputProperty bleOutputProperty,
  });
  void setValueHandler(String deviceId);
  void handleValueChange(
      String deviceId, String characteristicId, Uint8List value);
  void setNotifiable({
    required String deviceId,
    required String serviceId,
    required String characteristicId,
    required BleInputProperty bleInputProperty,
  });
}

final btRepoProvider =
    Provider<ScanBlueToothRepository>((ref) => QuickBlueBluetoothRepo());

final isBTAvailableProvider = FutureProvider.autoDispose<bool>(
    (ref) async => await ref.read(btRepoProvider).isBluetoothAvailable());

final scanResultStreamProvider = StreamProvider<BlueScanResult>(
    (ref) => ref.watch(btRepoProvider).scanResultStream());
