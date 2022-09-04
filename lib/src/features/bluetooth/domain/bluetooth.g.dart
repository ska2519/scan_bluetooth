// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bluetooth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Bluetooth _$$_BluetoothFromJson(Map<String, dynamic> json) => _$_Bluetooth(
      name: json['name'] as String,
      deviceId: json['deviceId'] as String,
      manufacturerDataHead: json['manufacturerDataHead'] as List<dynamic>,
      manufacturerData: json['manufacturerData'] as List<dynamic>,
      rssi: json['rssi'] as int,
      previousRssi: json['previousRssi'] as int?,
      scannedAt: const ServerTimestampConverter().fromJson(json['scannedAt']),
      createdAt: const ServerTimestampConverter().fromJson(json['createdAt']),
      updatedAt: const ServerTimestampConverter().fromJson(json['updatedAt']),
      labelCount:
          const FieldValueIncrementConverter().fromJson(json['labelCount']),
      lastUpdatedLabel: json['lastUpdatedLabel'] == null
          ? null
          : Label.fromJson(json['lastUpdatedLabel'] as Map<String, dynamic>),
      userLabel: json['userLabel'] == null
          ? null
          : Label.fromJson(json['userLabel'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_BluetoothToJson(_$_Bluetooth instance) =>
    <String, dynamic>{
      'name': instance.name,
      'deviceId': instance.deviceId,
      'manufacturerDataHead': instance.manufacturerDataHead,
      'manufacturerData': instance.manufacturerData,
      'rssi': instance.rssi,
      'previousRssi': instance.previousRssi,
      'scannedAt': const ServerTimestampConverter().toJson(instance.scannedAt),
      'createdAt': const ServerTimestampConverter().toJson(instance.createdAt),
      'updatedAt': const ServerTimestampConverter().toJson(instance.updatedAt),
      'labelCount':
          const FieldValueIncrementConverter().toJson(instance.labelCount),
      'lastUpdatedLabel': instance.lastUpdatedLabel?.toJson(),
      'userLabel': instance.userLabel?.toJson(),
    };
