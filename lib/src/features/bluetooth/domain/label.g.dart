// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'label.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Label _$$_LabelFromJson(Map json) => _$_Label(
      deviceId: json['deviceId'] as String?,
      type: $enumDecodeNullable(_$BluetoothDeviceTypeEnumMap, json['type']),
      name: json['name'] as String,
      rssi: json['rssi'] as int?,
      uid: json['uid'] as String,
      documentId: json['documentId'] as String?,
      updatedAt: const TimestampNullableConverter().fromJson(json['updatedAt']),
      createdAt: const TimestampNullableConverter().fromJson(json['createdAt']),
      bluetooth: json['bluetooth'] == null
          ? null
          : Bluetooth.fromJson(
              Map<String, dynamic>.from(json['bluetooth'] as Map)),
      user: json['user'] == null
          ? null
          : AppUser.fromJson(Map<String, dynamic>.from(json['user'] as Map)),
    );

Map<String, dynamic> _$$_LabelToJson(_$_Label instance) => <String, dynamic>{
      'deviceId': instance.deviceId,
      'type': _$BluetoothDeviceTypeEnumMap[instance.type],
      'name': instance.name,
      'rssi': instance.rssi,
      'uid': instance.uid,
      'documentId': instance.documentId,
      'updatedAt':
          const TimestampNullableConverter().toJson(instance.updatedAt),
      'createdAt':
          const TimestampNullableConverter().toJson(instance.createdAt),
      'bluetooth': instance.bluetooth?.toJson(),
      'user': instance.user?.toJson(),
    };

const _$BluetoothDeviceTypeEnumMap = {
  BluetoothDeviceType.unknown: 'unknown',
  BluetoothDeviceType.classic: 'classic',
  BluetoothDeviceType.le: 'le',
  BluetoothDeviceType.dual: 'dual',
};
