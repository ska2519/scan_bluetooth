import 'package:hooks_riverpod/hooks_riverpod.dart';

enum StoreState {
  loading,
  available,
  notAvailable,
}

final storeStateProvider =
    StateProvider<StoreState>((ref) => StoreState.notAvailable);
