// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AppUser _$$_AppUserFromJson(Map json) => _$_AppUser(
      uid: json['uid'] as String,
      email: json['email'] as String?,
      displayName: json['displayName'] as String?,
      emailVerified: json['emailVerified'] as bool?,
      isAnonymous: json['isAnonymous'] as bool?,
      phoneNumber: json['phoneNumber'] as String?,
      photoURL: json['photoURL'] as String?,
      providerData: (json['providerData'] as List<dynamic>?)
          ?.map((e) => UserInfo.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      refreshToken: json['refreshToken'] as String?,
      tenantId: json['tenantId'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      lastSignIn: json['lastSignIn'] == null
          ? null
          : DateTime.parse(json['lastSignIn'] as String),
    );

Map<String, dynamic> _$$_AppUserToJson(_$_AppUser instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'displayName': instance.displayName,
      'emailVerified': instance.emailVerified,
      'isAnonymous': instance.isAnonymous,
      'phoneNumber': instance.phoneNumber,
      'photoURL': instance.photoURL,
      'providerData': instance.providerData?.map((e) => e.toJson()).toList(),
      'refreshToken': instance.refreshToken,
      'tenantId': instance.tenantId,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'lastSignIn': instance.lastSignIn?.toIso8601String(),
    };

_$_UserInfo _$$_UserInfoFromJson(Map json) => _$_UserInfo(
      displayName: json['displayName'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      photoURL: json['photoURL'] as String?,
      providerId: json['providerId'] as String?,
      uid: json['uid'] as String?,
    );

Map<String, dynamic> _$$_UserInfoToJson(_$_UserInfo instance) =>
    <String, dynamic>{
      'displayName': instance.displayName,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'photoURL': instance.photoURL,
      'providerId': instance.providerId,
      'uid': instance.uid,
    };
