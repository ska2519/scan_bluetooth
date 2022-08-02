import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FakeBluetoothRepository {
  FakeBluetoothRepository({this.addDelay = true});
  final bool addDelay;

  // List<Product> getProductsList() {
  //   return _products;
  // }

  // Product? getProduct(String id) {
  //   return _getProduct(_products, id);
  // }

  // Future<List<Product>> fetchProductsList() async {
  //   await delay(addDelay);
  //   return Future.value(_products);
  // }

  // Stream<List<Product>> watchProductsList() async* {
  //   await delay(addDelay);
  //   yield _products;
  // }

  Stream<List<ScanResult>> watchBluetoothList() {
    return FlutterBluePlus.instance.scanResults;
  }

  // Stream<Product?> watchProduct(String id) {
  //   return watchProductsList().map((products) => _getProduct(products, id));
  // }

  // static Product? _getProduct(List<Product> products, String id) {
  //   try {
  //     return products.firstWhere((product) => product.id == id);
  //   } catch (e) {
  //     return null;
  //   }
  // }
}

final bluetoothScanResultsStreamProvider =
    StreamProvider.autoDispose<List<ScanResult>>((ref) {
  final bluetoothRepository = ref.watch(bluetoothRepositoryProvider);
  return bluetoothRepository.watchBluetoothList();
});

final bluetoothRepositoryProvider = Provider<FakeBluetoothRepository>((ref) {
  // * Set addDelay to false for faster loading
  return FakeBluetoothRepository(addDelay: false);
});


// final productsListFutureProvider =
//     FutureProvider.autoDispose<List<Product>>((ref) {
//   final productsRepository = ref.watch(productsRepositoryProvider);
//   return productsRepository.fetchProductsList();
// });

// final productProvider =
//     StreamProvider.autoDispose.family<Product?, String>((ref, id) {
//   final productsRepository = ref.watch(productsRepositoryProvider);
//   return productsRepository.watchProduct(id);
// });
