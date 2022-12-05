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
  String? get deviceId => throw _privateConstructorUsedError;
  BluetoothDeviceType? get type => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int? get rssi => throw _privateConstructorUsedError;
  String get uid => throw _privateConstructorUsedError;
  String? get documentId => throw _privateConstructorUsedError;
  @TimestampNullableConverter()
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @deprecated
  @TimestampNullableConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @deprecated
  Bluetooth? get bluetooth => throw _privateConstructorUsedError;
  @deprecated
  AppUser? get user => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LabelCopyWith<Label> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LabelCopyWith<$Res> {
  factory $LabelCopyWith(Label value, $Res Function(Label) then) =
      _$LabelCopyWithImpl<$Res, Label>;
  @useResult
  $Res call(
      {String? deviceId,
      BluetoothDeviceType? type,
      String name,
      int? rssi,
      String uid,
      String? documentId,
      @TimestampNullableConverter() DateTime? updatedAt,
      @deprecated @TimestampNullableConverter() DateTime? createdAt,
      @deprecated Bluetooth? bluetooth,
      @deprecated AppUser? user});

  $BluetoothCopyWith<$Res>? get bluetooth;
  $AppUserCopyWith<$Res>? get user;
}

/// @nodoc
class _$LabelCopyWithImpl<$Res, $Val extends Label>
    implements $LabelCopyWith<$Res> {
  _$LabelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? deviceId = freezed,
    Object? type = freezed,
    Object? name = null,
    Object? rssi = freezed,
    Object? uid = null,
    Object? documentId = freezed,
    Object? updatedAt = freezed,
    Object? createdAt = freezed,
    Object? bluetooth = freezed,
    Object? user = freezed,
  }) {
    return _then(_value.copyWith(
      deviceId: freezed == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as BluetoothDeviceType?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      rssi: freezed == rssi
          ? _value.rssi
          : rssi // ignore: cast_nullable_to_non_nullable
              as int?,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      documentId: freezed == documentId
          ? _value.documentId
          : documentId // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      bluetooth: freezed == bluetooth
          ? _value.bluetooth
          : bluetooth // ignore: cast_nullable_to_non_nullable
              as Bluetooth?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as AppUser?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $BluetoothCopyWith<$Res>? get bluetooth {
    if (_value.bluetooth == null) {
      return null;
    }

    return $BluetoothCopyWith<$Res>(_value.bluetooth!, (value) {
      return _then(_value.copyWith(bluetooth: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $AppUserCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $AppUserCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_LabelCopyWith<$Res> implements $LabelCopyWith<$Res> {
  factory _$$_LabelCopyWith(_$_Label value, $Res Function(_$_Label) then) =
      __$$_LabelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? deviceId,
      BluetoothDeviceType? type,
      String name,
      int? rssi,
      String uid,
      String? documentId,
      @TimestampNullableConverter() DateTime? updatedAt,
      @deprecated @TimestampNullableConverter() DateTime? createdAt,
      @deprecated Bluetooth? bluetooth,
      @deprecated AppUser? user});

  @override
  $BluetoothCopyWith<$Res>? get bluetooth;
  @override
  $AppUserCopyWith<$Res>? get user;
}

/// @nodoc
class __$$_LabelCopyWithImpl<$Res> extends _$LabelCopyWithImpl<$Res, _$_Label>
    implements _$$_LabelCopyWith<$Res> {
  __$$_LabelCopyWithImpl(_$_Label _value, $Res Function(_$_Label) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? deviceId = freezed,
    Object? type = freezed,
    Object? name = null,
    Object? rssi = freezed,
    Object? uid = null,
    Object? documentId = freezed,
    Object? updatedAt = freezed,
    Object? createdAt = freezed,
    Object? bluetooth = freezed,
    Object? user = freezed,
  }) {
    return _then(_$_Label(
      deviceId: freezed == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as BluetoothDeviceType?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      rssi: freezed == rssi
          ? _value.rssi
          : rssi // ignore: cast_nullable_to_non_nullable
              as int?,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      documentId: freezed == documentId
          ? _value.documentId
          : documentId // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      bluetooth: freezed == bluetooth
          ? _value.bluetooth
          : bluetooth // ignore: cast_nullable_to_non_nullable
              as Bluetooth?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as AppUser?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Label implements _Label {
  const _$_Label(
      {this.deviceId,
      this.type,
      required this.name,
      this.rssi,
      required this.uid,
      this.documentId,
      @TimestampNullableConverter() this.updatedAt,
      @deprecated @TimestampNullableConverter() this.createdAt,
      @deprecated this.bluetooth,
      @deprecated this.user});

  factory _$_Label.fromJson(Map<String, dynamic> json) =>
      _$$_LabelFromJson(json);

  @override
  final String? deviceId;
  @override
  final BluetoothDeviceType? type;
  @override
  final String name;
  @override
  final int? rssi;
  @override
  final String uid;
  @override
  final String? documentId;
  @override
  @TimestampNullableConverter()
  final DateTime? updatedAt;
  @override
  @deprecated
  @TimestampNullableConverter()
  final DateTime? createdAt;
  @override
  @deprecated
  final Bluetooth? bluetooth;
  @override
  @deprecated
  final AppUser? user;

  @override
  String toString() {
    return 'Label(deviceId: $deviceId, type: $type, name: $name, rssi: $rssi, uid: $uid, documentId: $documentId, updatedAt: $updatedAt, createdAt: $createdAt, bluetooth: $bluetooth, user: $user)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Label &&
            (identical(other.deviceId, deviceId) ||
                other.deviceId == deviceId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.rssi, rssi) || other.rssi == rssi) &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.documentId, documentId) ||
                other.documentId == documentId) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.bluetooth, bluetooth) ||
                other.bluetooth == bluetooth) &&
            (identical(other.user, user) || other.user == user));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, deviceId, type, name, rssi, uid,
      documentId, updatedAt, createdAt, bluetooth, user);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
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
      {final String? deviceId,
      final BluetoothDeviceType? type,
      required final String name,
      final int? rssi,
      required final String uid,
      final String? documentId,
      @TimestampNullableConverter() final DateTime? updatedAt,
      @deprecated @TimestampNullableConverter() final DateTime? createdAt,
      @deprecated final Bluetooth? bluetooth,
      @deprecated final AppUser? user}) = _$_Label;

  factory _Label.fromJson(Map<String, dynamic> json) = _$_Label.fromJson;

  @override
  String? get deviceId;
  @override
  BluetoothDeviceType? get type;
  @override
  String get name;
  @override
  int? get rssi;
  @override
  String get uid;
  @override
  String? get documentId;
  @override
  @TimestampNullableConverter()
  DateTime? get updatedAt;
  @override
  @deprecated
  @TimestampNullableConverter()
  DateTime? get createdAt;
  @override
  @deprecated
  Bluetooth? get bluetooth;
  @override
  @deprecated
  AppUser? get user;
  @override
  @JsonKey(ignore: true)
  _$$_LabelCopyWith<_$_Label> get copyWith =>
      throw _privateConstructorUsedError;
}
