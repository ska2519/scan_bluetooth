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
  String? get phoneNumber => throw _privateConstructorUsedError;
  String? get photoURL =>
      throw _privateConstructorUsedError; // @Default([]) List<dynamic> providerData,
  List<UserInfo>? get providerData => throw _privateConstructorUsedError;
  String? get refreshToken => throw _privateConstructorUsedError;
  String? get tenantId => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  DateTime? get lastSignIn => throw _privateConstructorUsedError;

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
      String? phoneNumber,
      String? photoURL,
      List<UserInfo>? providerData,
      String? refreshToken,
      String? tenantId,
      DateTime? createdAt,
      DateTime? updatedAt,
      DateTime? lastSignIn});
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
    Object? phoneNumber = freezed,
    Object? photoURL = freezed,
    Object? providerData = freezed,
    Object? refreshToken = freezed,
    Object? tenantId = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? lastSignIn = freezed,
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
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastSignIn: lastSignIn == freezed
          ? _value.lastSignIn
          : lastSignIn // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
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
      String? phoneNumber,
      String? photoURL,
      List<UserInfo>? providerData,
      String? refreshToken,
      String? tenantId,
      DateTime? createdAt,
      DateTime? updatedAt,
      DateTime? lastSignIn});
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
    Object? phoneNumber = freezed,
    Object? photoURL = freezed,
    Object? providerData = freezed,
    Object? refreshToken = freezed,
    Object? tenantId = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? lastSignIn = freezed,
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
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastSignIn: lastSignIn == freezed
          ? _value.lastSignIn
          : lastSignIn // ignore: cast_nullable_to_non_nullable
              as DateTime?,
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
      this.phoneNumber,
      this.photoURL,
      final List<UserInfo>? providerData,
      this.refreshToken,
      this.tenantId,
      this.createdAt,
      this.updatedAt,
      this.lastSignIn})
      : _providerData = providerData;

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
  final String? phoneNumber;
  @override
  final String? photoURL;
// @Default([]) List<dynamic> providerData,
  final List<UserInfo>? _providerData;
// @Default([]) List<dynamic> providerData,
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
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final DateTime? lastSignIn;

  @override
  String toString() {
    return 'AppUser(uid: $uid, email: $email, displayName: $displayName, emailVerified: $emailVerified, isAnonymous: $isAnonymous, phoneNumber: $phoneNumber, photoURL: $photoURL, providerData: $providerData, refreshToken: $refreshToken, tenantId: $tenantId, createdAt: $createdAt, updatedAt: $updatedAt, lastSignIn: $lastSignIn)';
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
            const DeepCollectionEquality()
                .equals(other.phoneNumber, phoneNumber) &&
            const DeepCollectionEquality().equals(other.photoURL, photoURL) &&
            const DeepCollectionEquality()
                .equals(other._providerData, _providerData) &&
            const DeepCollectionEquality()
                .equals(other.refreshToken, refreshToken) &&
            const DeepCollectionEquality().equals(other.tenantId, tenantId) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality().equals(other.updatedAt, updatedAt) &&
            const DeepCollectionEquality()
                .equals(other.lastSignIn, lastSignIn));
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
      const DeepCollectionEquality().hash(phoneNumber),
      const DeepCollectionEquality().hash(photoURL),
      const DeepCollectionEquality().hash(_providerData),
      const DeepCollectionEquality().hash(refreshToken),
      const DeepCollectionEquality().hash(tenantId),
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(updatedAt),
      const DeepCollectionEquality().hash(lastSignIn));

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
      final String? phoneNumber,
      final String? photoURL,
      final List<UserInfo>? providerData,
      final String? refreshToken,
      final String? tenantId,
      final DateTime? createdAt,
      final DateTime? updatedAt,
      final DateTime? lastSignIn}) = _$_AppUser;

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
  String? get phoneNumber;
  @override
  String? get photoURL;
  @override // @Default([]) List<dynamic> providerData,
  List<UserInfo>? get providerData;
  @override
  String? get refreshToken;
  @override
  String? get tenantId;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  DateTime? get lastSignIn;
  @override
  @JsonKey(ignore: true)
  _$$_AppUserCopyWith<_$_AppUser> get copyWith =>
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
