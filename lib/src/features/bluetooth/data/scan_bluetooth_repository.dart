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
  void setConnectionHandler(
      Function(String deviceId, BlueConnectionState state) onConnectionChanged);
  Stream<BlueConnectionState> blueConnectionStateStream();

  void handleConnectionChange(String deviceId, BlueConnectionState state);
  void setServiceHandler(Function(String, String) onServiceDiscovered);
  void handleServiceDiscovery(
      String deviceId, String serviceId, List<String> characteristicIds);
  void discoverServices(String deviceId);
  Future<void> readValue({
    required String deviceId,
    required String serviceId,
    required String characteristic,
  });
  void writeValue({
    required String deviceId,
    required String serviceId,
    required String characteristicId,
    required Uint8List value,
    required BleOutputProperty bleOutputProperty,
  });
  void setValueHandler(
      void Function(String, String, Uint8List)? onValueChanged);
  void handleValueChange(
      String deviceId, String characteristicId, Uint8List value);
  void setNotifiable({
    required String deviceId,
    required String serviceId,
    required String characteristicId,
    required BleInputProperty bleInputProperty,
  });
}

final scanBluetoothRepoProvider =
    Provider<ScanBlueToothRepository>((ref) => QuickBlueBluetoothRepo());

final isBTAvailableProvider = FutureProvider.autoDispose<bool>(
    (ref) => ref.read(scanBluetoothRepoProvider).isBluetoothAvailable());

final scanResultStreamProvider = StreamProvider<BlueScanResult>(
    (ref) => ref.watch(scanBluetoothRepoProvider).scanResultStream());

final blueConnectionStateStreamProvider = StreamProvider<BlueConnectionState>(
    (ref) => ref.watch(scanBluetoothRepoProvider).blueConnectionStateStream());
