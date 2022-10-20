import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../firebase/firestore_json_converter.dart';

part 'past_purchase.freezed.dart';
part 'past_purchase.g.dart';

enum PurchaseType {
  @JsonValue('SUBSCRIPTION')
  subscriptionPurchase,
  @JsonValue('NON_SUBSCRIPTION')
  nonSubscriptionPurchase,
}

enum Store {
  @JsonValue('google_play')
  googlePlay,
  @JsonValue('app_store')
  appStore,
}

enum Status {
  @JsonValue('PENDING')
  pending,
  @JsonValue('COMPLETED')
  completed,
  @JsonValue('ACTIVE')
  active,
  @JsonValue('EXPIRED')
  expired,
}

@freezed
class PastPurchase with _$PastPurchase {
  const factory PastPurchase({
    required PurchaseType type,
    @JsonKey(name: 'iapSource') required Store store,
    required String orderId,
    required String productId,
    @TimestampConverter() required DateTime purchaseDate,
    @TimestampNullableConverter() DateTime? expiryDate,
    required Status status,
    required int? quantity,
  }) = _PastPurchase;

  factory PastPurchase.fromJson(Map<String, dynamic> json) =>
      _$PastPurchaseFromJson(json);
}
