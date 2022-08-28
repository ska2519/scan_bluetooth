// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AppUser _$$_AppUserFromJson(Map<String, dynamic> json) => _$_AppUser(
      uid: json['uid'] as String,
      email: json['email'] as String?,
      displayName: json['displayName'] as String?,
      emailVerified: json['emailVerified'] as bool?,
      isAnonymous: json['isAnonymous'] as bool?,
      metadata: json['metadata'] == null
          ? null
          : UserMetadata.fromJson(json['metadata'] as Map<String, dynamic>),
      phoneNumber: json['phoneNumber'] as String?,
      photoURL: json['photoURL'] as String?,
      providerData: (json['providerData'] as List<dynamic>?)
          ?.map((e) => UserInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      refreshToken: json['refreshToken'] as String?,
      tenantId: json['tenantId'] as String?,
      estimateIds: (json['estimateIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      hasEstimate: json['hasEstimate'] as bool? ?? false,
    );

Map<String, dynamic> _$$_AppUserToJson(_$_AppUser instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'displayName': instance.displayName,
      'emailVerified': instance.emailVerified,
      'isAnonymous': instance.isAnonymous,
      'metadata': instance.metadata,
      'phoneNumber': instance.phoneNumber,
      'photoURL': instance.photoURL,
      'providerData': instance.providerData,
      'refreshToken': instance.refreshToken,
      'tenantId': instance.tenantId,
      'estimateIds': instance.estimateIds,
      'hasEstimate': instance.hasEstimate,
    };

_$_UserMetadata _$$_UserMetadataFromJson(Map<String, dynamic> json) =>
    _$_UserMetadata(
      creationTime: json['creationTime'] == null
          ? null
          : DateTime.parse(json['creationTime'] as String),
      lastSignInTime: json['lastSignInTime'] == null
          ? null
          : DateTime.parse(json['lastSignInTime'] as String),
    );

Map<String, dynamic> _$$_UserMetadataToJson(_$_UserMetadata instance) =>
    <String, dynamic>{
      'creationTime': instance.creationTime?.toIso8601String(),
      'lastSignInTime': instance.lastSignInTime?.toIso8601String(),
    };

_$_UserInfo _$$_UserInfoFromJson(Map<String, dynamic> json) => _$_UserInfo(
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
