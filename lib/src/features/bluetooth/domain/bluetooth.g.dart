// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bluetooth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Bluetooth _$$_BluetoothFromJson(Map json) => _$_Bluetooth(
      deviceId: json['deviceId'] as String,
      name: json['name'] as String,
      type: $enumDecodeNullable(_$BluetoothDeviceTypeEnumMap, json['type']) ??
          BluetoothDeviceType.unknown,
      advertisementData: json['advertisementData'] == null
          ? null
          : AdvertisementData.fromJson(
              Map<String, dynamic>.from(json['advertisementData'] as Map)),
      rssi: json['rssi'] as int,
      previousRssi: json['previousRssi'] as int?,
      userLabel: json['userLabel'] == null
          ? null
          : Label.fromJson(Map<String, dynamic>.from(json['userLabel'] as Map)),
      scannedAt: const TimestampNullableConverter().fromJson(json['scannedAt']),
      createdAt: const TimestampNullableConverter().fromJson(json['createdAt']),
      updatedAt: const TimestampNullableConverter().fromJson(json['updatedAt']),
      labelCount: json['labelCount'] as int? ?? 0,
      canConnect: json['canConnect'] as bool? ?? false,
    );

Map<String, dynamic> _$$_BluetoothToJson(_$_Bluetooth instance) =>
    <String, dynamic>{
      'deviceId': instance.deviceId,
      'name': instance.name,
      'type': _$BluetoothDeviceTypeEnumMap[instance.type]!,
      'advertisementData': instance.advertisementData?.toJson(),
      'rssi': instance.rssi,
      'previousRssi': instance.previousRssi,
      'userLabel': instance.userLabel?.toJson(),
      'scannedAt':
          const TimestampNullableConverter().toJson(instance.scannedAt),
      'createdAt':
          const TimestampNullableConverter().toJson(instance.createdAt),
      'updatedAt':
          const TimestampNullableConverter().toJson(instance.updatedAt),
      'labelCount': instance.labelCount,
      'canConnect': instance.canConnect,
    };

const _$BluetoothDeviceTypeEnumMap = {
  BluetoothDeviceType.unknown: 'unknown',
  BluetoothDeviceType.classic: 'classic',
  BluetoothDeviceType.le: 'le',
  BluetoothDeviceType.dual: 'dual',
};

_$_AdvertisementData _$$_AdvertisementDataFromJson(Map json) =>
    _$_AdvertisementData(
      localName: json['localName'] as String,
      txPowerLevel: json['txPowerLevel'] as int?,
      connectable: json['connectable'] as bool,
      manufacturerData: (json['manufacturerData'] as Map).map(
        (k, e) => MapEntry(int.parse(k as String),
            (e as List<dynamic>).map((e) => e as int).toList()),
      ),
      serviceData: (json['serviceData'] as Map).map(
        (k, e) => MapEntry(
            k as String, (e as List<dynamic>).map((e) => e as int).toList()),
      ),
      serviceUuids: (json['serviceUuids'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$_AdvertisementDataToJson(
        _$_AdvertisementData instance) =>
    <String, dynamic>{
      'localName': instance.localName,
      'txPowerLevel': instance.txPowerLevel,
      'connectable': instance.connectable,
      'manufacturerData':
          instance.manufacturerData.map((k, e) => MapEntry(k.toString(), e)),
      'serviceData': instance.serviceData,
      'serviceUuids': instance.serviceUuids,
    };
