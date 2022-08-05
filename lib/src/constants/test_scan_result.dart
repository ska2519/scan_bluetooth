// import 'package:quick_blue/models.dart';
import 'dart:typed_data';

import 'package:mocktail/mocktail.dart';
import 'package:quick_blue/quick_blue.dart';

class MockBlueScanResult extends Mock implements BlueScanResult {
  MockBlueScanResult({
    required String name,
    required String deviceId,
    Uint8List? manufacturerDataHead,
    Uint8List? manufacturerData,
    required int rssi,
  });
}

/// Test products to be used until a data source is implemented
final kBlueScanResult = MockBlueScanResult(
  name: 'name',
  deviceId: 'deviceId',
  rssi: 18,
);
// final kBlueScanResult = MockBlueScanResult();

