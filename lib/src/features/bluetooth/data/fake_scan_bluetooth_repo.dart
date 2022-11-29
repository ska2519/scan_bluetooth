import 'dart:typed_data';

import 'package:quick_blue/quick_blue.dart';

import '../../../constants/test_scan_result.dart';
import '../../../utils/in_memory_store.dart';
import 'scan_bluetooth_repository.dart';

class FakeScanBluetoothRepo implements ScanBlueToothRepository {
  FakeScanBluetoothRepo({this.addDelay = true});
  final bool addDelay;

  final _scanResult = InMemoryStore<BlueScanResult>(kBlueScanResult);

  @override
  Future<bool> isBluetoothAvailable() {
    return Future.value(true);
  }

  @override
  Stream<BlueScanResult> scanResultStream() {
    return _scanResult.stream.map((scanBluetooth) => scanBluetooth);
  }

  @override
  void startScan() {
    // TODO: implement startScan
  }

  @override
  void stopScan() {
    // TODO: implement stopScan
  }
  @override
  Stream<BlueConnectionState> blueConnectionStateStream() {
    // TODO: implement setConnectionHandler
    throw UnimplementedError();
  }

  @override
  void connect(String deviceId) {
    // TODO: implement connect
  }

  @override
  void disconnect(String deviceId) {
    // TODO: implement disconnect
  }

  @override
  void setServiceHandler(void Function(String, String)? onServiceDiscovered) {
    // TODO: implement setServiceHandler
  }

  @override
  void handleConnectionChange(String deviceId, BlueConnectionState state) {
    // TODO: implement handleConnectionChange
  }

  @override
  void discoverServices(String deviceId) {
    // TODO: implement discoverServices
  }

  @override
  void handleServiceDiscovery(
      String deviceId, String serviceId, List<String> characteristicIds) {
    // TODO: implement handleServiceDiscovery
  }

  @override
  void handleValueChange(
      String deviceId, String characteristicId, Uint8List value) {
    // TODO: implement handleValueChange
  }

  @override
  Future<void> writeValue(
      {required String deviceId,
      required String serviceId,
      required String characteristicId,
      required Uint8List value,
      required BleOutputProperty bleOutputProperty}) {
    // TODO: implement writeValue
    throw UnimplementedError();
  }

  @override
  Future<void> readValue(
      {required String deviceId,
      required String serviceId,
      required String characteristic}) {
    // TODO: implement readValue
    throw UnimplementedError();
  }

  @override
  void setNotifiable(
      {required String deviceId,
      required String serviceId,
      required String characteristicId,
      required BleInputProperty bleInputProperty}) {
    // TODO: implement setNotifiable
  }

  @override
  void setValueHandler(
      void Function(String, String, Uint8List)? onValueChanged) {
    // TODO: implement setValueHandler
  }

  @override
  void setConnectionHandler(
      void Function(String deviceId, BlueConnectionState state)?
          onConnectionChanged) {
    // TODO: implement setConnectionHandler
  }
}
