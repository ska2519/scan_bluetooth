// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'scan_bluetooth_repository.dart';

class FlutterBluePlusRepo implements ScanBluetoothRepository {
  FlutterBluePlusRepo({this.addDelay = true});
  final bool addDelay;

// flutterBlue
  static final FlutterBluePlus flutterBlue = FlutterBluePlus.instance;

  @override
  Future<bool> isBluetoothAvailable() async => await flutterBlue.isAvailable;

  //* Scan BLE peripheral
  //* https://pub.dev/packages/quick_blue#scan-ble-peripheral

  @override
  Stream<ScanResult> startScanStream() => flutterBlue.scan(
        fastScan: true,
        allowDuplicates: true,
        scanMode: ScanMode.lowPower,
      );

  @override
  Future<dynamic> stopScan() => flutterBlue.stopScan();

  // @override
  // Stream<List<ScanResult>> scanResultListStream() => flutterBlue.scanResults;
}
