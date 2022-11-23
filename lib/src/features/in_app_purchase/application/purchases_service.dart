import 'dart:async';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import '../../../exceptions/error_logger.dart';
import '../../authentication/application/auth_service.dart';
import '../../authentication/domain/app_user.dart';
import '../constants.dart';
import '../data/iap_repo.dart';
import '../domain/past_purchase.dart';
import '../domain/purchasable_product.dart';
import '../domain/store_state.dart';
import 'iap_connection.dart';

final purchasesServiceProvider =
    Provider<PurchasesService>(PurchasesService.new);
final pastPurchaseListProvider = StateProvider<List<PastPurchase>>((ref) => []);
final purchasableproductsProvider =
    StateProvider<List<PurchasableProduct>>((ref) => []);

final removeAdsProvider = StateProvider<bool>((ref) => false);
final preventScanTimeProvider = StateProvider<int>((ref) => 4);

class PurchasesService {
  PurchasesService(this.ref) {
    _init();
  }
  final Ref ref;
  final functions = FirebaseFunctions.instanceFor(region: cloudRegion);
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  bool get removeAds => _removeAdsUpgrade;
  bool _removeAdsUpgrade = false;
  bool hasActiveSubscription = false;
  bool hasUpgrade = false;
  List<PastPurchase> purchases = [];
  late final purchasableProducts = ref.watch(purchasableproductsProvider);
  late final iapConnection = ref.read(iAPConnectionProvider);
  late final inAppPurchase = iapConnection.instance;

  Future<void> _init() async {
    logger.i('PurchasesService _init start!');
    await _loadPurchases();
    await updatePurchases();
    _listenToLogin();

    final purchaseUpdated = inAppPurchase.purchaseStream;
    _subscription = purchaseUpdated.listen(
      _onPurchaseUpdate,
      onDone: _updateStreamOnDone,
      onError: _updateStreamOnError,
    );
  }

  void _listenToLogin() async {
    ref.listen<AsyncValue<AppUser?>>(authStateChangesProvider,
        (previous, next) async {
      final user = next.value;
      logger.i('PurchasesService _listenToLogin user: $user');
      await updatePurchases();
    });
  }

  Future<void> _loadPurchases() async {
    try {
      final available = await inAppPurchase.isAvailable();
      if (!available) {
        ref
            .read(storeStateProvider.notifier)
            .update((state) => StoreState.notAvailable);
        return;
      }

      await fetchPurchasableProduct();
      ref
          .read(storeStateProvider.notifier)
          .update((state) => StoreState.available);
    } catch (e) {
      logger.e('_loadPurchases e: $e');
    }
  }

  Future<void> fetchPurchasableProduct() async {
    try {
      final products = await iapConnection.fetchPurchasableProduct(ids);
      logger.i(
          'PurchasesService fetchPurchasableProduct() products.length: ${products.length}');

      ref
          .read(purchasableproductsProvider.notifier)
          .update((state) => products);
    } catch (e) {
      logger.e('PurchasesService fetchPurchasableProduct e: $e');
    }
  }

  Future<void> updatePurchases() async {
    try {
      final user = ref.read(authStateChangesProvider).value;
      logger.i('PurchasesService updatePurchases uid: ${user?.uid}');

      if (user == null || user.isAnonymous!) {
        logger.i('PurchasesService if (user == null || user.isAnonymous!)');
        hasActiveSubscription = false;
        hasUpgrade = false;

        ref.read(pastPurchaseListProvider.notifier).update((state) => []);
        return await purchasesUpdate();
      } else if (!user.isAnonymous!) {
        logger.i('PurchasesService !user.isAnonymous!');

        ref.watch(pastPurchasesStreamProvider.stream).listen((purchases) async {
          purchases = purchases;
          logger.i('PurchasesService purchases.length: ${purchases.length}');

          hasActiveSubscription = purchases.any((element) =>
              (element.productId == storeKeySubscription1m ||
                  element.productId == storeKeySubscription1y) &&
              element.status != Status.expired);

          hasUpgrade = purchases.any(
            (element) => element.productId == storeKeyUpgrade,
          );
          logger.i(
              'PurchasesService updatePurchases hasActiveSubscription: $hasActiveSubscription /  hasUpgrade: $hasUpgrade');
          await purchasesUpdate();
          ref
              .read(pastPurchaseListProvider.notifier)
              .update((state) => purchases);
        });
      }
    } catch (e) {
      logger.e('PurchasesService updatePurchases e: $e');
    }
  }

