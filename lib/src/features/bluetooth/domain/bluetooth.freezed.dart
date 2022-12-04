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
  String get deviceId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  BluetoothDeviceType get type => throw _privateConstructorUsedError;
  AdvertisementData? get advertisementData =>
      throw _privateConstructorUsedError;
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
  @deprecated
  List<dynamic>? get manufacturerDataHead => throw _privateConstructorUsedError;
  @deprecated
  List<dynamic>? get manufacturerData => throw _privateConstructorUsedError;

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
      {String deviceId,
      String name,
      BluetoothDeviceType type,
      AdvertisementData? advertisementData,
      int rssi,
      int? previousRssi,
      @TimestampNullableConverter() DateTime? scannedAt,
      @TimestampNullableConverter() DateTime? createdAt,
      @TimestampNullableConverter() DateTime? updatedAt,
      int labelCount,
      Label? firstUpdatedLabel,
      Label? userLabel,
      bool canConnect,
      @deprecated List<dynamic>? manufacturerDataHead,
      @deprecated List<dynamic>? manufacturerData});

  $AdvertisementDataCopyWith<$Res>? get advertisementData;
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
    Object? deviceId = null,
    Object? name = null,
    Object? type = null,
    Object? advertisementData = freezed,
    Object? rssi = null,
    Object? previousRssi = freezed,
    Object? scannedAt = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? labelCount = null,
    Object? firstUpdatedLabel = freezed,
    Object? userLabel = freezed,
    Object? canConnect = null,
    Object? manufacturerDataHead = freezed,
    Object? manufacturerData = freezed,
  }) {
    return _then(_value.copyWith(
      deviceId: null == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as BluetoothDeviceType,
      advertisementData: freezed == advertisementData
          ? _value.advertisementData
          : advertisementData // ignore: cast_nullable_to_non_nullable
              as AdvertisementData?,
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
      manufacturerDataHead: freezed == manufacturerDataHead
          ? _value.manufacturerDataHead
          : manufacturerDataHead // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      manufacturerData: freezed == manufacturerData
          ? _value.manufacturerData
          : manufacturerData // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AdvertisementDataCopyWith<$Res>? get advertisementData {
    if (_value.advertisementData == null) {
      return null;
    }

    return $AdvertisementDataCopyWith<$Res>(_value.advertisementData!, (value) {
      return _then(_value.copyWith(advertisementData: value) as $Val);
    });
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
      {String deviceId,
      String name,
      BluetoothDeviceType type,
      AdvertisementData? advertisementData,
      int rssi,
      int? previousRssi,
      @TimestampNullableConverter() DateTime? scannedAt,
      @TimestampNullableConverter() DateTime? createdAt,
      @TimestampNullableConverter() DateTime? updatedAt,
      int labelCount,
      Label? firstUpdatedLabel,
      Label? userLabel,
      bool canConnect,
      @deprecated List<dynamic>? manufacturerDataHead,
      @deprecated List<dynamic>? manufacturerData});

  @override
  $AdvertisementDataCopyWith<$Res>? get advertisementData;
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
    Object? deviceId = null,
    Object? name = null,
    Object? type = null,
    Object? advertisementData = freezed,
    Object? rssi = null,
    Object? previousRssi = freezed,
    Object? scannedAt = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? labelCount = null,
    Object? firstUpdatedLabel = freezed,
    Object? userLabel = freezed,
    Object? canConnect = null,
    Object? manufacturerDataHead = freezed,
    Object? manufacturerData = freezed,
  }) {
    return _then(_$_Bluetooth(
      deviceId: null == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as BluetoothDeviceType,
      advertisementData: freezed == advertisementData
          ? _value.advertisementData
          : advertisementData // ignore: cast_nullable_to_non_nullable
              as AdvertisementData?,
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
      manufacturerDataHead: freezed == manufacturerDataHead
          ? _value._manufacturerDataHead
          : manufacturerDataHead // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      manufacturerData: freezed == manufacturerData
          ? _value._manufacturerData
          : manufacturerData // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Bluetooth implements _Bluetooth {
  const _$_Bluetooth(
      {required this.deviceId,
      required this.name,
      this.type = BluetoothDeviceType.unknown,
      this.advertisementData,
      required this.rssi,
      this.previousRssi,
      @TimestampNullableConverter() this.scannedAt,
      @TimestampNullableConverter() this.createdAt,
      @TimestampNullableConverter() this.updatedAt,
      this.labelCount = 0,
      this.firstUpdatedLabel,
      this.userLabel,
      this.canConnect = false,
      @deprecated final List<dynamic>? manufacturerDataHead,
      @deprecated final List<dynamic>? manufacturerData})
      : _manufacturerDataHead = manufacturerDataHead,
        _manufacturerData = manufacturerData;

  factory _$_Bluetooth.fromJson(Map<String, dynamic> json) =>
      _$$_BluetoothFromJson(json);

  @override
  final String deviceId;
  @override
  final String name;
  @override
  @JsonKey()
  final BluetoothDeviceType type;
  @override
  final AdvertisementData? advertisementData;
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
  final List<dynamic>? _manufacturerDataHead;
  @override
  @deprecated
  List<dynamic>? get manufacturerDataHead {
    final value = _manufacturerDataHead;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<dynamic>? _manufacturerData;
  @override
  @deprecated
  List<dynamic>? get manufacturerData {
    final value = _manufacturerData;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Bluetooth(deviceId: $deviceId, name: $name, type: $type, advertisementData: $advertisementData, rssi: $rssi, previousRssi: $previousRssi, scannedAt: $scannedAt, createdAt: $createdAt, updatedAt: $updatedAt, labelCount: $labelCount, firstUpdatedLabel: $firstUpdatedLabel, userLabel: $userLabel, canConnect: $canConnect, manufacturerDataHead: $manufacturerDataHead, manufacturerData: $manufacturerData)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Bluetooth &&
            (identical(other.deviceId, deviceId) ||
                other.deviceId == deviceId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.advertisementData, advertisementData) ||
                other.advertisementData == advertisementData) &&
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
                other.canConnect == canConnect) &&
            const DeepCollectionEquality()
                .equals(other._manufacturerDataHead, _manufacturerDataHead) &&
            const DeepCollectionEquality()
                .equals(other._manufacturerData, _manufacturerData));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      deviceId,
      name,
      type,
      advertisementData,
      rssi,
      previousRssi,
      scannedAt,
      createdAt,
      updatedAt,
      labelCount,
      firstUpdatedLabel,
      userLabel,
      canConnect,
      const DeepCollectionEquality().hash(_manufacturerDataHead),
      const DeepCollectionEquality().hash(_manufacturerData));

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
      {required final String deviceId,
      required final String name,
      final BluetoothDeviceType type,
      final AdvertisementData? advertisementData,
      required final int rssi,
      final int? previousRssi,
      @TimestampNullableConverter() final DateTime? scannedAt,
      @TimestampNullableConverter() final DateTime? createdAt,
      @TimestampNullableConverter() final DateTime? updatedAt,
      final int labelCount,
      final Label? firstUpdatedLabel,
      final Label? userLabel,
      final bool canConnect,
      @deprecated final List<dynamic>? manufacturerDataHead,
      @deprecated final List<dynamic>? manufacturerData}) = _$_Bluetooth;

  factory _Bluetooth.fromJson(Map<String, dynamic> json) =
      _$_Bluetooth.fromJson;

  @override
  String get deviceId;
  @override
  String get name;
  @override
  BluetoothDeviceType get type;
  @override
  AdvertisementData? get advertisementData;
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
  @deprecated
  List<dynamic>? get manufacturerDataHead;
  @override
  @deprecated
  List<dynamic>? get manufacturerData;
  @override
  @JsonKey(ignore: true)
  _$$_BluetoothCopyWith<_$_Bluetooth> get copyWith =>
      throw _privateConstructorUsedError;
}

