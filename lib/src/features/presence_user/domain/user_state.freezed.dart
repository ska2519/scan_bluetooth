// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'user_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserState _$UserStateFromJson(Map<String, dynamic> json) {
  return _UserState.fromJson(json);
}

/// @nodoc
mixin _$UserState {
  String get state => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_changed')
  @TimestampNullableConverter()
  DateTime? get lastCanged => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_anonymous')
  bool get isAnonymous => throw _privateConstructorUsedError;
  String? get uid => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserStateCopyWith<UserState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserStateCopyWith<$Res> {
  factory $UserStateCopyWith(UserState value, $Res Function(UserState) then) =
      _$UserStateCopyWithImpl<$Res, UserState>;
  @useResult
  $Res call(
      {String state,
      @JsonKey(name: 'last_changed')
      @TimestampNullableConverter()
          DateTime? lastCanged,
      @JsonKey(name: 'is_anonymous')
          bool isAnonymous,
      String? uid});
}

/// @nodoc
class _$UserStateCopyWithImpl<$Res, $Val extends UserState>
    implements $UserStateCopyWith<$Res> {
  _$UserStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? state = null,
    Object? lastCanged = freezed,
    Object? isAnonymous = null,
    Object? uid = freezed,
  }) {
    return _then(_value.copyWith(
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String,
      lastCanged: freezed == lastCanged
          ? _value.lastCanged
          : lastCanged // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isAnonymous: null == isAnonymous
          ? _value.isAnonymous
          : isAnonymous // ignore: cast_nullable_to_non_nullable
              as bool,
      uid: freezed == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UserStateCopyWith<$Res> implements $UserStateCopyWith<$Res> {
  factory _$$_UserStateCopyWith(
          _$_UserState value, $Res Function(_$_UserState) then) =
      __$$_UserStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String state,
      @JsonKey(name: 'last_changed')
      @TimestampNullableConverter()
          DateTime? lastCanged,
      @JsonKey(name: 'is_anonymous')
          bool isAnonymous,
      String? uid});
}

/// @nodoc
class __$$_UserStateCopyWithImpl<$Res>
    extends _$UserStateCopyWithImpl<$Res, _$_UserState>
    implements _$$_UserStateCopyWith<$Res> {
  __$$_UserStateCopyWithImpl(
      _$_UserState _value, $Res Function(_$_UserState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? state = null,
    Object? lastCanged = freezed,
    Object? isAnonymous = null,
    Object? uid = freezed,
  }) {
    return _then(_$_UserState(
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String,
      lastCanged: freezed == lastCanged
          ? _value.lastCanged
          : lastCanged // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isAnonymous: null == isAnonymous
          ? _value.isAnonymous
          : isAnonymous // ignore: cast_nullable_to_non_nullable
              as bool,
      uid: freezed == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserState implements _UserState {
  const _$_UserState(
      {required this.state,
      @JsonKey(name: 'last_changed')
      @TimestampNullableConverter()
          this.lastCanged,
      @JsonKey(name: 'is_anonymous')
          required this.isAnonymous,
      this.uid});

  factory _$_UserState.fromJson(Map<String, dynamic> json) =>
      _$$_UserStateFromJson(json);

  @override
  final String state;
  @override
  @JsonKey(name: 'last_changed')
  @TimestampNullableConverter()
  final DateTime? lastCanged;
  @override
  @JsonKey(name: 'is_anonymous')
  final bool isAnonymous;
  @override
  final String? uid;

  @override
  String toString() {
    return 'UserState(state: $state, lastCanged: $lastCanged, isAnonymous: $isAnonymous, uid: $uid)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserState &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.lastCanged, lastCanged) ||
                other.lastCanged == lastCanged) &&
            (identical(other.isAnonymous, isAnonymous) ||
                other.isAnonymous == isAnonymous) &&
            (identical(other.uid, uid) || other.uid == uid));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, state, lastCanged, isAnonymous, uid);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserStateCopyWith<_$_UserState> get copyWith =>
      __$$_UserStateCopyWithImpl<_$_UserState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserStateToJson(
      this,
    );
  }
}

abstract class _UserState implements UserState {
  const factory _UserState(
      {required final String state,
      @JsonKey(name: 'last_changed')
      @TimestampNullableConverter()
          final DateTime? lastCanged,
      @JsonKey(name: 'is_anonymous')
          required final bool isAnonymous,
      final String? uid}) = _$_UserState;

  factory _UserState.fromJson(Map<String, dynamic> json) =
      _$_UserState.fromJson;

  @override
  String get state;
  @override
  @JsonKey(name: 'last_changed')
  @TimestampNullableConverter()
  DateTime? get lastCanged;
  @override
  @JsonKey(name: 'is_anonymous')
  bool get isAnonymous;
  @override
  String? get uid;
  @override
  @JsonKey(ignore: true)
  _$$_UserStateCopyWith<_$_UserState> get copyWith =>
      throw _privateConstructorUsedError;
}
