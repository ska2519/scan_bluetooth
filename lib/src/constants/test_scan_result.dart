import 'package:flutter_blue_plus/gen/flutterblueplus.pb.dart';

/// Test products to be used until a data source is implemented
final kTestScanResult = [
  ScanResult(
    device: BluetoothDevice(name: 'test1'),
    advertisementData: AdvertisementData(),
    rssi: 1,
  ),
  ScanResult(
    device: BluetoothDevice(name: 'test2'),
    advertisementData: AdvertisementData(),
    rssi: 1,
  ),
];
