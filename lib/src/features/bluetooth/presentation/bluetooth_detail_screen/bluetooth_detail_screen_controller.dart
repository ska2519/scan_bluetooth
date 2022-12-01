import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/scan_bluetooth_repository.dart';

class BluetoothDetailScreenController extends StateNotifier<AsyncValue<void>> {
  BluetoothDetailScreenController({
    required this.scanBluetoothRepository,
  }) : super(const AsyncData(null));
  final ScanBluetoothRepository scanBluetoothRepository;

  Future<void> toggleConnect(String deviceId) async {
    AsyncValue<void>? newState;
    state = const AsyncLoading();
    // switch (signInType) {
    //   case SignInType.google:
    //     newState =
    //         await AsyncValue.guard(scanBluetoothRepository.connect(deviceId));
    //     break;
    //   case SignInType.apple:
    //     newState = await AsyncValue.guard(authRepository.signInWithApple);
    //     break;
    // }
    // if (mounted) {
    //   state = newState;
    // }
  }

  Future<void> signOut() async {
    state = const AsyncLoading();
  }
}

final bluetoothDetailScreenControllerProvider = StateNotifierProvider
    .autoDispose<BluetoothDetailScreenController, AsyncValue<void>>((ref) {
  return BluetoothDetailScreenController(
    scanBluetoothRepository: ref.read(scanBluetoothRepoProvider),
  );
});
