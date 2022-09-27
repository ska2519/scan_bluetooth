import 'dart:math';

import 'package:go_router/go_router.dart';

import '../../../constants/resources.dart';
import '../../authentication/data/auth_repository.dart';
import '../application/purchases_service.dart';
import '../constants.dart';
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
            ? () => context.pushNamed(AppRoute.signIn.name)
            : null,
        child: AbsorbPointer(
          absorbing: currentUser != null && currentUser.isAnonymous!,
          child: Padding(
            padding: const EdgeInsets.all(Sizes.p4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                storeWidget,
                if (pastPurchases.isNotEmpty)
                  const Padding(
                    padding: EdgeInsets.fromLTRB(32.0, 32.0, 32.0, 0.0),
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
    final purchasesService = ref.read(purchasesServiceProvider);
    final products = ref.watch(productsProvider);
    return Column(
      children: products.map((product) {
        return _PurchaseWidget(
          product: product,
          onPressed: () => purchasesService.buy(product),
        );
      }).toList(),
    );
  }
}

const fruits = [
  '🍇',
  '🍈',
  '🍉',
  '🍊',
  '🍋',
  '🍌',
  '🍍',
  '🥭',
  '🍎',
  '🍏',
  '🍐',
  '🍑',
  '🍒',
  '🍓',
  '🥝',
  '🍅',
  '🥥'
];

class _PurchaseWidget extends HookConsumerWidget {
  const _PurchaseWidget({
    required this.product,
    required this.onPressed,
  });
  final PurchasableProduct product;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var title = product.title;
    if (product.status == ProductStatus.purchased) {
      title += ' (purchased)';
    }
    const storeKeyUpgrade = 'remove_ads_upgrade';
    const storeKeySubscription_1m = 'support_member_subscription_1month';
    const storeKeySubscription_1y = 'support_member_subscription_1year';

    switch (product.id) {
      case storeKeyConsumable:
        title = '${fruits[Random().nextInt(fruits.length)]} ${product.title}';
        break;
      case storeKeyUpgrade:
        title = '␡ ${product.title}';
        break;
      case storeKeySubscription_1m:
        title = 'Ⓜ️ ${product.title}';
        break;
      case storeKeySubscription_1y:
        title = '🍦 ${product.title}';
        break;
    }

    return InkWell(
        onTap: onPressed,
        child: Card(
          child: ListTile(
            title: Text(title),
            subtitle: Text(product.description),
            trailing: Text(_trailing(ref)),
          ),
        ));
  }

  String _trailing(WidgetRef ref) {
    switch (product.status) {
      case ProductStatus.purchasable:
        return product.price;
      case ProductStatus.purchased:
        return 'purchased';
      case ProductStatus.pending:
        return 'buying...';
    }
  }
}

class PastPurchasesWidget extends HookConsumerWidget {
  const PastPurchasesWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pastPurchases = ref.watch(pastPurchaseListProvider);
    return ListView.separated(
      shrinkWrap: true,
      itemCount: pastPurchases.length,
      itemBuilder: (context, index) {
        final purchase = pastPurchases[index];
        return ListTile(
          title: Text(purchase.title),
          subtitle: Text(purchase.status.toString()),
        );
      },
      separatorBuilder: (context, index) => const Divider(),
    );
  }
}
