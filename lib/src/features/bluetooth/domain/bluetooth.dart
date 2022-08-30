// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:typed_data';

import 'package:mocktail/mocktail.dart';
import 'package:quick_blue/models.dart';

class Bluetooth extends Mock implements BlueScanResult {
  Bluetooth({
    required this.name,
    required this.deviceId,
    required this.manufacturerDataHead,
    required this.manufacturerData,
    required this.rssi,
    this.previousRssi,
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
  final int? previousRssi;

  Bluetooth copyWith({
    String? name,
    String? deviceId,
    Uint8List? manufacturerDataHead,
    Uint8List? manufacturerData,
    int? rssi,
    int? previousRssi,
  }) {
    return Bluetooth(
      name: name ?? this.name,
      deviceId: deviceId ?? this.deviceId,
      manufacturerDataHead: manufacturerDataHead ?? this.manufacturerDataHead,
      manufacturerData: manufacturerData ?? this.manufacturerData,
      rssi: rssi ?? this.rssi,
      previousRssi: previousRssi ?? this.previousRssi,
    );
  }

  @override
  String toString() {
    return 'NewBluetooth(name: $name, deviceId: $deviceId, manufacturerDataHead: $manufacturerDataHead, manufacturerData: $manufacturerData, rssi: $rssi, previousRssi: $previousRssi)';
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'deviceId': deviceId,
      'manufacturerDataHead': manufacturerDataHead,
      'manufacturerData': manufacturerData,
      'rssi': rssi,
      'previousRssi': previousRssi,
    };
  }

  factory Bluetooth.fromMap(Map<String, dynamic> map) {
    return Bluetooth(
      name: map['name'] as String,
      deviceId: map['deviceId'] as String,
      manufacturerDataHead: map['manufacturerDataHead'] as Uint8List,
      manufacturerData: map['manufacturerData'] as Uint8List,
      rssi: map['rssi'] as int,
      previousRssi:
          map['previousRssi'] != null ? map['previousRssi'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Bluetooth.fromJson(String source) =>
      Bluetooth.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant Bluetooth other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.deviceId == deviceId &&
        other.manufacturerDataHead == manufacturerDataHead &&
        other.manufacturerData == manufacturerData &&
        other.rssi == rssi &&
        other.previousRssi == previousRssi;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        deviceId.hashCode ^
        manufacturerDataHead.hashCode ^
        manufacturerData.hashCode ^
        rssi.hashCode ^
        previousRssi.hashCode;
  }
}
