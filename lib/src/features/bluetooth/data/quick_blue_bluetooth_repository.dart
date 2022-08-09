import 'package:quick_blue/quick_blue.dart';

import 'bluetooth_repository.dart';

class QuickBlueBluetoothRepository implements BluetoothRepository {
  QuickBlueBluetoothRepository({this.addDelay = true});
  final bool addDelay;

  @override
  Future<bool> isBluetoothAvailable() => QuickBlue.isBluetoothAvailable();

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
