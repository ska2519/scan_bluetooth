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
  @TimestampConverter()
  DateTime? get scannedAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  int? get labelCount => throw _privateConstructorUsedError;
  Label? get lastUpdatedLabel => throw _privateConstructorUsedError;
  Label? get userLabel => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BluetoothCopyWith<Bluetooth> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BluetoothCopyWith<$Res> {
  factory $BluetoothCopyWith(Bluetooth value, $Res Function(Bluetooth) then) =
      _$BluetoothCopyWithImpl<$Res>;
  $Res call(
      {String name,
      String deviceId,
      List<dynamic> manufacturerDataHead,
      List<dynamic> manufacturerData,
      int rssi,
      int? previousRssi,
      @TimestampConverter() DateTime? scannedAt,
      @TimestampConverter() DateTime? createdAt,
      @TimestampConverter() DateTime? updatedAt,
      int? labelCount,
      Label? lastUpdatedLabel,
      Label? userLabel});

  $LabelCopyWith<$Res>? get lastUpdatedLabel;
  $LabelCopyWith<$Res>? get userLabel;
}

/// @nodoc
class _$BluetoothCopyWithImpl<$Res> implements $BluetoothCopyWith<$Res> {
  _$BluetoothCopyWithImpl(this._value, this._then);

  final Bluetooth _value;
  // ignore: unused_field
  final $Res Function(Bluetooth) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? deviceId = freezed,
    Object? manufacturerDataHead = freezed,
    Object? manufacturerData = freezed,
    Object? rssi = freezed,
    Object? previousRssi = freezed,
    Object? scannedAt = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? labelCount = freezed,
    Object? lastUpdatedLabel = freezed,
    Object? userLabel = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      deviceId: deviceId == freezed
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String,
      manufacturerDataHead: manufacturerDataHead == freezed
          ? _value.manufacturerDataHead
          : manufacturerDataHead // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      manufacturerData: manufacturerData == freezed
          ? _value.manufacturerData
          : manufacturerData // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      rssi: rssi == freezed
          ? _value.rssi
          : rssi // ignore: cast_nullable_to_non_nullable
              as int,
      previousRssi: previousRssi == freezed
          ? _value.previousRssi
          : previousRssi // ignore: cast_nullable_to_non_nullable
              as int?,
      scannedAt: scannedAt == freezed
          ? _value.scannedAt
          : scannedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      labelCount: labelCount == freezed
          ? _value.labelCount
          : labelCount // ignore: cast_nullable_to_non_nullable
              as int?,
      lastUpdatedLabel: lastUpdatedLabel == freezed
          ? _value.lastUpdatedLabel
          : lastUpdatedLabel // ignore: cast_nullable_to_non_nullable
              as Label?,
      userLabel: userLabel == freezed
          ? _value.userLabel
          : userLabel // ignore: cast_nullable_to_non_nullable
              as Label?,
    ));
  }

  @override
  $LabelCopyWith<$Res>? get lastUpdatedLabel {
    if (_value.lastUpdatedLabel == null) {
      return null;
    }

    return $LabelCopyWith<$Res>(_value.lastUpdatedLabel!, (value) {
      return _then(_value.copyWith(lastUpdatedLabel: value));
    });
  }

  @override
  $LabelCopyWith<$Res>? get userLabel {
    if (_value.userLabel == null) {
      return null;
    }

    return $LabelCopyWith<$Res>(_value.userLabel!, (value) {
      return _then(_value.copyWith(userLabel: value));
    });
  }
}

/// @nodoc
abstract class _$$_BluetoothCopyWith<$Res> implements $BluetoothCopyWith<$Res> {
  factory _$$_BluetoothCopyWith(
          _$_Bluetooth value, $Res Function(_$_Bluetooth) then) =
      __$$_BluetoothCopyWithImpl<$Res>;
  @override
  $Res call(
      {String name,
      String deviceId,
      List<dynamic> manufacturerDataHead,
      List<dynamic> manufacturerData,
      int rssi,
      int? previousRssi,
      @TimestampConverter() DateTime? scannedAt,
      @TimestampConverter() DateTime? createdAt,
      @TimestampConverter() DateTime? updatedAt,
      int? labelCount,
      Label? lastUpdatedLabel,
      Label? userLabel});

  @override
  $LabelCopyWith<$Res>? get lastUpdatedLabel;
  @override
  $LabelCopyWith<$Res>? get userLabel;
}

