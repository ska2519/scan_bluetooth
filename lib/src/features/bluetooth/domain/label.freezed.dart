// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'label.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Label _$LabelFromJson(Map<String, dynamic> json) {
  return _Label.fromJson(json);
}

/// @nodoc
mixin _$Label {
  String get name => throw _privateConstructorUsedError;
  String get uid => throw _privateConstructorUsedError;
  AppUser get user => throw _privateConstructorUsedError;
  String get bluetoothName => throw _privateConstructorUsedError;
  String get deviceId => throw _privateConstructorUsedError;
  int get rssi => throw _privateConstructorUsedError;
  String? get documentId => throw _privateConstructorUsedError;
  @ServerTimestampConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LabelCopyWith<Label> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LabelCopyWith<$Res> {
  factory $LabelCopyWith(Label value, $Res Function(Label) then) =
      _$LabelCopyWithImpl<$Res>;
  $Res call(
      {String name,
      String uid,
      AppUser user,
      String bluetoothName,
      String deviceId,
      int rssi,
      String? documentId,
      @ServerTimestampConverter() DateTime? createdAt,
      DateTime? updatedAt});

  $AppUserCopyWith<$Res> get user;
}

/// @nodoc
class _$LabelCopyWithImpl<$Res> implements $LabelCopyWith<$Res> {
  _$LabelCopyWithImpl(this._value, this._then);

  final Label _value;
  // ignore: unused_field
  final $Res Function(Label) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? uid = freezed,
    Object? user = freezed,
    Object? bluetoothName = freezed,
    Object? deviceId = freezed,
    Object? rssi = freezed,
    Object? documentId = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      user: user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as AppUser,
      bluetoothName: bluetoothName == freezed
          ? _value.bluetoothName
          : bluetoothName // ignore: cast_nullable_to_non_nullable
              as String,
      deviceId: deviceId == freezed
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String,
      rssi: rssi == freezed
          ? _value.rssi
          : rssi // ignore: cast_nullable_to_non_nullable
              as int,
      documentId: documentId == freezed
          ? _value.documentId
          : documentId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
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
abstract class _$$_LabelCopyWith<$Res> implements $LabelCopyWith<$Res> {
  factory _$$_LabelCopyWith(_$_Label value, $Res Function(_$_Label) then) =
      __$$_LabelCopyWithImpl<$Res>;
  @override
  $Res call(
      {String name,
      String uid,
      AppUser user,
      String bluetoothName,
      String deviceId,
      int rssi,
      String? documentId,
      @ServerTimestampConverter() DateTime? createdAt,
      DateTime? updatedAt});

  @override
  $AppUserCopyWith<$Res> get user;
}

/// @nodoc
class __$$_LabelCopyWithImpl<$Res> extends _$LabelCopyWithImpl<$Res>
    implements _$$_LabelCopyWith<$Res> {
  __$$_LabelCopyWithImpl(_$_Label _value, $Res Function(_$_Label) _then)
      : super(_value, (v) => _then(v as _$_Label));

  @override
  _$_Label get _value => super._value as _$_Label;

  @override
  $Res call({
    Object? name = freezed,
    Object? uid = freezed,
    Object? user = freezed,
    Object? bluetoothName = freezed,
    Object? deviceId = freezed,
    Object? rssi = freezed,
    Object? documentId = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$_Label(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      user: user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as AppUser,
      bluetoothName: bluetoothName == freezed
          ? _value.bluetoothName
          : bluetoothName // ignore: cast_nullable_to_non_nullable
              as String,
      deviceId: deviceId == freezed
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String,
      rssi: rssi == freezed
          ? _value.rssi
          : rssi // ignore: cast_nullable_to_non_nullable
              as int,
      documentId: documentId == freezed
          ? _value.documentId
          : documentId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Label implements _Label {
  const _$_Label(
      {required this.name,
      required this.uid,
      required this.user,
      required this.bluetoothName,
      required this.deviceId,
      required this.rssi,
      this.documentId,
      @ServerTimestampConverter() this.createdAt,
      this.updatedAt});

  factory _$_Label.fromJson(Map<String, dynamic> json) =>
      _$$_LabelFromJson(json);

  @override
  final String name;
  @override
  final String uid;
  @override
  final AppUser user;
  @override
  final String bluetoothName;
  @override
  final String deviceId;
  @override
  final int rssi;
  @override
  final String? documentId;
  @override
  @ServerTimestampConverter()
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Label(name: $name, uid: $uid, user: $user, bluetoothName: $bluetoothName, deviceId: $deviceId, rssi: $rssi, documentId: $documentId, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Label &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.uid, uid) &&
            const DeepCollectionEquality().equals(other.user, user) &&
            const DeepCollectionEquality()
                .equals(other.bluetoothName, bluetoothName) &&
            const DeepCollectionEquality().equals(other.deviceId, deviceId) &&
            const DeepCollectionEquality().equals(other.rssi, rssi) &&
            const DeepCollectionEquality()
                .equals(other.documentId, documentId) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality().equals(other.updatedAt, updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(uid),
      const DeepCollectionEquality().hash(user),
      const DeepCollectionEquality().hash(bluetoothName),
      const DeepCollectionEquality().hash(deviceId),
      const DeepCollectionEquality().hash(rssi),
      const DeepCollectionEquality().hash(documentId),
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(updatedAt));

  @JsonKey(ignore: true)
  @override
  _$$_LabelCopyWith<_$_Label> get copyWith =>
      __$$_LabelCopyWithImpl<_$_Label>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LabelToJson(
      this,
    );
  }
}

abstract class _Label implements Label {
  const factory _Label(
      {required final String name,
      required final String uid,
      required final AppUser user,
      required final String bluetoothName,
      required final String deviceId,
      required final int rssi,
      final String? documentId,
      @ServerTimestampConverter() final DateTime? createdAt,
      final DateTime? updatedAt}) = _$_Label;

  factory _Label.fromJson(Map<String, dynamic> json) = _$_Label.fromJson;

  @override
  String get name;
  @override
  String get uid;
  @override
  AppUser get user;
  @override
  String get bluetoothName;
  @override
  String get deviceId;
  @override
  int get rssi;
  @override
  String? get documentId;
  @override
  @ServerTimestampConverter()
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$_LabelCopyWith<_$_Label> get copyWith =>
      throw _privateConstructorUsedError;
}
