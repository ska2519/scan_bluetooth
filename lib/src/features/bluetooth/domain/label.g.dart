// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'label.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Label _$$_LabelFromJson(Map json) => _$_Label(
      name: json['name'] as String,
      uid: json['uid'] as String,
      user: AppUser.fromJson(Map<String, dynamic>.from(json['user'] as Map)),
      bluetoothName: json['bluetoothName'] as String,
      deviceId: json['deviceId'] as String,
      rssi: json['rssi'] as int,
      documentId: json['documentId'] as String?,
      createdAt: const TimestampConverter().fromJson(json['createdAt']),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$_LabelToJson(_$_Label instance) => <String, dynamic>{
      'name': instance.name,
      'uid': instance.uid,
      'user': instance.user.toJson(),
      'bluetoothName': instance.bluetoothName,
      'deviceId': instance.deviceId,
      'rssi': instance.rssi,
      'documentId': instance.documentId,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
