// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'app_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AppUser _$AppUserFromJson(Map<String, dynamic> json) {
  return _AppUser.fromJson(json);
}

/// @nodoc
mixin _$AppUser {
  String get uid => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get displayName => throw _privateConstructorUsedError;
  bool? get emailVerified => throw _privateConstructorUsedError;
  bool? get isAnonymous => throw _privateConstructorUsedError;
  UserMetadata? get metadata => throw _privateConstructorUsedError;
  String? get phoneNumber => throw _privateConstructorUsedError;
  String? get photoURL => throw _privateConstructorUsedError;
  List<UserInfo>? get providerData => throw _privateConstructorUsedError;
  String? get refreshToken => throw _privateConstructorUsedError;
  String? get tenantId => throw _privateConstructorUsedError;
  List<String> get estimateIds => throw _privateConstructorUsedError;
  bool get hasEstimate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppUserCopyWith<AppUser> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppUserCopyWith<$Res> {
  factory $AppUserCopyWith(AppUser value, $Res Function(AppUser) then) =
      _$AppUserCopyWithImpl<$Res>;
  $Res call(
      {String uid,
      String? email,
      String? displayName,
      bool? emailVerified,
      bool? isAnonymous,
      UserMetadata? metadata,
      String? phoneNumber,
      String? photoURL,
      List<UserInfo>? providerData,
      String? refreshToken,
      String? tenantId,
      List<String> estimateIds,
      bool hasEstimate});

  $UserMetadataCopyWith<$Res>? get metadata;
}

/// @nodoc
class _$AppUserCopyWithImpl<$Res> implements $AppUserCopyWith<$Res> {
  _$AppUserCopyWithImpl(this._value, this._then);

  final AppUser _value;
  // ignore: unused_field
  final $Res Function(AppUser) _then;

  @override
  $Res call({
    Object? uid = freezed,
    Object? email = freezed,
    Object? displayName = freezed,
    Object? emailVerified = freezed,
    Object? isAnonymous = freezed,
    Object? metadata = freezed,
    Object? phoneNumber = freezed,
    Object? photoURL = freezed,
    Object? providerData = freezed,
    Object? refreshToken = freezed,
    Object? tenantId = freezed,
    Object? estimateIds = freezed,
    Object? hasEstimate = freezed,
  }) {
    return _then(_value.copyWith(
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      displayName: displayName == freezed
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      emailVerified: emailVerified == freezed
          ? _value.emailVerified
          : emailVerified // ignore: cast_nullable_to_non_nullable
              as bool?,
      isAnonymous: isAnonymous == freezed
          ? _value.isAnonymous
          : isAnonymous // ignore: cast_nullable_to_non_nullable
              as bool?,
      metadata: metadata == freezed
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as UserMetadata?,
      phoneNumber: phoneNumber == freezed
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      photoURL: photoURL == freezed
          ? _value.photoURL
          : photoURL // ignore: cast_nullable_to_non_nullable
              as String?,
      providerData: providerData == freezed
          ? _value.providerData
          : providerData // ignore: cast_nullable_to_non_nullable
              as List<UserInfo>?,
      refreshToken: refreshToken == freezed
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String?,
      tenantId: tenantId == freezed
          ? _value.tenantId
          : tenantId // ignore: cast_nullable_to_non_nullable
              as String?,
      estimateIds: estimateIds == freezed
          ? _value.estimateIds
          : estimateIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      hasEstimate: hasEstimate == freezed
          ? _value.hasEstimate
          : hasEstimate // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  @override
  $UserMetadataCopyWith<$Res>? get metadata {
    if (_value.metadata == null) {
      return null;
    }

    return $UserMetadataCopyWith<$Res>(_value.metadata!, (value) {
      return _then(_value.copyWith(metadata: value));
    });
  }
}

/// @nodoc
abstract class _$$_AppUserCopyWith<$Res> implements $AppUserCopyWith<$Res> {
  factory _$$_AppUserCopyWith(
          _$_AppUser value, $Res Function(_$_AppUser) then) =
      __$$_AppUserCopyWithImpl<$Res>;
  @override
  $Res call(
      {String uid,
      String? email,
      String? displayName,
      bool? emailVerified,
      bool? isAnonymous,
      UserMetadata? metadata,
      String? phoneNumber,
      String? photoURL,
      List<UserInfo>? providerData,
      String? refreshToken,
      String? tenantId,
      List<String> estimateIds,
      bool hasEstimate});

  @override
  $UserMetadataCopyWith<$Res>? get metadata;
}

/// @nodoc
class __$$_AppUserCopyWithImpl<$Res> extends _$AppUserCopyWithImpl<$Res>
    implements _$$_AppUserCopyWith<$Res> {
  __$$_AppUserCopyWithImpl(_$_AppUser _value, $Res Function(_$_AppUser) _then)
      : super(_value, (v) => _then(v as _$_AppUser));

  @override
  _$_AppUser get _value => super._value as _$_AppUser;

  @override
  $Res call({
    Object? uid = freezed,
    Object? email = freezed,
    Object? displayName = freezed,
    Object? emailVerified = freezed,
    Object? isAnonymous = freezed,
    Object? metadata = freezed,
    Object? phoneNumber = freezed,
    Object? photoURL = freezed,
    Object? providerData = freezed,
    Object? refreshToken = freezed,
    Object? tenantId = freezed,
    Object? estimateIds = freezed,
    Object? hasEstimate = freezed,
  }) {
    return _then(_$_AppUser(
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      displayName: displayName == freezed
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      emailVerified: emailVerified == freezed
          ? _value.emailVerified
          : emailVerified // ignore: cast_nullable_to_non_nullable
              as bool?,
      isAnonymous: isAnonymous == freezed
          ? _value.isAnonymous
          : isAnonymous // ignore: cast_nullable_to_non_nullable
              as bool?,
      metadata: metadata == freezed
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as UserMetadata?,
      phoneNumber: phoneNumber == freezed
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      photoURL: photoURL == freezed
          ? _value.photoURL
          : photoURL // ignore: cast_nullable_to_non_nullable
              as String?,
      providerData: providerData == freezed
          ? _value._providerData
          : providerData // ignore: cast_nullable_to_non_nullable
              as List<UserInfo>?,
      refreshToken: refreshToken == freezed
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String?,
      tenantId: tenantId == freezed
          ? _value.tenantId
          : tenantId // ignore: cast_nullable_to_non_nullable
              as String?,
      estimateIds: estimateIds == freezed
          ? _value._estimateIds
          : estimateIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      hasEstimate: hasEstimate == freezed
          ? _value.hasEstimate
          : hasEstimate // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AppUser implements _AppUser {
  const _$_AppUser(
      {required this.uid,
      this.email,
      this.displayName,
      this.emailVerified,
      this.isAnonymous,
      this.metadata,
      this.phoneNumber,
      this.photoURL,
      final List<UserInfo>? providerData,
      this.refreshToken,
      this.tenantId,
      final List<String> estimateIds = const [],
      this.hasEstimate = false})
      : _providerData = providerData,
        _estimateIds = estimateIds;

  factory _$_AppUser.fromJson(Map<String, dynamic> json) =>
      _$$_AppUserFromJson(json);

  @override
  final String uid;
  @override
  final String? email;
  @override
  final String? displayName;
  @override
  final bool? emailVerified;
  @override
  final bool? isAnonymous;
  @override
  final UserMetadata? metadata;
  @override
  final String? phoneNumber;
  @override
  final String? photoURL;
  final List<UserInfo>? _providerData;
  @override
  List<UserInfo>? get providerData {
    final value = _providerData;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? refreshToken;
  @override
  final String? tenantId;
  final List<String> _estimateIds;
  @override
  @JsonKey()
  List<String> get estimateIds {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_estimateIds);
  }

  @override
  @JsonKey()
  final bool hasEstimate;

  @override
  String toString() {
    return 'AppUser(uid: $uid, email: $email, displayName: $displayName, emailVerified: $emailVerified, isAnonymous: $isAnonymous, metadata: $metadata, phoneNumber: $phoneNumber, photoURL: $photoURL, providerData: $providerData, refreshToken: $refreshToken, tenantId: $tenantId, estimateIds: $estimateIds, hasEstimate: $hasEstimate)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AppUser &&
            const DeepCollectionEquality().equals(other.uid, uid) &&
            const DeepCollectionEquality().equals(other.email, email) &&
            const DeepCollectionEquality()
                .equals(other.displayName, displayName) &&
            const DeepCollectionEquality()
                .equals(other.emailVerified, emailVerified) &&
            const DeepCollectionEquality()
                .equals(other.isAnonymous, isAnonymous) &&
            const DeepCollectionEquality().equals(other.metadata, metadata) &&
            const DeepCollectionEquality()
                .equals(other.phoneNumber, phoneNumber) &&
            const DeepCollectionEquality().equals(other.photoURL, photoURL) &&
            const DeepCollectionEquality()
                .equals(other._providerData, _providerData) &&
            const DeepCollectionEquality()
                .equals(other.refreshToken, refreshToken) &&
            const DeepCollectionEquality().equals(other.tenantId, tenantId) &&
            const DeepCollectionEquality()
                .equals(other._estimateIds, _estimateIds) &&
            const DeepCollectionEquality()
                .equals(other.hasEstimate, hasEstimate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(uid),
      const DeepCollectionEquality().hash(email),
      const DeepCollectionEquality().hash(displayName),
      const DeepCollectionEquality().hash(emailVerified),
      const DeepCollectionEquality().hash(isAnonymous),
      const DeepCollectionEquality().hash(metadata),
      const DeepCollectionEquality().hash(phoneNumber),
      const DeepCollectionEquality().hash(photoURL),
      const DeepCollectionEquality().hash(_providerData),
      const DeepCollectionEquality().hash(refreshToken),
      const DeepCollectionEquality().hash(tenantId),
      const DeepCollectionEquality().hash(_estimateIds),
      const DeepCollectionEquality().hash(hasEstimate));

  @JsonKey(ignore: true)
  @override
  _$$_AppUserCopyWith<_$_AppUser> get copyWith =>
      __$$_AppUserCopyWithImpl<_$_AppUser>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AppUserToJson(
      this,
    );
  }
}

abstract class _AppUser implements AppUser {
  const factory _AppUser(
      {required final String uid,
      final String? email,
      final String? displayName,
      final bool? emailVerified,
      final bool? isAnonymous,
      final UserMetadata? metadata,
      final String? phoneNumber,
      final String? photoURL,
      final List<UserInfo>? providerData,
      final String? refreshToken,
      final String? tenantId,
      final List<String> estimateIds,
      final bool hasEstimate}) = _$_AppUser;

  factory _AppUser.fromJson(Map<String, dynamic> json) = _$_AppUser.fromJson;

  @override
  String get uid;
  @override
  String? get email;
  @override
  String? get displayName;
  @override
  bool? get emailVerified;
  @override
  bool? get isAnonymous;
  @override
  UserMetadata? get metadata;
  @override
  String? get phoneNumber;
  @override
  String? get photoURL;
  @override
  List<UserInfo>? get providerData;
  @override
  String? get refreshToken;
  @override
  String? get tenantId;
  @override
  List<String> get estimateIds;
  @override
  bool get hasEstimate;
  @override
  @JsonKey(ignore: true)
  _$$_AppUserCopyWith<_$_AppUser> get copyWith =>
      throw _privateConstructorUsedError;
}

UserMetadata _$UserMetadataFromJson(Map<String, dynamic> json) {
  return _UserMetadata.fromJson(json);
}

/// @nodoc
mixin _$UserMetadata {
  DateTime? get creationTime => throw _privateConstructorUsedError;
  DateTime? get lastSignInTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserMetadataCopyWith<UserMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserMetadataCopyWith<$Res> {
  factory $UserMetadataCopyWith(
          UserMetadata value, $Res Function(UserMetadata) then) =
      _$UserMetadataCopyWithImpl<$Res>;
  $Res call({DateTime? creationTime, DateTime? lastSignInTime});
}

/// @nodoc
class _$UserMetadataCopyWithImpl<$Res> implements $UserMetadataCopyWith<$Res> {
  _$UserMetadataCopyWithImpl(this._value, this._then);

  final UserMetadata _value;
  // ignore: unused_field
  final $Res Function(UserMetadata) _then;

  @override
  $Res call({
    Object? creationTime = freezed,
    Object? lastSignInTime = freezed,
  }) {
    return _then(_value.copyWith(
      creationTime: creationTime == freezed
          ? _value.creationTime
          : creationTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastSignInTime: lastSignInTime == freezed
          ? _value.lastSignInTime
          : lastSignInTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
abstract class _$$_UserMetadataCopyWith<$Res>
    implements $UserMetadataCopyWith<$Res> {
  factory _$$_UserMetadataCopyWith(
          _$_UserMetadata value, $Res Function(_$_UserMetadata) then) =
      __$$_UserMetadataCopyWithImpl<$Res>;
  @override
  $Res call({DateTime? creationTime, DateTime? lastSignInTime});
}

/// @nodoc
class __$$_UserMetadataCopyWithImpl<$Res>
    extends _$UserMetadataCopyWithImpl<$Res>
    implements _$$_UserMetadataCopyWith<$Res> {
  __$$_UserMetadataCopyWithImpl(
      _$_UserMetadata _value, $Res Function(_$_UserMetadata) _then)
      : super(_value, (v) => _then(v as _$_UserMetadata));

  @override
  _$_UserMetadata get _value => super._value as _$_UserMetadata;

  @override
  $Res call({
    Object? creationTime = freezed,
    Object? lastSignInTime = freezed,
  }) {
    return _then(_$_UserMetadata(
      creationTime: creationTime == freezed
          ? _value.creationTime
          : creationTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastSignInTime: lastSignInTime == freezed
          ? _value.lastSignInTime
          : lastSignInTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserMetadata implements _UserMetadata {
  const _$_UserMetadata({this.creationTime, this.lastSignInTime});

  factory _$_UserMetadata.fromJson(Map<String, dynamic> json) =>
      _$$_UserMetadataFromJson(json);

  @override
  final DateTime? creationTime;
  @override
  final DateTime? lastSignInTime;

  @override
  String toString() {
    return 'UserMetadata(creationTime: $creationTime, lastSignInTime: $lastSignInTime)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserMetadata &&
            const DeepCollectionEquality()
                .equals(other.creationTime, creationTime) &&
            const DeepCollectionEquality()
                .equals(other.lastSignInTime, lastSignInTime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(creationTime),
      const DeepCollectionEquality().hash(lastSignInTime));

  @JsonKey(ignore: true)
  @override
  _$$_UserMetadataCopyWith<_$_UserMetadata> get copyWith =>
      __$$_UserMetadataCopyWithImpl<_$_UserMetadata>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserMetadataToJson(
      this,
    );
  }
}

abstract class _UserMetadata implements UserMetadata {
  const factory _UserMetadata(
      {final DateTime? creationTime,
      final DateTime? lastSignInTime}) = _$_UserMetadata;

  factory _UserMetadata.fromJson(Map<String, dynamic> json) =
      _$_UserMetadata.fromJson;

  @override
  DateTime? get creationTime;
  @override
  DateTime? get lastSignInTime;
  @override
  @JsonKey(ignore: true)
  _$$_UserMetadataCopyWith<_$_UserMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) {
  return _UserInfo.fromJson(json);
}

/// @nodoc
mixin _$UserInfo {
  String? get displayName => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get phoneNumber => throw _privateConstructorUsedError;
  String? get photoURL => throw _privateConstructorUsedError;
  String? get providerId => throw _privateConstructorUsedError;
  String? get uid => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserInfoCopyWith<UserInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserInfoCopyWith<$Res> {
  factory $UserInfoCopyWith(UserInfo value, $Res Function(UserInfo) then) =
      _$UserInfoCopyWithImpl<$Res>;
  $Res call(
      {String? displayName,
      String? email,
      String? phoneNumber,
      String? photoURL,
      String? providerId,
      String? uid});
}

/// @nodoc
class _$UserInfoCopyWithImpl<$Res> implements $UserInfoCopyWith<$Res> {
  _$UserInfoCopyWithImpl(this._value, this._then);

  final UserInfo _value;
  // ignore: unused_field
  final $Res Function(UserInfo) _then;

  @override
  $Res call({
    Object? displayName = freezed,
    Object? email = freezed,
    Object? phoneNumber = freezed,
    Object? photoURL = freezed,
    Object? providerId = freezed,
    Object? uid = freezed,
  }) {
    return _then(_value.copyWith(
      displayName: displayName == freezed
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: phoneNumber == freezed
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      photoURL: photoURL == freezed
          ? _value.photoURL
          : photoURL // ignore: cast_nullable_to_non_nullable
              as String?,
      providerId: providerId == freezed
          ? _value.providerId
          : providerId // ignore: cast_nullable_to_non_nullable
              as String?,
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$$_UserInfoCopyWith<$Res> implements $UserInfoCopyWith<$Res> {
  factory _$$_UserInfoCopyWith(
          _$_UserInfo value, $Res Function(_$_UserInfo) then) =
      __$$_UserInfoCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? displayName,
      String? email,
      String? phoneNumber,
      String? photoURL,
      String? providerId,
      String? uid});
}

/// @nodoc
class __$$_UserInfoCopyWithImpl<$Res> extends _$UserInfoCopyWithImpl<$Res>
    implements _$$_UserInfoCopyWith<$Res> {
  __$$_UserInfoCopyWithImpl(
      _$_UserInfo _value, $Res Function(_$_UserInfo) _then)
      : super(_value, (v) => _then(v as _$_UserInfo));

  @override
  _$_UserInfo get _value => super._value as _$_UserInfo;

  @override
  $Res call({
    Object? displayName = freezed,
    Object? email = freezed,
    Object? phoneNumber = freezed,
    Object? photoURL = freezed,
    Object? providerId = freezed,
    Object? uid = freezed,
  }) {
    return _then(_$_UserInfo(
      displayName: displayName == freezed
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: phoneNumber == freezed
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      photoURL: photoURL == freezed
          ? _value.photoURL
          : photoURL // ignore: cast_nullable_to_non_nullable
              as String?,
      providerId: providerId == freezed
          ? _value.providerId
          : providerId // ignore: cast_nullable_to_non_nullable
              as String?,
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserInfo implements _UserInfo {
  const _$_UserInfo(
      {this.displayName,
      this.email,
      this.phoneNumber,
      this.photoURL,
      this.providerId,
      this.uid});

  factory _$_UserInfo.fromJson(Map<String, dynamic> json) =>
      _$$_UserInfoFromJson(json);

  @override
  final String? displayName;
  @override
  final String? email;
  @override
  final String? phoneNumber;
  @override
  final String? photoURL;
  @override
  final String? providerId;
  @override
  final String? uid;

  @override
  String toString() {
    return 'UserInfo(displayName: $displayName, email: $email, phoneNumber: $phoneNumber, photoURL: $photoURL, providerId: $providerId, uid: $uid)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserInfo &&
            const DeepCollectionEquality()
                .equals(other.displayName, displayName) &&
            const DeepCollectionEquality().equals(other.email, email) &&
            const DeepCollectionEquality()
                .equals(other.phoneNumber, phoneNumber) &&
            const DeepCollectionEquality().equals(other.photoURL, photoURL) &&
            const DeepCollectionEquality()
                .equals(other.providerId, providerId) &&
            const DeepCollectionEquality().equals(other.uid, uid));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(displayName),
      const DeepCollectionEquality().hash(email),
      const DeepCollectionEquality().hash(phoneNumber),
      const DeepCollectionEquality().hash(photoURL),
      const DeepCollectionEquality().hash(providerId),
      const DeepCollectionEquality().hash(uid));

  @JsonKey(ignore: true)
  @override
  _$$_UserInfoCopyWith<_$_UserInfo> get copyWith =>
      __$$_UserInfoCopyWithImpl<_$_UserInfo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserInfoToJson(
      this,
    );
  }
}

abstract class _UserInfo implements UserInfo {
  const factory _UserInfo(
      {final String? displayName,
      final String? email,
      final String? phoneNumber,
      final String? photoURL,
      final String? providerId,
      final String? uid}) = _$_UserInfo;

  factory _UserInfo.fromJson(Map<String, dynamic> json) = _$_UserInfo.fromJson;

  @override
  String? get displayName;
  @override
  String? get email;
  @override
  String? get phoneNumber;
  @override
  String? get photoURL;
  @override
  String? get providerId;
  @override
  String? get uid;
  @override
  @JsonKey(ignore: true)
  _$$_UserInfoCopyWith<_$_UserInfo> get copyWith =>
      throw _privateConstructorUsedError;
}
