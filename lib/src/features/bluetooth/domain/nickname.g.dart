// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nickname.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Nickname _$$_NicknameFromJson(Map<String, dynamic> json) => _$_Nickname(
      nickname: json['nickname'] as String,
      user: AppUser.fromJson(json['user'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$_NicknameToJson(_$_Nickname instance) =>
    <String, dynamic>{
      'nickname': instance.nickname,
      'user': instance.user,
      'createdAt': instance.createdAt.toIso8601String(),
    };
