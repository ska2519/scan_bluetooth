import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import '../../../exceptions/error_logger.dart';
import '../domain/purchasable_product.dart';

class IAPConnection {
  static InAppPurchase? _instance;
  InAppPurchase get instance => _instance ??= InAppPurchase.instance;

  Future<List<PurchasableProduct>> fetchPurchasableProduct(
      Set<String> ids) async {
    final response = await _instance!.queryProductDetails(ids);
    logger
        .i('response.productDetails.length: ${response.productDetails.length}');
    return response.productDetails.map(PurchasableProduct.new).toList();
  }
}

final iAPConnectionProvider = Provider<IAPConnection>((ref) {
  return IAPConnection();
});
