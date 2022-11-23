// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Profile _$$_ProfileFromJson(Map json) => _$_Profile(
      uid: json['uid'] as String?,
      nickname: json['nickname'] as String?,
      aboutMe: json['aboutMe'] as String?,
      birthday: json['birthday'] == null
          ? null
          : DateTime.parse(json['birthday'] as String),
      interests: (json['interests'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      languages: (json['languages'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      photoUrls: (json['photoUrls'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      location: _$JsonConverterFromJson<GeoPoint, GeoPoint>(
          json['location'], const FirestoreGeoPointConverter().fromJson),
      verified: json['verified'] as bool? ?? false,
    );

Map<String, dynamic> _$$_ProfileToJson(_$_Profile instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'nickname': instance.nickname,
      'aboutMe': instance.aboutMe,
      'birthday': instance.birthday?.toIso8601String(),
      'interests': instance.interests,
      'languages': instance.languages,
      'photoUrls': instance.photoUrls,
      'location': _$JsonConverterToJson<GeoPoint, GeoPoint>(
          instance.location, const FirestoreGeoPointConverter().toJson),
      'verified': instance.verified,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
