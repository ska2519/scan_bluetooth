import '../../../constants/resources.dart';
import '../../../exceptions/error_logger.dart';
import '../../../utils/async_value_ui.dart';
import '../../authentication/data/auth_repository.dart';
import '../../authentication/presentation/sign_in/email_password_sign_in_screen.dart';
import '../../authentication/presentation/sign_in/email_password_sign_in_state.dart';
import '../application/purchases_service.dart';
import '../domain/purchasable_product.dart';
import '../domain/store_state.dart';
import 'purchase_screen_controller.dart';

class PurchaseScreen extends HookConsumerWidget {
  const PurchaseScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<void>>(purchaseScreenControllerProvider, (_, state) {
      logger.i('shoppingCartScreenControllerProvider state: $state');
      return state.showAlertDialogOnError(context);
    });
    // final state = ref.watch(purchaseScreenControllerProvider);
    final purchases = ref.watch(purchasesServiceProvider);
    final storeState = ref.watch(storeStateProvider);
    final currentUser = ref.watch(authRepositoryProvider).currentUser;

    if (currentUser != null && !currentUser.isAnonymous!) {
      return const EmailPasswordSignInScreen(
        formType: EmailPasswordSignInFormType.register,
      );
    }

    logger.i('PurchaseScreen storeState: ${purchases.storeState}');
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
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          storeWidget,
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
    final purchases = ref.watch(purchasesServiceProvider);
    var products = purchases.products;
    return Column(
      children: products
          .map((product) => _PurchaseWidget(
              product: product,
              onPressed: () {
                purchases.buy(product);
              }))
          .toList(),
    );
  }
}

class _PurchaseWidget extends StatelessWidget {
  const _PurchaseWidget({
    required this.product,
    required this.onPressed,
  });
  final PurchasableProduct product;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    var title = product.title;
    if (product.status == ProductStatus.purchased) {
      title += ' (purchased)';
    }
    return InkWell(
        onTap: onPressed,
        child: ListTile(
          title: Text(
            title,
          ),
          subtitle: Text(product.description),
          trailing: Text(_trailing()),
        ));
  }

  String _trailing() {
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
    var purchases = ref.watch(purchasesServiceProvider).purchases;
    return ListView.separated(
      shrinkWrap: true,
      itemCount: purchases.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(purchases[index].title),
        subtitle: Text(purchases[index].status.toString()),
      ),
      separatorBuilder: (context, index) => const Divider(),
    );
  }
}
