// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'past_purchase.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PastPurchase _$PastPurchaseFromJson(Map<String, dynamic> json) {
  return _PastPurchase.fromJson(json);
}

/// @nodoc
mixin _$PastPurchase {
  PurchaseType get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'iapSource')
  Store get store => throw _privateConstructorUsedError;
  String get orderId => throw _privateConstructorUsedError;
  String get productId => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get purchaseDate => throw _privateConstructorUsedError;
  @TimestampNullableConverter()
  DateTime? get expiryDate => throw _privateConstructorUsedError;
  Status get status => throw _privateConstructorUsedError;
  int? get quantity => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PastPurchaseCopyWith<PastPurchase> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PastPurchaseCopyWith<$Res> {
  factory $PastPurchaseCopyWith(
          PastPurchase value, $Res Function(PastPurchase) then) =
      _$PastPurchaseCopyWithImpl<$Res, PastPurchase>;
  @useResult
  $Res call(
      {PurchaseType type,
      @JsonKey(name: 'iapSource') Store store,
      String orderId,
      String productId,
      @TimestampConverter() DateTime purchaseDate,
      @TimestampNullableConverter() DateTime? expiryDate,
      Status status,
      int? quantity});
}

/// @nodoc
class _$PastPurchaseCopyWithImpl<$Res, $Val extends PastPurchase>
    implements $PastPurchaseCopyWith<$Res> {
  _$PastPurchaseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? store = null,
    Object? orderId = null,
    Object? productId = null,
    Object? purchaseDate = null,
    Object? expiryDate = freezed,
    Object? status = null,
    Object? quantity = freezed,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as PurchaseType,
      store: null == store
          ? _value.store
          : store // ignore: cast_nullable_to_non_nullable
              as Store,
      orderId: null == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as String,
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      purchaseDate: null == purchaseDate
          ? _value.purchaseDate
          : purchaseDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      expiryDate: freezed == expiryDate
          ? _value.expiryDate
          : expiryDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PastPurchaseCopyWith<$Res>
    implements $PastPurchaseCopyWith<$Res> {
  factory _$$_PastPurchaseCopyWith(
          _$_PastPurchase value, $Res Function(_$_PastPurchase) then) =
      __$$_PastPurchaseCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PurchaseType type,
      @JsonKey(name: 'iapSource') Store store,
      String orderId,
      String productId,
      @TimestampConverter() DateTime purchaseDate,
      @TimestampNullableConverter() DateTime? expiryDate,
      Status status,
      int? quantity});
}

/// @nodoc
class __$$_PastPurchaseCopyWithImpl<$Res>
    extends _$PastPurchaseCopyWithImpl<$Res, _$_PastPurchase>
    implements _$$_PastPurchaseCopyWith<$Res> {
  __$$_PastPurchaseCopyWithImpl(
      _$_PastPurchase _value, $Res Function(_$_PastPurchase) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? store = null,
    Object? orderId = null,
    Object? productId = null,
    Object? purchaseDate = null,
    Object? expiryDate = freezed,
    Object? status = null,
    Object? quantity = freezed,
  }) {
    return _then(_$_PastPurchase(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as PurchaseType,
      store: null == store
          ? _value.store
          : store // ignore: cast_nullable_to_non_nullable
              as Store,
      orderId: null == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as String,
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      purchaseDate: null == purchaseDate
          ? _value.purchaseDate
          : purchaseDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      expiryDate: freezed == expiryDate
          ? _value.expiryDate
          : expiryDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PastPurchase implements _PastPurchase {
  const _$_PastPurchase(
      {required this.type,
      @JsonKey(name: 'iapSource') required this.store,
      required this.orderId,
      required this.productId,
      @TimestampConverter() required this.purchaseDate,
      @TimestampNullableConverter() this.expiryDate,
      required this.status,
      required this.quantity});

  factory _$_PastPurchase.fromJson(Map<String, dynamic> json) =>
      _$$_PastPurchaseFromJson(json);

  @override
  final PurchaseType type;
  @override
  @JsonKey(name: 'iapSource')
  final Store store;
  @override
  final String orderId;
  @override
  final String productId;
  @override
  @TimestampConverter()
  final DateTime purchaseDate;
  @override
  @TimestampNullableConverter()
  final DateTime? expiryDate;
  @override
  final Status status;
  @override
  final int? quantity;

  @override
  String toString() {
    return 'PastPurchase(type: $type, store: $store, orderId: $orderId, productId: $productId, purchaseDate: $purchaseDate, expiryDate: $expiryDate, status: $status, quantity: $quantity)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PastPurchase &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.store, store) || other.store == store) &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.purchaseDate, purchaseDate) ||
                other.purchaseDate == purchaseDate) &&
            (identical(other.expiryDate, expiryDate) ||
                other.expiryDate == expiryDate) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, type, store, orderId, productId,
      purchaseDate, expiryDate, status, quantity);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PastPurchaseCopyWith<_$_PastPurchase> get copyWith =>
      __$$_PastPurchaseCopyWithImpl<_$_PastPurchase>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PastPurchaseToJson(
      this,
    );
  }
}

abstract class _PastPurchase implements PastPurchase {
  const factory _PastPurchase(
      {required final PurchaseType type,
      @JsonKey(name: 'iapSource') required final Store store,
      required final String orderId,
      required final String productId,
      @TimestampConverter() required final DateTime purchaseDate,
      @TimestampNullableConverter() final DateTime? expiryDate,
      required final Status status,
      required final int? quantity}) = _$_PastPurchase;

  factory _PastPurchase.fromJson(Map<String, dynamic> json) =
      _$_PastPurchase.fromJson;

  @override
  PurchaseType get type;
  @override
  @JsonKey(name: 'iapSource')
  Store get store;
  @override
  String get orderId;
  @override
  String get productId;
  @override
  @TimestampConverter()
  DateTime get purchaseDate;
  @override
  @TimestampNullableConverter()
  DateTime? get expiryDate;
  @override
  Status get status;
  @override
  int? get quantity;
  @override
  @JsonKey(ignore: true)
  _$$_PastPurchaseCopyWith<_$_PastPurchase> get copyWith =>
      throw _privateConstructorUsedError;
}
