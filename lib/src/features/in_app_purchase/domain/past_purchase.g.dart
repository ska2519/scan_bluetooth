// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'past_purchase.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PastPurchase _$$_PastPurchaseFromJson(Map json) => _$_PastPurchase(
      type: $enumDecode(_$PurchaseTypeEnumMap, json['type']),
      store: $enumDecode(_$StoreEnumMap, json['iapSource']),
      orderId: json['orderId'] as String,
      productId: json['productId'] as String,
      purchaseDate: const TimestampConverter()
          .fromJson(json['purchaseDate'] as Timestamp),
      expiryDate:
          const TimestampNullableConverter().fromJson(json['expiryDate']),
      status: $enumDecode(_$StatusEnumMap, json['status']),
      quantity: json['quantity'] as int?,
    );

Map<String, dynamic> _$$_PastPurchaseToJson(_$_PastPurchase instance) =>
    <String, dynamic>{
      'type': _$PurchaseTypeEnumMap[instance.type]!,
      'iapSource': _$StoreEnumMap[instance.store]!,
      'orderId': instance.orderId,
      'productId': instance.productId,
      'purchaseDate': const TimestampConverter().toJson(instance.purchaseDate),
      'expiryDate':
          const TimestampNullableConverter().toJson(instance.expiryDate),
      'status': _$StatusEnumMap[instance.status]!,
      'quantity': instance.quantity,
    };

const _$PurchaseTypeEnumMap = {
  PurchaseType.subscriptionPurchase: 'SUBSCRIPTION',
  PurchaseType.nonSubscriptionPurchase: 'NON_SUBSCRIPTION',
};

const _$StoreEnumMap = {
  Store.googlePlay: 'google_play',
  Store.appStore: 'app_store',
};

const _$StatusEnumMap = {
  Status.pending: 'PENDING',
  Status.completed: 'COMPLETED',
  Status.active: 'ACTIVE',
  Status.expired: 'EXPIRED',
};