AdvertisementData _$AdvertisementDataFromJson(Map<String, dynamic> json) {
  return _AdvertisementData.fromJson(json);
}

/// @nodoc
mixin _$AdvertisementData {
  String get localName => throw _privateConstructorUsedError;
  int? get txPowerLevel => throw _privateConstructorUsedError;
  bool get connectable => throw _privateConstructorUsedError;
  Map<int, List<int>> get manufacturerData =>
      throw _privateConstructorUsedError;
  Map<String, List<int>> get serviceData => throw _privateConstructorUsedError;
  List<String> get serviceUuids => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AdvertisementDataCopyWith<AdvertisementData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdvertisementDataCopyWith<$Res> {
  factory $AdvertisementDataCopyWith(
          AdvertisementData value, $Res Function(AdvertisementData) then) =
      _$AdvertisementDataCopyWithImpl<$Res, AdvertisementData>;
  @useResult
  $Res call(
      {String localName,
      int? txPowerLevel,
      bool connectable,
      Map<int, List<int>> manufacturerData,
      Map<String, List<int>> serviceData,
      List<String> serviceUuids});
}

/// @nodoc
class _$AdvertisementDataCopyWithImpl<$Res, $Val extends AdvertisementData>
    implements $AdvertisementDataCopyWith<$Res> {
  _$AdvertisementDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? localName = null,
    Object? txPowerLevel = freezed,
    Object? connectable = null,
    Object? manufacturerData = null,
    Object? serviceData = null,
    Object? serviceUuids = null,
  }) {
    return _then(_value.copyWith(
      localName: null == localName
          ? _value.localName
          : localName // ignore: cast_nullable_to_non_nullable
              as String,
      txPowerLevel: freezed == txPowerLevel
          ? _value.txPowerLevel
          : txPowerLevel // ignore: cast_nullable_to_non_nullable
              as int?,
      connectable: null == connectable
          ? _value.connectable
          : connectable // ignore: cast_nullable_to_non_nullable
              as bool,
      manufacturerData: null == manufacturerData
          ? _value.manufacturerData
          : manufacturerData // ignore: cast_nullable_to_non_nullable
              as Map<int, List<int>>,
      serviceData: null == serviceData
          ? _value.serviceData
          : serviceData // ignore: cast_nullable_to_non_nullable
              as Map<String, List<int>>,
      serviceUuids: null == serviceUuids
          ? _value.serviceUuids
          : serviceUuids // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AdvertisementDataCopyWith<$Res>
    implements $AdvertisementDataCopyWith<$Res> {
  factory _$$_AdvertisementDataCopyWith(_$_AdvertisementData value,
          $Res Function(_$_AdvertisementData) then) =
      __$$_AdvertisementDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String localName,
      int? txPowerLevel,
      bool connectable,
      Map<int, List<int>> manufacturerData,
      Map<String, List<int>> serviceData,
      List<String> serviceUuids});
}

/// @nodoc
class __$$_AdvertisementDataCopyWithImpl<$Res>
    extends _$AdvertisementDataCopyWithImpl<$Res, _$_AdvertisementData>
    implements _$$_AdvertisementDataCopyWith<$Res> {
  __$$_AdvertisementDataCopyWithImpl(
      _$_AdvertisementData _value, $Res Function(_$_AdvertisementData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? localName = null,
    Object? txPowerLevel = freezed,
    Object? connectable = null,
    Object? manufacturerData = null,
    Object? serviceData = null,
    Object? serviceUuids = null,
  }) {
    return _then(_$_AdvertisementData(
      localName: null == localName
          ? _value.localName
          : localName // ignore: cast_nullable_to_non_nullable
              as String,
      txPowerLevel: freezed == txPowerLevel
          ? _value.txPowerLevel
          : txPowerLevel // ignore: cast_nullable_to_non_nullable
              as int?,
      connectable: null == connectable
          ? _value.connectable
          : connectable // ignore: cast_nullable_to_non_nullable
              as bool,
      manufacturerData: null == manufacturerData
          ? _value._manufacturerData
          : manufacturerData // ignore: cast_nullable_to_non_nullable
              as Map<int, List<int>>,
      serviceData: null == serviceData
          ? _value._serviceData
          : serviceData // ignore: cast_nullable_to_non_nullable
              as Map<String, List<int>>,
      serviceUuids: null == serviceUuids
          ? _value._serviceUuids
          : serviceUuids // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AdvertisementData implements _AdvertisementData {
  const _$_AdvertisementData(
      {required this.localName,
      this.txPowerLevel,
      required this.connectable,
      required final Map<int, List<int>> manufacturerData,
      required final Map<String, List<int>> serviceData,
      required final List<String> serviceUuids})
      : _manufacturerData = manufacturerData,
        _serviceData = serviceData,
        _serviceUuids = serviceUuids;

  factory _$_AdvertisementData.fromJson(Map<String, dynamic> json) =>
      _$$_AdvertisementDataFromJson(json);

  @override
  final String localName;
  @override
  final int? txPowerLevel;
  @override
  final bool connectable;
  final Map<int, List<int>> _manufacturerData;
  @override
  Map<int, List<int>> get manufacturerData {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_manufacturerData);
  }

  final Map<String, List<int>> _serviceData;
  @override
  Map<String, List<int>> get serviceData {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_serviceData);
  }

  final List<String> _serviceUuids;
  @override
  List<String> get serviceUuids {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_serviceUuids);
  }

  @override
  String toString() {
    return 'AdvertisementData(localName: $localName, txPowerLevel: $txPowerLevel, connectable: $connectable, manufacturerData: $manufacturerData, serviceData: $serviceData, serviceUuids: $serviceUuids)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AdvertisementData &&
            (identical(other.localName, localName) ||
                other.localName == localName) &&
            (identical(other.txPowerLevel, txPowerLevel) ||
                other.txPowerLevel == txPowerLevel) &&
            (identical(other.connectable, connectable) ||
                other.connectable == connectable) &&
            const DeepCollectionEquality()
                .equals(other._manufacturerData, _manufacturerData) &&
            const DeepCollectionEquality()
                .equals(other._serviceData, _serviceData) &&
            const DeepCollectionEquality()
                .equals(other._serviceUuids, _serviceUuids));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      localName,
      txPowerLevel,
      connectable,
      const DeepCollectionEquality().hash(_manufacturerData),
      const DeepCollectionEquality().hash(_serviceData),
      const DeepCollectionEquality().hash(_serviceUuids));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AdvertisementDataCopyWith<_$_AdvertisementData> get copyWith =>
      __$$_AdvertisementDataCopyWithImpl<_$_AdvertisementData>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AdvertisementDataToJson(
      this,
    );
  }
}

abstract class _AdvertisementData implements AdvertisementData {
  const factory _AdvertisementData(
      {required final String localName,
      final int? txPowerLevel,
      required final bool connectable,
      required final Map<int, List<int>> manufacturerData,
      required final Map<String, List<int>> serviceData,
      required final List<String> serviceUuids}) = _$_AdvertisementData;

  factory _AdvertisementData.fromJson(Map<String, dynamic> json) =
      _$_AdvertisementData.fromJson;

  @override
  String get localName;
  @override
  int? get txPowerLevel;
  @override
  bool get connectable;
  @override
  Map<int, List<int>> get manufacturerData;
  @override
  Map<String, List<int>> get serviceData;
  @override
  List<String> get serviceUuids;
  @override
  @JsonKey(ignore: true)
  _$$_AdvertisementDataCopyWith<_$_AdvertisementData> get copyWith =>
      throw _privateConstructorUsedError;
}
