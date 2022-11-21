import '../../../constants/resources.dart';
import '../application/purchases_service.dart';
import '../constants.dart';
import '../domain/purchasable_product.dart';

class FruitCount extends ConsumerWidget {
  const FruitCount({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var fruitCount = 0;
    var aFruitCount = 0;
    final pastPurchases = ref.watch(pastPurchaseListProvider);
    final fruits =
        pastPurchases.where((e) => e.productId == storeKeyConsumable);
    final aFruit =
        pastPurchases.where((e) => e.productId == storeKeyConsumableMax);
    fruits.map((e) => fruitCount += e.quantity!).toList();
    aFruit.map((e) => aFruitCount += e.quantity!).toList();
    return fruitCount <= 0 && aFruitCount <= 0
        ? const SizedBox()
        : Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (fruitCount > 0)
                    Text(
                      'Donate ${fruit()} x ${fruitCount.toString()}',
                    ),
                  if (aFruitCount > 0)
                    Text(
                      'King Donate ${fruit()} x ${aFruitCount.toString()}',
                      style: textTheme(context).bodyLarge,
                    ),
                ],
              ),
            ),
          );
  }
}
