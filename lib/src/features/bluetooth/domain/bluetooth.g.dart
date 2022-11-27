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
      scannedAt: const TimestampNullableConverter().fromJson(json['scannedAt']),
      createdAt: const TimestampNullableConverter().fromJson(json['createdAt']),
      updatedAt: const TimestampNullableConverter().fromJson(json['updatedAt']),
      labelCount: json['labelCount'] as int? ?? 0,
      firstUpdatedLabel: json['firstUpdatedLabel'] == null
          ? null
          : Label.fromJson(
              Map<String, dynamic>.from(json['firstUpdatedLabel'] as Map)),
      userLabel: json['userLabel'] == null
          ? null
          : Label.fromJson(Map<String, dynamic>.from(json['userLabel'] as Map)),
      canConnect: json['canConnect'] as bool? ?? false,
    );

Map<String, dynamic> _$$_BluetoothToJson(_$_Bluetooth instance) =>
    <String, dynamic>{
      'name': instance.name,
      'deviceId': instance.deviceId,
      'manufacturerDataHead': instance.manufacturerDataHead,
      'manufacturerData': instance.manufacturerData,
      'rssi': instance.rssi,
      'previousRssi': instance.previousRssi,
      'scannedAt':
          const TimestampNullableConverter().toJson(instance.scannedAt),
      'createdAt':
          const TimestampNullableConverter().toJson(instance.createdAt),
      'updatedAt':
          const TimestampNullableConverter().toJson(instance.updatedAt),
      'labelCount': instance.labelCount,
      'firstUpdatedLabel': instance.firstUpdatedLabel?.toJson(),
      'userLabel': instance.userLabel?.toJson(),
      'canConnect': instance.canConnect,
    };
