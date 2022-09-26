// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bluetooth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Bluetooth _$$_BluetoothFromJson(Map json) => _$_Bluetooth(
      name: json['name'] as String,
      deviceId: json['deviceId'] as String,
      manufacturerDataHead: json['manufacturerDataHead'] as List<dynamic>,
      manufacturerData: json['manufacturerData'] as List<dynamic>,
      rssi: json['rssi'] as int,
      previousRssi: json['previousRssi'] as int?,
      scannedAt: const TimestampConverter().fromJson(json['scannedAt']),
      createdAt: const TimestampConverter().fromJson(json['createdAt']),
      updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
      labelCount: json['labelCount'] as int?,
      lastUpdatedLabel: json['lastUpdatedLabel'] == null
          ? null
          : Label.fromJson(
              Map<String, dynamic>.from(json['lastUpdatedLabel'] as Map)),
      userLabel: json['userLabel'] == null
          ? null
          : Label.fromJson(Map<String, dynamic>.from(json['userLabel'] as Map)),
    );

Map<String, dynamic> _$$_BluetoothToJson(_$_Bluetooth instance) =>
    <String, dynamic>{
      'name': instance.name,
      'deviceId': instance.deviceId,
      'manufacturerDataHead': instance.manufacturerDataHead,
      'manufacturerData': instance.manufacturerData,
      'rssi': instance.rssi,
      'previousRssi': instance.previousRssi,
      'scannedAt': const TimestampConverter().toJson(instance.scannedAt),
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
      'labelCount': instance.labelCount,
      'lastUpdatedLabel': instance.lastUpdatedLabel?.toJson(),
      'userLabel': instance.userLabel?.toJson(),
    };
