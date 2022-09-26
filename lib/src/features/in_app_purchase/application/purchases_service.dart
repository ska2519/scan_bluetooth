import 'dart:async';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import '../../../exceptions/error_logger.dart';
import '../../authentication/data/auth_repository.dart';
import '../../authentication/domain/app_user.dart';
import '../constants.dart';
import '../data/iap_repo.dart';
import '../domain/past_purchase.dart';
import '../domain/purchasable_product.dart';
import '../domain/store_state.dart';
import '../presentation/purchase_screen_controller.dart';
import 'iap_connection.dart';

final purchasesServiceProvider =
    Provider<PurchasesService>(PurchasesService.new);

class PurchasesService {
  PurchasesService(this.ref) {
    _init();
  }
  final Ref ref;
  late final iapConnection = ref.read(iAPConnectionProvider);
  late final inAppPurchase = iapConnection.instance;

  late StreamSubscription<List<PurchaseDetails>> _subscription;
  List<PurchasableProduct> products = [];
  late final storeState = ref.watch(storeStateProvider);
  bool get removeAds => _removeAdsUpgrade;
  bool _removeAdsUpgrade = false;

  void _init() {
    _listenToLogin();
    final purchaseUpdated = inAppPurchase.purchaseStream;
    _subscription = purchaseUpdated.listen(
      _onPurchaseUpdate,
      onDone: _updateStreamOnDone,
      onError: _updateStreamOnError,
    );
    purchasesUpdate();
    loadPurchases();
  }

  void _listenToLogin() {
    ref.listen<AsyncValue<AppUser?>>(authStateChangesProvider,
        (previous, next) {
      final previousUser = previous?.value;
      final user = next.value;
      logger.i(
          'PurchasesService _init previousUser: $previousUser / user: $user ');
      if (previousUser == null && user != null && !user.isAnonymous!) {
        updatePurchases(user.uid);
      }
    });
  }

  Future<void> loadPurchases() async {
    logger.i('loadPurchases start StoreState: $storeState');
    final available = await iapConnection.instance.isAvailable();
    if (!available) {
      ref.read(storeStateProvider.notifier).state = StoreState.notAvailable;
      return;
    }

    const ids = <String>{
      storeKeyConsumable,
      storeKeyUpgrade,
      storeKeySubscription_1m,
      storeKeySubscription_1y,
    };

    products = await iapConnection.fetchPurchasableProduct(ids);

    logger.i('loadPurchases() products: $products');
    ref.read(storeStateProvider.notifier).state = StoreState.available;
  }

  final functions = FirebaseFunctions.instanceFor(region: cloudRegion);

  List<PastPurchase> purchases = [];
  bool hasActiveSubscription = false;
  bool hasUpgrade = false;

  void updatePurchases(UserId uid) {
    logger.i('updatePurchases uid: $uid');
    final purchasesStream = ref.read(iapRepoProvider).watchPurchases(uid);
    final user = ref.watch(authStateChangesProvider).value;

    if (user == null || user.isAnonymous!) {
      purchases = [];
      hasActiveSubscription = false;
      hasUpgrade = false;
      return;
    }

    purchasesStream.listen((purchases) {
      logger.i('purchasesStream purchases: $purchases');
      hasActiveSubscription = purchases.any((element) =>
          (element.productId == storeKeySubscription_1m ||
              element.productId == storeKeySubscription_1y) &&
          element.status != Status.expired);

      hasUpgrade = purchases.any(
        (element) => element.productId == storeKeyUpgrade,
      );
    });
  }

  Future<void> buy(PurchasableProduct product) async {
    final purchaseParam = PurchaseParam(productDetails: product.productDetails);
    switch (product.id) {
      case storeKeyConsumable:
        await inAppPurchase.buyConsumable(purchaseParam: purchaseParam);
        break;
      case storeKeySubscription_1m:
      case storeKeySubscription_1y:
      case storeKeyUpgrade:
        await inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
        break;
      default:
        throw ArgumentError.value(
            product.productDetails, '${product.id} is not a known product');
    }
  }

  Future<void> _onPurchaseUpdate(
      List<PurchaseDetails> purchaseDetailsList) async {
    for (var purchaseDetails in purchaseDetailsList) {
      await _handlePurchase(purchaseDetails);
    }
    ref.refresh(purchaseScreenControllerProvider);
  }

  Future<void> _handlePurchase(PurchaseDetails purchaseDetails) async {
    if (purchaseDetails.status == PurchaseStatus.purchased) {
      // Send to server
      var validPurchase = await _verifyPurchase(purchaseDetails);

      if (validPurchase) {
        // Apply changes locally
        switch (purchaseDetails.productID) {
          case storeKeySubscription_1m:
            // counter.applyPaidMultiplier();
            break;
          case storeKeySubscription_1y:
            // counter.applyPaidMultiplier();
            break;
          case storeKeyConsumable:
            // counter.addBoughtDashes(2000);
            break;
          case storeKeyUpgrade:
            _removeAdsUpgrade = true;
            break;
        }
      }
    }

    if (purchaseDetails.pendingCompletePurchase) {
      await inAppPurchase.completePurchase(purchaseDetails);
    }
  }

  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) async {
    final callable = functions.httpsCallable('verifyPurchase');
    final results = await callable({
      'source': purchaseDetails.verificationData.source,
      'verificationData':
          purchaseDetails.verificationData.serverVerificationData,
      'productId': purchaseDetails.productID,
    });
    return results.data as bool;
  }

  void _updateStreamOnDone() {
    _subscription.cancel();
  }

  void _updateStreamOnError(dynamic error) {
    logger.i(error);
  }

  Future<void> purchasesUpdate() async {
    logger.i('purchasesUpdate start');
    var subscriptions = <PurchasableProduct>[];
    var upgrades = <PurchasableProduct>[];
    // Get a list of purchasable products for the subscription and upgrade.
    // This should be 1 per type.
    if (products.isNotEmpty) {
      subscriptions = products
          .where((element) =>
              element.productDetails.id == storeKeySubscription_1m ||
              element.productDetails.id == storeKeySubscription_1y)
          .toList();
      upgrades = products
          .where((element) => element.productDetails.id == storeKeyUpgrade)
          .toList();
    }

    // Set the subscription in the counter logic and show/hide purchased on the
    // purchases page.
    if (hasActiveSubscription) {
      // !! Subscription = remove ads
      // counter.applyPaidMultiplier();
      for (final element in subscriptions) {
        _updateStatus(element, ProductStatus.purchased);
      }
    } else {
      // !! remove Subscription
      // counter.removePaidMultiplier();
      for (final element in subscriptions) {
        _updateStatus(element, ProductStatus.purchasable);
      }
    }

    // Set the Remove Ads
    if (hasUpgrade != _removeAdsUpgrade) {
      _removeAdsUpgrade = hasUpgrade;
      for (final element in upgrades) {
        _updateStatus(
            element,
            _removeAdsUpgrade
                ? ProductStatus.purchased
                : ProductStatus.purchasable);
      }
      ref.refresh(purchaseScreenControllerProvider);
    }
  }

  void _updateStatus(PurchasableProduct product, ProductStatus status) {
    if (product.status != status) {
      product.status = status;
      ref.refresh(purchaseScreenControllerProvider);
    }
  }
}
