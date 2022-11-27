// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'bluetooth.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Bluetooth _$BluetoothFromJson(Map<String, dynamic> json) {
  return _Bluetooth.fromJson(json);
}

/// @nodoc
mixin _$Bluetooth {
  String get name => throw _privateConstructorUsedError;
  String get deviceId => throw _privateConstructorUsedError;
  List<dynamic> get manufacturerDataHead => throw _privateConstructorUsedError;
  List<dynamic> get manufacturerData => throw _privateConstructorUsedError;
  int get rssi => throw _privateConstructorUsedError;
  int? get previousRssi => throw _privateConstructorUsedError;
  @TimestampNullableConverter()
  DateTime? get scannedAt => throw _privateConstructorUsedError;
  @TimestampNullableConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @TimestampNullableConverter()
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  int get labelCount => throw _privateConstructorUsedError;
  Label? get firstUpdatedLabel => throw _privateConstructorUsedError;
  Label? get userLabel => throw _privateConstructorUsedError;
  bool get canConnect => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BluetoothCopyWith<Bluetooth> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BluetoothCopyWith<$Res> {
  factory $BluetoothCopyWith(Bluetooth value, $Res Function(Bluetooth) then) =
      _$BluetoothCopyWithImpl<$Res, Bluetooth>;
  @useResult
  $Res call(
      {String name,
      String deviceId,
      List<dynamic> manufacturerDataHead,
      List<dynamic> manufacturerData,
      int rssi,
      int? previousRssi,
      @TimestampNullableConverter() DateTime? scannedAt,
      @TimestampNullableConverter() DateTime? createdAt,
      @TimestampNullableConverter() DateTime? updatedAt,
      int labelCount,
      Label? firstUpdatedLabel,
      Label? userLabel,
      bool canConnect});

  $LabelCopyWith<$Res>? get firstUpdatedLabel;
  $LabelCopyWith<$Res>? get userLabel;
}

/// @nodoc
class _$BluetoothCopyWithImpl<$Res, $Val extends Bluetooth>
    implements $BluetoothCopyWith<$Res> {
  _$BluetoothCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? deviceId = null,
    Object? manufacturerDataHead = null,
    Object? manufacturerData = null,
    Object? rssi = null,
    Object? previousRssi = freezed,
    Object? scannedAt = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? labelCount = null,
    Object? firstUpdatedLabel = freezed,
    Object? userLabel = freezed,
    Object? canConnect = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      deviceId: null == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String,
      manufacturerDataHead: null == manufacturerDataHead
          ? _value.manufacturerDataHead
          : manufacturerDataHead // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      manufacturerData: null == manufacturerData
          ? _value.manufacturerData
          : manufacturerData // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      rssi: null == rssi
          ? _value.rssi
          : rssi // ignore: cast_nullable_to_non_nullable
              as int,
      previousRssi: freezed == previousRssi
          ? _value.previousRssi
          : previousRssi // ignore: cast_nullable_to_non_nullable
              as int?,
      scannedAt: freezed == scannedAt
          ? _value.scannedAt
          : scannedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      labelCount: null == labelCount
          ? _value.labelCount
          : labelCount // ignore: cast_nullable_to_non_nullable
              as int,
      firstUpdatedLabel: freezed == firstUpdatedLabel
          ? _value.firstUpdatedLabel
          : firstUpdatedLabel // ignore: cast_nullable_to_non_nullable
              as Label?,
      userLabel: freezed == userLabel
          ? _value.userLabel
          : userLabel // ignore: cast_nullable_to_non_nullable
              as Label?,
      canConnect: null == canConnect
          ? _value.canConnect
          : canConnect // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $LabelCopyWith<$Res>? get firstUpdatedLabel {
    if (_value.firstUpdatedLabel == null) {
      return null;
    }

    return $LabelCopyWith<$Res>(_value.firstUpdatedLabel!, (value) {
      return _then(_value.copyWith(firstUpdatedLabel: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $LabelCopyWith<$Res>? get userLabel {
    if (_value.userLabel == null) {
      return null;
    }

    return $LabelCopyWith<$Res>(_value.userLabel!, (value) {
      return _then(_value.copyWith(userLabel: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_BluetoothCopyWith<$Res> implements $BluetoothCopyWith<$Res> {
  factory _$$_BluetoothCopyWith(
          _$_Bluetooth value, $Res Function(_$_Bluetooth) then) =
      __$$_BluetoothCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String deviceId,
      List<dynamic> manufacturerDataHead,
      List<dynamic> manufacturerData,
      int rssi,
      int? previousRssi,
      @TimestampNullableConverter() DateTime? scannedAt,
      @TimestampNullableConverter() DateTime? createdAt,
      @TimestampNullableConverter() DateTime? updatedAt,
      int labelCount,
      Label? firstUpdatedLabel,
      Label? userLabel,
      bool canConnect});

  @override
  $LabelCopyWith<$Res>? get firstUpdatedLabel;
  @override
  $LabelCopyWith<$Res>? get userLabel;
}

/// @nodoc
class __$$_BluetoothCopyWithImpl<$Res>
    extends _$BluetoothCopyWithImpl<$Res, _$_Bluetooth>
    implements _$$_BluetoothCopyWith<$Res> {
  __$$_BluetoothCopyWithImpl(
      _$_Bluetooth _value, $Res Function(_$_Bluetooth) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? deviceId = null,
    Object? manufacturerDataHead = null,
    Object? manufacturerData = null,
    Object? rssi = null,
    Object? previousRssi = freezed,
    Object? scannedAt = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? labelCount = null,
    Object? firstUpdatedLabel = freezed,
    Object? userLabel = freezed,
    Object? canConnect = null,
  }) {
    return _then(_$_Bluetooth(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      deviceId: null == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String,
      manufacturerDataHead: null == manufacturerDataHead
          ? _value._manufacturerDataHead
          : manufacturerDataHead // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      manufacturerData: null == manufacturerData
          ? _value._manufacturerData
          : manufacturerData // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      rssi: null == rssi
          ? _value.rssi
          : rssi // ignore: cast_nullable_to_non_nullable
              as int,
      previousRssi: freezed == previousRssi
          ? _value.previousRssi
          : previousRssi // ignore: cast_nullable_to_non_nullable
              as int?,
      scannedAt: freezed == scannedAt
          ? _value.scannedAt
          : scannedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      labelCount: null == labelCount
          ? _value.labelCount
          : labelCount // ignore: cast_nullable_to_non_nullable
              as int,
      firstUpdatedLabel: freezed == firstUpdatedLabel
          ? _value.firstUpdatedLabel
          : firstUpdatedLabel // ignore: cast_nullable_to_non_nullable
              as Label?,
      userLabel: freezed == userLabel
          ? _value.userLabel
          : userLabel // ignore: cast_nullable_to_non_nullable
              as Label?,
      canConnect: null == canConnect
          ? _value.canConnect
          : canConnect // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Bluetooth implements _Bluetooth {
  const _$_Bluetooth(
      {required this.name,
      required this.deviceId,
      required final List<dynamic> manufacturerDataHead,
      required final List<dynamic> manufacturerData,
      required this.rssi,
      this.previousRssi,
      @TimestampNullableConverter() this.scannedAt,
      @TimestampNullableConverter() this.createdAt,
      @TimestampNullableConverter() this.updatedAt,
      this.labelCount = 0,
      this.firstUpdatedLabel,
      this.userLabel,
      this.canConnect = false})
      : _manufacturerDataHead = manufacturerDataHead,
        _manufacturerData = manufacturerData;

  factory _$_Bluetooth.fromJson(Map<String, dynamic> json) =>
      _$$_BluetoothFromJson(json);

  @override
  final String name;
  @override
  final String deviceId;
  final List<dynamic> _manufacturerDataHead;
  @override
  List<dynamic> get manufacturerDataHead {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_manufacturerDataHead);
  }

  final List<dynamic> _manufacturerData;
  @override
  List<dynamic> get manufacturerData {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_manufacturerData);
  }

  @override
  final int rssi;
  @override
  final int? previousRssi;
  @override
  @TimestampNullableConverter()
  final DateTime? scannedAt;
  @override
  @TimestampNullableConverter()
  final DateTime? createdAt;
  @override
  @TimestampNullableConverter()
  final DateTime? updatedAt;
  @override
  @JsonKey()
  final int labelCount;
  @override
  final Label? firstUpdatedLabel;
  @override
  final Label? userLabel;
  @override
  @JsonKey()
  final bool canConnect;

  @override
  String toString() {
    return 'Bluetooth(name: $name, deviceId: $deviceId, manufacturerDataHead: $manufacturerDataHead, manufacturerData: $manufacturerData, rssi: $rssi, previousRssi: $previousRssi, scannedAt: $scannedAt, createdAt: $createdAt, updatedAt: $updatedAt, labelCount: $labelCount, firstUpdatedLabel: $firstUpdatedLabel, userLabel: $userLabel, canConnect: $canConnect)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Bluetooth &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.deviceId, deviceId) ||
                other.deviceId == deviceId) &&
            const DeepCollectionEquality()
                .equals(other._manufacturerDataHead, _manufacturerDataHead) &&
            const DeepCollectionEquality()
                .equals(other._manufacturerData, _manufacturerData) &&
            (identical(other.rssi, rssi) || other.rssi == rssi) &&
            (identical(other.previousRssi, previousRssi) ||
                other.previousRssi == previousRssi) &&
            (identical(other.scannedAt, scannedAt) ||
                other.scannedAt == scannedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.labelCount, labelCount) ||
                other.labelCount == labelCount) &&
            (identical(other.firstUpdatedLabel, firstUpdatedLabel) ||
                other.firstUpdatedLabel == firstUpdatedLabel) &&
            (identical(other.userLabel, userLabel) ||
                other.userLabel == userLabel) &&
            (identical(other.canConnect, canConnect) ||
                other.canConnect == canConnect));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      deviceId,
      const DeepCollectionEquality().hash(_manufacturerDataHead),
      const DeepCollectionEquality().hash(_manufacturerData),
      rssi,
      previousRssi,
      scannedAt,
      createdAt,
      updatedAt,
      labelCount,
      firstUpdatedLabel,
      userLabel,
      canConnect);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BluetoothCopyWith<_$_Bluetooth> get copyWith =>
      __$$_BluetoothCopyWithImpl<_$_Bluetooth>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BluetoothToJson(
      this,
    );
  }
}

abstract class _Bluetooth implements Bluetooth {
  const factory _Bluetooth(
      {required final String name,
      required final String deviceId,
      required final List<dynamic> manufacturerDataHead,
      required final List<dynamic> manufacturerData,
      required final int rssi,
      final int? previousRssi,
      @TimestampNullableConverter() final DateTime? scannedAt,
      @TimestampNullableConverter() final DateTime? createdAt,
      @TimestampNullableConverter() final DateTime? updatedAt,
      final int labelCount,
      final Label? firstUpdatedLabel,
      final Label? userLabel,
      final bool canConnect}) = _$_Bluetooth;

  factory _Bluetooth.fromJson(Map<String, dynamic> json) =
      _$_Bluetooth.fromJson;

  @override
  String get name;
  @override
  String get deviceId;
  @override
  List<dynamic> get manufacturerDataHead;
  @override
  List<dynamic> get manufacturerData;
  @override
  int get rssi;
  @override
  int? get previousRssi;
  @override
  @TimestampNullableConverter()
  DateTime? get scannedAt;
  @override
  @TimestampNullableConverter()
  DateTime? get createdAt;
  @override
  @TimestampNullableConverter()
  DateTime? get updatedAt;
  @override
  int get labelCount;
  @override
  Label? get firstUpdatedLabel;
  @override
  Label? get userLabel;
  @override
  bool get canConnect;
  @override
  @JsonKey(ignore: true)
  _$$_BluetoothCopyWith<_$_Bluetooth> get copyWith =>
      throw _privateConstructorUsedError;
}
