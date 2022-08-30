// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'nickname.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Nickname _$NicknameFromJson(Map<String, dynamic> json) {
  return _Nickname.fromJson(json);
}

/// @nodoc
mixin _$Nickname {
  String get nickname => throw _privateConstructorUsedError;
  AppUser get user => throw _privateConstructorUsedError;
  @FirestoreDateTimeConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NicknameCopyWith<Nickname> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NicknameCopyWith<$Res> {
  factory $NicknameCopyWith(Nickname value, $Res Function(Nickname) then) =
      _$NicknameCopyWithImpl<$Res>;
  $Res call(
      {String nickname,
      AppUser user,
      @FirestoreDateTimeConverter() DateTime createdAt});

  $AppUserCopyWith<$Res> get user;
}

/// @nodoc
class _$NicknameCopyWithImpl<$Res> implements $NicknameCopyWith<$Res> {
  _$NicknameCopyWithImpl(this._value, this._then);

  final Nickname _value;
  // ignore: unused_field
  final $Res Function(Nickname) _then;

  @override
  $Res call({
    Object? nickname = freezed,
    Object? user = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      nickname: nickname == freezed
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      user: user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as AppUser,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }

  @override
  $AppUserCopyWith<$Res> get user {
    return $AppUserCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value));
    });
  }
}

/// @nodoc
abstract class _$$_NicknameCopyWith<$Res> implements $NicknameCopyWith<$Res> {
  factory _$$_NicknameCopyWith(
          _$_Nickname value, $Res Function(_$_Nickname) then) =
      __$$_NicknameCopyWithImpl<$Res>;
  @override
  $Res call(
      {String nickname,
      AppUser user,
      @FirestoreDateTimeConverter() DateTime createdAt});

  @override
  $AppUserCopyWith<$Res> get user;
}

/// @nodoc
class __$$_NicknameCopyWithImpl<$Res> extends _$NicknameCopyWithImpl<$Res>
    implements _$$_NicknameCopyWith<$Res> {
  __$$_NicknameCopyWithImpl(
      _$_Nickname _value, $Res Function(_$_Nickname) _then)
      : super(_value, (v) => _then(v as _$_Nickname));

  @override
  _$_Nickname get _value => super._value as _$_Nickname;

  @override
  $Res call({
    Object? nickname = freezed,
    Object? user = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$_Nickname(
      nickname: nickname == freezed
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      user: user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as AppUser,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Nickname implements _Nickname {
  const _$_Nickname(
      {required this.nickname,
      required this.user,
      @FirestoreDateTimeConverter() required this.createdAt});

  factory _$_Nickname.fromJson(Map<String, dynamic> json) =>
      _$$_NicknameFromJson(json);

  @override
  final String nickname;
  @override
  final AppUser user;
  @override
  @FirestoreDateTimeConverter()
  final DateTime createdAt;

  @override
  String toString() {
    return 'Nickname(nickname: $nickname, user: $user, createdAt: $createdAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Nickname &&
            const DeepCollectionEquality().equals(other.nickname, nickname) &&
            const DeepCollectionEquality().equals(other.user, user) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(nickname),
      const DeepCollectionEquality().hash(user),
      const DeepCollectionEquality().hash(createdAt));

  @JsonKey(ignore: true)
  @override
  _$$_NicknameCopyWith<_$_Nickname> get copyWith =>
      __$$_NicknameCopyWithImpl<_$_Nickname>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_NicknameToJson(
      this,
    );
  }
}

abstract class _Nickname implements Nickname {
  const factory _Nickname(
          {required final String nickname,
          required final AppUser user,
          @FirestoreDateTimeConverter() required final DateTime createdAt}) =
      _$_Nickname;

  factory _Nickname.fromJson(Map<String, dynamic> json) = _$_Nickname.fromJson;

  @override
  String get nickname;
  @override
  AppUser get user;
  @override
  @FirestoreDateTimeConverter()
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$_NicknameCopyWith<_$_Nickname> get copyWith =>
      throw _privateConstructorUsedError;
}
