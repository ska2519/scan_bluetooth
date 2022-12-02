// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../exceptions/error_logger.dart';
import '../../firebase/firestore_json_converter.dart';
import 'label.dart';

part 'bluetooth.freezed.dart';
part 'bluetooth.g.dart';

//! ScanResult 를 상속받을 수 있는지

@freezed
class Bluetooth with _$Bluetooth {
  const factory Bluetooth({
    required String name,
    required String deviceId,
    required List<dynamic> manufacturerDataHead,
    required List<dynamic> manufacturerData,
    required int rssi,
    int? previousRssi,
    @TimestampNullableConverter() DateTime? scannedAt,
    @TimestampNullableConverter() DateTime? createdAt,
    @TimestampNullableConverter() DateTime? updatedAt,
    @Default(0) int labelCount,
    Label? firstUpdatedLabel,
    Label? userLabel,
    @Default(false) bool canConnect,
  }) = _Bluetooth;

  @Implements<ScanResult>()
  factory Bluetooth.scanResult(
    BluetoothDevice device,
    AdvertisementData advertisementData,
    int rssi,
    DateTime timeStamp,
  ) {
    logger.i('Bluetooth.scanResult advertisementData: $advertisementData');
    return Bluetooth(
      name: device.name,
      deviceId: device.id.id,
      manufacturerDataHead: [],
      manufacturerData: [],
      rssi: rssi,
      scannedAt: timeStamp,
    );
  }
  factory Bluetooth.fromJson(Map<String, dynamic> json) =>
      _$BluetoothFromJson(json);

  //  int rssiCalculate(int rssi) => (120 - rssi.abs());

}
