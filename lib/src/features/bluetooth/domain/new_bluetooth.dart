// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:typed_data';

import 'package:mocktail/mocktail.dart';
import 'package:quick_blue/models.dart';

class NewBluetooth extends Mock implements BlueScanResult {
  NewBluetooth({
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

  NewBluetooth copyWith({
    String? name,
    String? deviceId,
    Uint8List? manufacturerDataHead,
    Uint8List? manufacturerData,
    int? rssi,
    int? previousRssi,
  }) {
    return NewBluetooth(
      name: name ?? this.name,
      deviceId: deviceId ?? this.deviceId,
      manufacturerDataHead: manufacturerDataHead ?? this.manufacturerDataHead,
      manufacturerData: manufacturerData ?? this.manufacturerData,
      rssi: rssi ?? this.rssi,
      previousRssi: previousRssi ?? this.previousRssi,
    );
  }
}
