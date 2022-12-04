import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'flutter_blue_plus_repo.dart';

/// API for reading, watching and writing local cart data (guest user)
abstract class ScanBluetoothRepository {
  Future<bool> isBluetoothAvailable();
  Stream<ScanResult> startScanStream();
  Future<dynamic> stopScan();
  // Stream<List<ScanResult>> scanResultListStream();
  // Stream<BlueScanResult> scanResultStream();
  // void connect(String deviceId);
  // void disconnect(String deviceId);
  // void setConnectionHandler(
  //     Function(String deviceId, BlueConnectionState state) onConnectionChanged);
  // Stream<BlueConnectionState> blueConnectionStateStream();

  // void handleConnectionChange(String deviceId, BlueConnectionState state);
  // void setServiceHandler(Function(String, String) onServiceDiscovered);
  // void handleServiceDiscovery(
  //     String deviceId, String serviceId, List<String> characteristicIds);
  // void discoverServices(String deviceId);
  // Future<void> readValue({
  //   required String deviceId,
  //   required String serviceId,
  //   required String characteristic,
  // });
  // Future<void> writeValue({
  //   required String deviceId,
  //   required String serviceId,
  //   required String characteristicId,
  //   required Uint8List value,
  //   required BleOutputProperty bleOutputProperty,
  // });
  // void setValueHandler(
  //     void Function(String, String, Uint8List)? onValueChanged);
  // void handleValueChange(
  //     String deviceId, String characteristicId, Uint8List value);
  // void setNotifiable({
  //   required String deviceId,
  //   required String serviceId,
  //   required String characteristicId,
  //   required BleInputProperty bleInputProperty,
  // });
}

final scanBluetoothRepoProvider =
    Provider<ScanBluetoothRepository>((ref) => FlutterBluePlusRepo());

final isBTAvailableProvider = FutureProvider.autoDispose<bool>(
    (ref) => ref.read(scanBluetoothRepoProvider).isBluetoothAvailable());

final startScanStreamProvider = StreamProvider<ScanResult>(
    (ref) => ref.watch(scanBluetoothRepoProvider).startScanStream());
