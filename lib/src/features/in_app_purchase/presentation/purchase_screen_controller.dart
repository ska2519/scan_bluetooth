import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../authentication/data/auth_repository.dart';
import '../application/purchases_service.dart';

class PurchaseScreenController extends StateNotifier<AsyncValue<void>> {
  PurchaseScreenController({
    required this.authRepository,
    required this.purchasesService,
  }) : super(const AsyncData(null));
  final PurchasesService purchasesService;
  final AuthRepository authRepository;

  Future<void> purchasesUpdate() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(purchasesService.purchasesUpdate);
  }
}

final purchaseScreenControllerProvider =
    StateNotifierProvider<PurchaseScreenController, AsyncValue>(
        (ref) => PurchaseScreenController(
              authRepository: ref.read(authRepositoryProvider),
              purchasesService: ref.read(purchasesServiceProvider),
            ));
