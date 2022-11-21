import 'package:quick_blue/quick_blue.dart';

import 'scan_bluetooth_repository.dart';

class QuickBlueBluetoothRepo implements ScanBlueToothRepository {
  QuickBlueBluetoothRepo({this.addDelay = true});
  final bool addDelay;

  @override
  Future<bool> isBluetoothAvailable() async =>
      await QuickBlue.isBluetoothAvailable();

  @override
  void startScan() => QuickBlue.startScan();

  @override
  void stopScan() => QuickBlue.stopScan();

  @override
  Stream<BlueScanResult> scanResultStream() => QuickBlue.scanResultStream;

  @override
  void connect(String deviceId) {
    QuickBlue.connect(deviceId);
  }
}
