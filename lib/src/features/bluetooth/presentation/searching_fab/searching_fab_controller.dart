// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../admob/application/admob_service.dart';
import '../../application/bluetooth_service.dart';

class SearchingFABController extends StateNotifier<AsyncValue<void>> {
  SearchingFABController({
    required this.bluetoothService,
    required this.admobService,
  }) : super(const AsyncData(null));
  final BluetoothService bluetoothService;
  final AdmobService admobService;

  Future<void> submitSearching(
    bool searching, {
    void Function()? onSuccess,
  }) async {
    state = const AsyncLoading();
    final newState = await AsyncValue.guard(
        () => bluetoothService.submitSearching(searching));
    if (!searching) {
      print('searching: $searching');
      admobService.showInterstitialAd();
    }
    if (mounted) {
      // * only set the state if the controller hasn't been disposed
      state = newState;
      if (state.hasError == false) {
        if (onSuccess != null) onSuccess();
      }
    } else {
      if (onSuccess != null) onSuccess();
    }
  }
}

final searchingFABStateProvider = StateProvider<bool>((ref) => false);

final searchingFABControllerProvider =
    StateNotifierProvider.autoDispose<SearchingFABController, AsyncValue<void>>(
  (ref) => SearchingFABController(
    bluetoothService: ref.read(bluetoothServiceProvider),
    admobService: ref.read(admobServiceProvider),
  ),
);
