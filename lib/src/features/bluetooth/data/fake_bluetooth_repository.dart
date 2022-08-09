import 'package:quick_blue/models.dart';

import '../../../constants/test_scan_result.dart';
import '../../../utils/in_memory_store.dart';
import 'bluetooth_repository.dart';

class FakeBluetoothRepository implements BluetoothRepository {
  FakeBluetoothRepository({this.addDelay = true});
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
}
