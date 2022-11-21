// import 'package:quick_blue/models.dart';
import 'dart:typed_data';

import 'package:mocktail/mocktail.dart';
import 'package:quick_blue/quick_blue.dart';

class MockBlueScanResult extends Mock implements BlueScanResult {
  MockBlueScanResult({
    required this.name,
    required this.deviceId,
    required this.manufacturerDataHead,
    required this.manufacturerData,
    required this.rssi,
  }) : super();

  @override
  final String name;
  @override
  final String deviceId;
  @override
  final Uint8List manufacturerDataHead;
  @override
  final Uint8List manufacturerData;
  @override
  final int rssi;
}

/// Test products to be used until a data source is implemented
final kBlueScanResult = MockBlueScanResult(
  name: 'kBlueScanResult name',
  deviceId: 'kBlueScanResult deviceId',
  manufacturerDataHead: Uint8List.fromList(List.empty()),
  manufacturerData: Uint8List.fromList(List.empty()),
  rssi: 18,
);
// final kBlueScanResult = MockBlueScanResult();
