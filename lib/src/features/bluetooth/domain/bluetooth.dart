// ignore_for_file: public_member_api_docs, sort_constructors_first, provide_deprecation_message

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../firebase/firestore_json_converter.dart';
import 'label.dart';

part 'bluetooth.freezed.dart';
part 'bluetooth.g.dart';

enum BluetoothDeviceType { unknown, classic, le, dual }

@freezed
class Bluetooth with _$Bluetooth {
  const factory Bluetooth({
    required String deviceId,
    required String name,
    @Default(BluetoothDeviceType.unknown) BluetoothDeviceType type,
    AdvertisementData? advertisementData,
    required int rssi,
    int? previousRssi,
    Label? userLabel,
    @TimestampNullableConverter() DateTime? scannedAt,
    @TimestampNullableConverter() DateTime? createdAt,
    @TimestampNullableConverter() DateTime? updatedAt,
    @Default(0) int labelCount,
    @Default(false) bool canConnect,
    // @deprecated Label? firstUpdatedLabel,
    // @deprecated List<dynamic>? manufacturerDataHead,
    // @deprecated List<dynamic>? manufacturerData,
  }) = _Bluetooth;

  factory Bluetooth.fromJson(Map<String, dynamic> json) =>
      _$BluetoothFromJson(json);
}

@freezed
class AdvertisementData with _$AdvertisementData {
  const factory AdvertisementData({
    required String localName,
    int? txPowerLevel,
    required bool connectable,
    required Map<int, List<int>> manufacturerData,
    required Map<String, List<int>> serviceData,
    required List<String> serviceUuids,
  }) = _AdvertisementData;

  factory AdvertisementData.fromJson(Map<String, dynamic> json) =>
      _$AdvertisementDataFromJson(json);
}
