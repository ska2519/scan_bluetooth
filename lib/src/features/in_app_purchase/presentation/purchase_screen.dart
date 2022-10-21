import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../../../constants/resources.dart';
import '../../../utils/date_formatter.dart';
import '../../../utils/toast_context.dart';
import '../../authentication/data/auth_repository.dart';
import '../application/purchases_service.dart';
import '../constants.dart';
import '../domain/past_purchase.dart';
import '../domain/purchasable_product.dart';
import '../domain/store_state.dart';

class PurchaseScreen extends HookConsumerWidget {
  const PurchaseScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.listen<AsyncValue<void>>(purchaseScreenControllerProvider, (_, state) {
    //   logger.i('shoppingCartScreenControllerProvider state: $state');
    //   return state.showAlertDialogOnError(context);
    // });
    // final state = ref.watch(purchaseScreenControllerProvider);
    final storeState = ref.watch(storeStateProvider);
    final currentUser = ref.watch(authRepositoryProvider).currentUser;
    final pastPurchases = ref.watch(pastPurchaseListProvider);
    late Widget storeWidget;
    switch (storeState) {
      case StoreState.loading:
        storeWidget = _PurchasesLoading();
        break;
      case StoreState.available:
        storeWidget = _PurchaseList();
        break;
      case StoreState.notAvailable:
        storeWidget = _PurchasesNotAvailable();
        break;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Upgrade features')),
      body: GestureDetector(
        onTap: currentUser != null && currentUser.isAnonymous!
            ? () {
                ref.read(fToastProvider).showToast(
                    gravity: ToastGravity.TOP,
                    child: const ToastContext(
                      'Need to Login🚪 to Features Purchases',
                    ));
                context.push('/account/purchase/account');
              }
            : null,
        child: AbsorbPointer(
          absorbing: currentUser != null && currentUser.isAnonymous!,
          child: Padding(
            padding: const EdgeInsets.all(Sizes.p4),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  storeWidget,
                  if (pastPurchases.isNotEmpty)
                    const Padding(
                      padding: EdgeInsets.fromLTRB(16, 8, 0, 0),
                      child: Text(
                        'Past purchases',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  const PastPurchasesWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PurchasesLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Store is loading'));
  }
}

class _PurchasesNotAvailable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Store not available'));
  }
}

class _PurchaseList extends HookConsumerWidget {
  @override
  Widget build(BuildContext contex, WidgetRef ref) {
    final products = ref.watch(purchasableproductsProvider);
    return Column(
      children: products.map((product) {
        return _PurchaseWidget(
          product: product,
          onPressed: () => ref.read(purchasesServiceProvider).buy(product),
        );
      }).toList(),
    );
  }
}

String removeAndroidAppName(String text) {
  final temptext = text.replaceAll('(스캔 블루투스)', '');
  return temptext.replaceAll('(Scan Bluetooth)', '');
}

class _PurchaseWidget extends HookConsumerWidget {
  const _PurchaseWidget({
    required this.product,
    required this.onPressed,
  });
  final PurchasableProduct product;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var title = removeAndroidAppName(product.title);
    if (product.status == ProductStatus.purchased) {
      title += ' (purchased)';
    }

    const storeKeyUpgrade = 'remove_ads_upgrade';
    const storeKeySubscription_1m = 'support_member_subscription_1month';
    const storeKeySubscription_1y = 'support_member_subscription_1year';

    switch (product.id) {
      case storeKeyConsumable:
        title = '${fruit()} $title';
        break;
      case storeKeyConsumableMax:
        title = '${fruit()} $title';
        break;
      case storeKeyUpgrade:
        title = '␡ $title';
        break;
      case storeKeySubscription_1m:
        title = 'Ⓜ️ $title';
        break;
      case storeKeySubscription_1y:
        title = '🍦 $title';
        break;
    }

    return InkWell(
        onTap: onPressed,
        child: Card(
          elevation: 0.4,
          child: ListTile(
            title: Text(title),
            subtitle: Text(product.description),
            trailing: Text(_trailing()),
          ),
        ));
  }

  String _trailing() {
    final currencySymbol = '${product.price.substring(0, 1)} ';
    final noSymbolPrice = product.price.substring(1);

    logger.i('currencySymbolL $currencySymbol / noSymbolPrice: $noSymbolPrice');
    switch (product.status) {
      case ProductStatus.purchasable:
        return Platform.isIOS || Platform.isMacOS
            ? currencySymbol +
                NumberFormat.currency(symbol: '', decimalDigits: 0)
                    .format(int.tryParse(noSymbolPrice))
            : currencySymbol + noSymbolPrice;

      case ProductStatus.purchased:
        return 'purchased';
      case ProductStatus.pending:
        return 'buying...';
    }
  }
}

class PastPurchasesWidget extends HookConsumerWidget {
  const PastPurchasesWidget({super.key});

  String title(PastPurchase product) {
    switch (product.productId) {
      case storeKeyConsumable:
        return fruit();
      case storeKeyConsumableMax:
        return 'King ${fruit()}';
      case storeKeyUpgrade:
        return '␡ remove ads upgrade';
      case storeKeySubscription1m:
        return 'Subscription 1 month';
      case storeKeySubscription1y:
        return 'Subscription 1 year';
      default:
        return product.productId;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pastPurchases = ref.watch(pastPurchaseListProvider);
    final unExpiredPurchases =
        pastPurchases.where((e) => e.status != Status.expired).toList();
    unExpiredPurchases.sort((a, b) => b.purchaseDate.compareTo(a.purchaseDate));

    return ListView.separated(
      primary: false,
      shrinkWrap: true,
      itemCount: unExpiredPurchases.length,
      itemBuilder: (context, index) {
        final purchase = unExpiredPurchases[index];

        final purchasedateFormatted =
            ref.watch(dateFormatterProvider).format(purchase.purchaseDate);
        String? expiryDateFormatted;
        logger.i('purchase.expiryDate: ${purchase.expiryDate}');
        if (purchase.expiryDate != null) {
          expiryDateFormatted =
              ref.watch(dateFormatterProvider).format(purchase.expiryDate!);
        }

        return ListTile(
          title: Row(
            children: [
              Text(title(purchase)),
              if (purchase.quantity != null)
                Text('x ${purchase.quantity.toString()} '),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text('Status: '),
                  Text(purchase.status.toString().replaceAll('Status.', '')),
                ],
              ),
              Row(
                children: [
                  const Text('Purchase Date: '),
                  Text(purchasedateFormatted),
                ],
              ),
              if (expiryDateFormatted != null)
                Row(
                  children: [
                    const Text('Expiry Date: '),
                    Text(purchasedateFormatted),
                  ],
                ),
              // Text(purchase.expiryDate.toString()),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => const Divider(),
    );
  }
}
