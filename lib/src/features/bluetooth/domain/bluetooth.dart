// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../firebase/firestore_json_converter.dart';
import 'label.dart';

part 'bluetooth.freezed.dart';
part 'bluetooth.g.dart';

@freezed
class Bluetooth with _$Bluetooth {
  const factory Bluetooth({
    required String name,
    required String deviceId,
    required List<dynamic> manufacturerDataHead,
    required List<dynamic> manufacturerData,
    required int rssi,
    int? previousRssi,
    @ServerTimestampConverter() DateTime? scannedAt,
    @ServerTimestampConverter() DateTime? createdAt,
    @ServerTimestampConverter() DateTime? updatedAt,
    @FieldValueIncrementConverter() int? labelCount,
    Label? lastUpdatedLabel,
    Label? userLabel,
  }) = _Bluetooth;

  factory Bluetooth.fromJson(Map<String, dynamic> json) =>
      _$BluetoothFromJson(json);
}
