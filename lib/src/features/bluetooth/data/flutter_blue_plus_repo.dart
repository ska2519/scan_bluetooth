// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import '../../../exceptions/error_logger.dart';
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
  void startScan() => flutterBlue.startScan();

  @override
  void stopScan() => flutterBlue.stopScan();

// Listen to scan results
  var subscription = flutterBlue.scanResults.listen((results) {
    // do something with scan results
    for (var r in results) {
      logger.i('${r.device.name} found! rssi: ${r.rssi}');
    }
  });

  @override
  Stream<List<ScanResult>> scanResultListStream() => flutterBlue.scanResults;
}
