// ignore_for_file: depend_on_referenced_packages

import 'package:convert/convert.dart';
import 'package:flutter/foundation.dart';
import 'package:quick_blue/quick_blue.dart';

import '../../../exceptions/error_logger.dart';
import 'scan_bluetooth_repository.dart';

class QuickBlueBluetoothRepo implements ScanBluetoothRepository {
  QuickBlueBluetoothRepo({this.addDelay = true});
  final bool addDelay;

  @override
  Future<bool> isBluetoothAvailable() async =>
      await QuickBlue.isBluetoothAvailable();

  //* Scan BLE peripheral
  //* https://pub.dev/packages/quick_blue#scan-ble-peripheral

  @override
  void startScan() => QuickBlue.startScan();

  @override
  void stopScan() => QuickBlue.stopScan();

  @override
  Stream<BlueScanResult> scanResultStream() => QuickBlue.scanResultStream;

  //* Connect BLE peripheral
  //* https://pub.dev/packages/quick_blue#connect-ble-peripheral

  @override
  void setConnectionHandler(
          Function(String deviceId, BlueConnectionState state)
              onConnectionChanged) =>
      QuickBlue.setConnectionHandler(handleConnectionChange);

  @override
  void handleConnectionChange(String deviceId, BlueConnectionState state) {
    logger.i(
        'QuickBlueBluetoothRepo handleConnectionChange $deviceId, ${state.value}');
  }

  @override
  Stream<BlueConnectionState> blueConnectionStateStream() async* {
    var connectionStream =
        Stream<BlueConnectionState>.value(BlueConnectionState.disconnected);
    QuickBlue.setConnectionHandler((deviceId, state) {
      connectionStream = Stream.value(state);
    });
    logger.i('connectionStream: $connectionStream');
    yield* connectionStream;
  }

  // @override
  // void handleConnectionChange(String deviceId, BlueConnectionState state) {
  //   logger.i(
  //       'QuickBlueBluetoothRepo _handleConnectionChange $deviceId, ${state.value}');
  // }
  @override
  void connect(String deviceId) {
    QuickBlue.connect(deviceId);
    logger.i('QuickBlueBluetoothRepo connect deviceId: $deviceId');
  }

  @override
  void disconnect(String deviceId) {
    QuickBlue.disconnect(deviceId);
    logger.i('QuickBlueBluetoothRepo disconnect deviceId: $deviceId');
  }

  //* Discover services of BLE peripheral #
  //* https://pub.dev/packages/quick_blue#discover-services-of-ble-peripheral

  @override
  void setServiceHandler(onServiceDiscovered) =>
      QuickBlue.setServiceHandler(handleServiceDiscovery);

  @override
  void handleServiceDiscovery(
      String deviceId, String serviceId, List<String> characteristicIds) {
    logger.i(
        'QuickBlueBluetoothRepo handleServiceDiscovery $deviceId, $serviceId');
  }

  @override
  void discoverServices(String deviceId) =>
      QuickBlue.discoverServices(deviceId);

  //* Transfer data between BLE central & peripheral
  //* https://pub.dev/packages/quick_blue#transfer-data-between-ble-central--peripheral
  // Data would receive from value handler of `QuickBlue.setValueHandler`

  @override
  Future<void> writeValue({
    required String deviceId,
    required String serviceId,
    required String characteristicId,
    required Uint8List value,
    required BleOutputProperty bleOutputProperty,
  }) async =>
      await QuickBlue.writeValue(
        deviceId,
        serviceId,
        characteristicId,
        value,
        bleOutputProperty,
      );
  //* Receive data from peripheral of deviceId
  @override
  void setValueHandler(
          void Function(String, String, Uint8List)? onValueChanged) =>
      QuickBlue.setValueHandler(handleValueChange);

  @override
  void handleValueChange(
      String deviceId, String characteristicId, Uint8List value) {
    logger.i(
        'QuickBlueBluetoothRepo handleValueChange $deviceId, $characteristicId, ${hex.encode(value)}');
  }

  @override
  void setNotifiable({
    required String deviceId,
    required String serviceId,
    required String characteristicId,
    required BleInputProperty bleInputProperty,
  }) =>
      QuickBlue.setNotifiable(
        deviceId,
        serviceId,
        characteristicId,
        bleInputProperty,
      );

  @override
  Future<void> readValue(
          {required String deviceId,
          required String serviceId,
          required String characteristic}) =>
      QuickBlue.readValue(deviceId, serviceId, characteristic);
}
