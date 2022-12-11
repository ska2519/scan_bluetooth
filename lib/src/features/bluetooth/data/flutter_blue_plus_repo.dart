// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'scan_bluetooth_repository.dart';

class FlutterBluePlusRepo implements ScanBluetoothRepository {
  FlutterBluePlusRepo({this.addDelay = true});
  final bool addDelay;

// flutterBlue
  static final fbp = FlutterBluePlus.instance;

  @override
  Future<bool> get isBluetoothAvailable => fbp.isAvailable;

  @override
  Stream<BluetoothState> get bluetoothStateStream => fbp.state;

  @override
  Future<List<BluetoothDevice>> get connectedDevices => fbp.connectedDevices;

  //* Scan BLE peripheral
  //* https://pub.dev/packages/quick_blue#scan-ble-peripheral

  @override
  Stream<ScanResult> startScanStream() => fbp.scan(
        fastScan: true,
        allowDuplicates: true,
        scanMode: ScanMode.lowPower,
      );

  @override
  Future<dynamic> stopScan() => fbp.stopScan();

  // @override
  // Stream<List<ScanResult>> scanResultListStream() => flutterBlue.scanResults;
}