  Future<bool> buy(PurchasableProduct product) async {
    try {
      logger.i('PurchasesService buy product: $product');
      final purchaseParam =
          PurchaseParam(productDetails: product.productDetails);
      switch (product.id) {
        case storeKeyConsumable:
          return await inAppPurchase.buyConsumable(
              purchaseParam: purchaseParam);

        case storeKeyConsumableMax:
          return await inAppPurchase.buyConsumable(
              purchaseParam: purchaseParam);
        case storeKeyUpgrade:
          return await inAppPurchase.buyNonConsumable(
              purchaseParam: purchaseParam);
        case storeKeySubscription1m:
          return await inAppPurchase.buyNonConsumable(
              purchaseParam: purchaseParam);
        case storeKeySubscription1y:
          return await inAppPurchase.buyNonConsumable(
              purchaseParam: purchaseParam);
        default:
          throw ArgumentError.value(
              product.productDetails, '${product.id} is not a known product');
      }
    } catch (e) {
      logger.e('PurchasesService buy e: ${e.toString()}');
    }
    return false;
  }

  Future<void> _onPurchaseUpdate(
      List<PurchaseDetails> purchaseDetailsList) async {
    logger.i(
        'PurchasesService _onPurchaseUpdate purchaseDetailsList.length: ${purchaseDetailsList.length}');
    for (var purchaseDetails in purchaseDetailsList) {
      await _handlePurchase(purchaseDetails);
    }
    await purchasesUpdate();
  }

  Future<void> _handlePurchase(PurchaseDetails purchaseDetails) async {
    logger.i(
        'PurchasesService purchaseDetails.status : ${purchaseDetails.status}');
    if (purchaseDetails.status == PurchaseStatus.purchased) {
      // Send to server
      var validPurchase = await _verifyPurchase(purchaseDetails);
      logger.i('PurchasesService validPurchase: $validPurchase');
      if (validPurchase) {
        switch (purchaseDetails.productID) {
          case storeKeyConsumable:
            // counter.addBoughtDashes(2000);
            break;
          case storeKeyUpgrade:
            ref.read(removeAdsProvider.notifier).update((state) => true);
            break;
          case storeKeySubscription1m:
            ref.read(removeAdsProvider.notifier).update((state) => true);
            break;
          case storeKeySubscription1y:
            ref.read(removeAdsProvider.notifier).update((state) => true);
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
    try {
      var subscriptions = <PurchasableProduct>[];
      var upgrades = <PurchasableProduct>[];
      // Get a list of purchasable products for the subscription and upgrade.
      // This should be 1 per type.
      // final products = ref.read(productsProvider);
      logger
          .i('PurchasesService purchasesUpdate products: $purchasableProducts');
      if (purchasableProducts.isNotEmpty) {
        subscriptions = purchasableProducts
            .where((element) =>
                element.productDetails.id == storeKeySubscription1m ||
                element.productDetails.id == storeKeySubscription1y)
            .toList();
        upgrades = purchasableProducts
            .where((element) => element.productDetails.id == storeKeyUpgrade)
            .toList();
        logger.i(
            'PurchasesService subscriptions: ${subscriptions.length} / upgrades: ${upgrades.length}');
        logger.i(
            'PurchasesService hasActiveSubscription: $hasActiveSubscription / hasUpgrade: $hasUpgrade');
      }

      // Set the subscription in the counter logic and show/hide purchased on the
      // purchases page.
      if (hasActiveSubscription) {
        for (final element in subscriptions) {
          _updateStatus(element, ProductStatus.purchased);
        }
        ref.read(removeAdsProvider.notifier).update((state) => true);
        ref.read(preventScanTimeProvider.notifier).update((state) => 0);
      } else {
        for (final element in subscriptions) {
          _updateStatus(element, ProductStatus.purchasable);
        }
        ref.read(removeAdsProvider.notifier).update((state) => false);
        ref.read(preventScanTimeProvider.notifier).update((state) => 4);
      }
      logger.i(
          'PurchasesService hasUpgrade: $hasUpgrade /_removeAdsUpgrade: $_removeAdsUpgrade');
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
        ref.read(removeAdsProvider.notifier).update((state) => hasUpgrade);
      }
    } catch (e) {
      logger.e('PurchasesService purchasesUpdate e: $e');
    }
  }

  void _updateStatus(PurchasableProduct product, ProductStatus status) {
    if (product.status != status) {
      product.status = status;
    }
  }
}
