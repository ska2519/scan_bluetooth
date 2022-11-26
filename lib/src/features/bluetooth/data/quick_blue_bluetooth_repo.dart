// ignore_for_file: depend_on_referenced_packages

import 'package:convert/convert.dart';
import 'package:flutter/foundation.dart';
import 'package:quick_blue/quick_blue.dart';

import '../../../exceptions/error_logger.dart';
import 'scan_bluetooth_repository.dart';

class QuickBlueBluetoothRepo implements ScanBlueToothRepository {
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
  void setConnectionHandler() =>
      QuickBlue.setConnectionHandler(handleConnectionChange);

  @override
  void handleConnectionChange(String deviceId, BlueConnectionState state) {
    logger
        .i('QuickBlueBluetoothRepo _handleConnectionChange $deviceId, $state');
  }

  @override
  void connect(String deviceId) => QuickBlue.connect(deviceId);

  @override
  void disconnect(String deviceId) => QuickBlue.disconnect(deviceId);

  //* Discover services of BLE peripheral #
  //* https://pub.dev/packages/quick_blue#discover-services-of-ble-peripheral

  @override
  void setServiceHandler(String deviceId) =>
      QuickBlue.setServiceHandler(handleServiceDiscovery);

  @override
  void handleServiceDiscovery(String deviceId, String serviceId) {
    logger.i(
        'QuickBlueBluetoothRepo _handleServiceDiscovery $deviceId, $serviceId');
  }

  @override
  void discoverServices(String deviceId) =>
      QuickBlue.discoverServices(deviceId);

  //* Transfer data between BLE central & peripheral
  //* https://pub.dev/packages/quick_blue#transfer-data-between-ble-central--peripheral
  // Data would receive from value handler of `QuickBlue.setValueHandler`

  @override
  void readValue(String deviceId, String serviceId, String characteristicId) =>
      QuickBlue.readValue(deviceId, serviceId, characteristicId);

  @override
  void writeValue({
    required String deviceId,
    required String serviceId,
    required String characteristicId,
    required Uint8List value,
    required BleOutputProperty bleOutputProperty,
  }) =>
      QuickBlue.writeValue(
          deviceId, serviceId, characteristicId, value, bleOutputProperty);
  //* Receive data from peripheral of deviceId
  @override
  void setValueHandler(String deviceId) =>
      QuickBlue.setValueHandler(handleValueChange);

  @override
  void handleValueChange(
      String deviceId, String characteristicId, Uint8List value) {
    logger.i(
        'QuickBlueBluetoothRepo _handleValueChange $deviceId, $characteristicId, ${hex.encode(value)}');
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
}