/// @nodoc
class __$$_BluetoothCopyWithImpl<$Res> extends _$BluetoothCopyWithImpl<$Res>
    implements _$$_BluetoothCopyWith<$Res> {
  __$$_BluetoothCopyWithImpl(
      _$_Bluetooth _value, $Res Function(_$_Bluetooth) _then)
      : super(_value, (v) => _then(v as _$_Bluetooth));

  @override
  _$_Bluetooth get _value => super._value as _$_Bluetooth;

  @override
  $Res call({
    Object? name = freezed,
    Object? deviceId = freezed,
    Object? manufacturerDataHead = freezed,
    Object? manufacturerData = freezed,
    Object? rssi = freezed,
    Object? previousRssi = freezed,
    Object? scannedAt = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? labelCount = freezed,
    Object? lastUpdatedLabel = freezed,
    Object? userLabel = freezed,
  }) {
    return _then(_$_Bluetooth(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      deviceId: deviceId == freezed
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String,
      manufacturerDataHead: manufacturerDataHead == freezed
          ? _value._manufacturerDataHead
          : manufacturerDataHead // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      manufacturerData: manufacturerData == freezed
          ? _value._manufacturerData
          : manufacturerData // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      rssi: rssi == freezed
          ? _value.rssi
          : rssi // ignore: cast_nullable_to_non_nullable
              as int,
      previousRssi: previousRssi == freezed
          ? _value.previousRssi
          : previousRssi // ignore: cast_nullable_to_non_nullable
              as int?,
      scannedAt: scannedAt == freezed
          ? _value.scannedAt
          : scannedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      labelCount: labelCount == freezed
          ? _value.labelCount
          : labelCount // ignore: cast_nullable_to_non_nullable
              as int?,
      lastUpdatedLabel: lastUpdatedLabel == freezed
          ? _value.lastUpdatedLabel
          : lastUpdatedLabel // ignore: cast_nullable_to_non_nullable
              as Label?,
      userLabel: userLabel == freezed
          ? _value.userLabel
          : userLabel // ignore: cast_nullable_to_non_nullable
              as Label?,
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
      @TimestampConverter() this.scannedAt,
      @TimestampConverter() this.createdAt,
      @TimestampConverter() this.updatedAt,
      this.labelCount,
      this.lastUpdatedLabel,
      this.userLabel})
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
  @TimestampConverter()
  final DateTime? scannedAt;
  @override
  @TimestampConverter()
  final DateTime? createdAt;
  @override
  @TimestampConverter()
  final DateTime? updatedAt;
  @override
  final int? labelCount;
  @override
  final Label? lastUpdatedLabel;
  @override
  final Label? userLabel;

  @override
  String toString() {
    return 'Bluetooth(name: $name, deviceId: $deviceId, manufacturerDataHead: $manufacturerDataHead, manufacturerData: $manufacturerData, rssi: $rssi, previousRssi: $previousRssi, scannedAt: $scannedAt, createdAt: $createdAt, updatedAt: $updatedAt, labelCount: $labelCount, lastUpdatedLabel: $lastUpdatedLabel, userLabel: $userLabel)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Bluetooth &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.deviceId, deviceId) &&
            const DeepCollectionEquality()
                .equals(other._manufacturerDataHead, _manufacturerDataHead) &&
            const DeepCollectionEquality()
                .equals(other._manufacturerData, _manufacturerData) &&
            const DeepCollectionEquality().equals(other.rssi, rssi) &&
            const DeepCollectionEquality()
                .equals(other.previousRssi, previousRssi) &&
            const DeepCollectionEquality().equals(other.scannedAt, scannedAt) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality().equals(other.updatedAt, updatedAt) &&
            const DeepCollectionEquality()
                .equals(other.labelCount, labelCount) &&
            const DeepCollectionEquality()
                .equals(other.lastUpdatedLabel, lastUpdatedLabel) &&
            const DeepCollectionEquality().equals(other.userLabel, userLabel));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(deviceId),
      const DeepCollectionEquality().hash(_manufacturerDataHead),
      const DeepCollectionEquality().hash(_manufacturerData),
      const DeepCollectionEquality().hash(rssi),
      const DeepCollectionEquality().hash(previousRssi),
      const DeepCollectionEquality().hash(scannedAt),
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(updatedAt),
      const DeepCollectionEquality().hash(labelCount),
      const DeepCollectionEquality().hash(lastUpdatedLabel),
      const DeepCollectionEquality().hash(userLabel));

  @JsonKey(ignore: true)
  @override
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
      @TimestampConverter() final DateTime? scannedAt,
      @TimestampConverter() final DateTime? createdAt,
      @TimestampConverter() final DateTime? updatedAt,
      final int? labelCount,
      final Label? lastUpdatedLabel,
      final Label? userLabel}) = _$_Bluetooth;

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
  @TimestampConverter()
  DateTime? get scannedAt;
  @override
  @TimestampConverter()
  DateTime? get createdAt;
  @override
  @TimestampConverter()
  DateTime? get updatedAt;
  @override
  int? get labelCount;
  @override
  Label? get lastUpdatedLabel;
  @override
  Label? get userLabel;
  @override
  @JsonKey(ignore: true)
  _$$_BluetoothCopyWith<_$_Bluetooth> get copyWith =>
      throw _privateConstructorUsedError;
}
