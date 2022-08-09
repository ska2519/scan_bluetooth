import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/bluetooth_service.dart';

class BluetoothListController extends StateNotifier<AsyncValue<void>> {
  BluetoothListController({
    required this.bluetoothService,
  }) : super(const AsyncData(null));
  final BluetoothService bluetoothService;

  Future<void> submitStartScan({
    void Function()? onSuccess,
  }) async {
    state = const AsyncLoading();
    final newState = await AsyncValue.guard(bluetoothService.startScan);
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

  Future<void> submitStopScan({
    void Function()? onSuccess,
  }) async {
    state = const AsyncLoading();
    final newState = await AsyncValue.guard(bluetoothService.stopScan);
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

  // Future<void> submitReview({
  //   Review? previousReview,
  //   required ProductID productId,
  //   required double rating,
  //   required String comment,
  //   required void Function() onSuccess,
  // }) async {
  //   // * only submit if the rating is new or it has changed
  //   if (previousReview == null ||
  //       rating != previousReview.rating ||
  //       comment != previousReview.comment) {
  //     final review = Review(
  //       rating: rating,
  //       comment: comment,
  //       date: currentDateBuilder(),
  //     );
  //     state = const AsyncLoading();
  //     final newState = await AsyncValue.guard(() =>
  //         reviewsService.submitReview(productId: productId, review: review));
  //     if (mounted) {
  //       // * only set the state if the controller hasn't been disposed
  //       state = newState;
  //       if (state.hasError == false) {
  //         onSuccess();
  //       }
  //     }
  //   } else {
  //     onSuccess();
  //   }
  // }
}

final bluetoothListControllerProvider = StateNotifierProvider.autoDispose<
    BluetoothListController, AsyncValue<void>>((ref) {
  return BluetoothListController(
    bluetoothService: ref.watch(bluetoothServiceProvider),
  );
});
