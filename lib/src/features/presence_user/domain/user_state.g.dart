// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserState _$$_UserStateFromJson(Map json) => _$_UserState(
      state: json['state'] as String,
      lastCanged: const TimestampConverter().fromJson(json['last_changed']),
      isAnonymous: json['is_anonymous'] as bool,
      uid: json['uid'] as String?,
    );

Map<String, dynamic> _$$_UserStateToJson(_$_UserState instance) =>
    <String, dynamic>{
      'state': instance.state,
      'last_changed': const TimestampConverter().toJson(instance.lastCanged),
      'is_anonymous': instance.isAnonymous,
      'uid': instance.uid,
    };
