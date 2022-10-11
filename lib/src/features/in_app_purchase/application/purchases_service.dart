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
final productsProvider = StateProvider<List<PurchasableProduct>>((ref) => []);
final removeAdsUpgradeProvider = StateProvider<bool>((ref) => false);

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

  Future<void> _init() async {
    logger.i('PurchasesService _init start!');
    await _loadPurchases();
    _listenToLogin();
    final iapConnection = ref.read(iAPConnectionProvider);
    final inAppPurchase = iapConnection.instance;
    final purchaseUpdated = inAppPurchase.purchaseStream;
    _subscription = purchaseUpdated.listen(
      _onPurchaseUpdate,
      onDone: _updateStreamOnDone,
      onError: _updateStreamOnError,
    );
  }

  void _listenToLogin() {
    ref.listen<AsyncValue<AppUser?>>(authStateChangesProvider,
        (previous, next) async {
      final previousUser = previous?.value;
      final user = next.value;
      logger.i('PurchasesService _init user: $user');
      if (previousUser != user) {
        logger.i('PurchasesService previousUser != user');
        await updatePurchases();
      }
    });
  }

  Future<void> _loadPurchases() async {
    final iapConnection = ref.read(iAPConnectionProvider);
    final available = await iapConnection.instance.isAvailable();
    if (!available) {
      ref
          .read(storeStateProvider.state)
          .update((state) => StoreState.notAvailable);
      return;
    }

    await fetchPurchasableProduct();
    ref.read(storeStateProvider.state).update((state) => StoreState.available);
  }

  Future<void> fetchPurchasableProduct() async {
    final iapConnection = ref.read(iAPConnectionProvider);
    const ids = <String>{
      storeKeyConsumable,
      storeKeyUpgrade,
      storeKeySubscription1m,
      storeKeySubscription1y,
    };
    final products = await iapConnection.fetchPurchasableProduct(ids);
    logger.i(
        'PurchasesService fetchPurchasableProduct() products.length: ${products.length}');

    ref.read(productsProvider.notifier).update((state) => products);
  }

  Future<void> updatePurchases() async {
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
      final pastPurchasesStream = ref.watch(pastPurchasesStreamProvider);
      pastPurchasesStream.whenData((purchases) async {
        logger.i('PurchasesService purchases: $purchases');
        ref
            .read(pastPurchaseListProvider.notifier)
            .update((state) => purchases);

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
      });
    }
  }

  Future<void> buy(PurchasableProduct product) async {
    try {
      final iapConnection = ref.read(iAPConnectionProvider);
      final inAppPurchase = iapConnection.instance;
      logger.i('PurchasesService buy product: $product');
      final purchaseParam =
          PurchaseParam(productDetails: product.productDetails);
      switch (product.id) {
        case storeKeyConsumable:
          await inAppPurchase.buyConsumable(purchaseParam: purchaseParam);
          break;
        case storeKeyUpgrade:
          await inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
          break;
        case storeKeySubscription1m:
          await inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
          break;
        case storeKeySubscription1y:
          await inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
          break;
        default:
          throw ArgumentError.value(
              product.productDetails, '${product.id} is not a known product');
      }
    } catch (e) {
      logger.i('PurchasesService buy e: ${e.toString()}');
    }
  }

  Future<void> _onPurchaseUpdate(
      List<PurchaseDetails> purchaseDetailsList) async {
    logger.i(
        'PurchasesService _onPurchaseUpdate purchaseDetailsList.length: ${purchaseDetailsList.length}');
    for (var purchaseDetails in purchaseDetailsList) {
      await _handlePurchase(purchaseDetails);
    }
  }

  Future<void> _handlePurchase(PurchaseDetails purchaseDetails) async {
    final iapConnection = ref.read(iAPConnectionProvider);
    final inAppPurchase = iapConnection.instance;
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
            ref.read(removeAdsUpgradeProvider.notifier).update((state) => true);
            break;
          case storeKeySubscription1m:
            ref.read(removeAdsUpgradeProvider.notifier).update((state) => true);
            break;
          case storeKeySubscription1y:
            ref.read(removeAdsUpgradeProvider.notifier).update((state) => true);
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
    logger.i('PurchasesService purchasesUpdate start');
    var subscriptions = <PurchasableProduct>[];
    var upgrades = <PurchasableProduct>[];
    // Get a list of purchasable products for the subscription and upgrade.
    // This should be 1 per type.
    final products = ref.read(productsProvider);
    logger.i('PurchasesService purchasesUpdate products: $products');
    if (products.isNotEmpty) {
      subscriptions = products
          .where((element) =>
              element.productDetails.id == storeKeySubscription1m ||
              element.productDetails.id == storeKeySubscription1y)
          .toList();
      upgrades = products
          .where((element) => element.productDetails.id == storeKeyUpgrade)
          .toList();
      logger.i(
          'PurchasesService purchasesUpdate subscriptions: ${subscriptions.length} / upgrades: ${upgrades.length}');
      logger.i(
          'PurchasesService purchasesUpdate hasActiveSubscription: $hasActiveSubscription / hasUpgrade: $hasUpgrade');
    }

    // Set the subscription in the counter logic and show/hide purchased on the
    // purchases page.
    if (hasActiveSubscription) {
      ref.read(removeAdsUpgradeProvider.notifier).update((state) => true);
      for (final element in subscriptions) {
        _updateStatus(element, ProductStatus.purchased);
      }
    } else {
      ref.read(removeAdsUpgradeProvider.notifier).update((state) => false);
      for (final element in subscriptions) {
        _updateStatus(element, ProductStatus.purchasable);
      }
    }
    logger.i(
        'PurchasesService purchasesUpdate hasUpgrade: $hasUpgrade /_removeAdsUpgrade: $_removeAdsUpgrade ');
    // Set the Remove Ads
    if (hasUpgrade != _removeAdsUpgrade) {
      _removeAdsUpgrade = hasUpgrade;

      ref.read(removeAdsUpgradeProvider.notifier).update((state) => hasUpgrade);
      for (final element in upgrades) {
        _updateStatus(
            element,
            _removeAdsUpgrade
                ? ProductStatus.purchased
                : ProductStatus.purchasable);
      }
    }
  }

  void _updateStatus(PurchasableProduct product, ProductStatus status) {
    if (product.status != status) {
      product.status = status;
    }
  }
}
