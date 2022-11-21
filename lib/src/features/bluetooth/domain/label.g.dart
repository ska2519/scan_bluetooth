// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'label.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Label _$$_LabelFromJson(Map json) => _$_Label(
      bluetooth: Bluetooth.fromJson(
          Map<String, dynamic>.from(json['bluetooth'] as Map)),
      name: json['name'] as String,
      uid: json['uid'] as String,
      user: AppUser.fromJson(Map<String, dynamic>.from(json['user'] as Map)),
      documentId: json['documentId'] as String?,
      createdAt: const TimestampNullableConverter().fromJson(json['createdAt']),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$_LabelToJson(_$_Label instance) => <String, dynamic>{
      'bluetooth': instance.bluetooth.toJson(),
      'name': instance.name,
      'uid': instance.uid,
      'user': instance.user.toJson(),
      'documentId': instance.documentId,
      'createdAt':
          const TimestampNullableConverter().toJson(instance.createdAt),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
