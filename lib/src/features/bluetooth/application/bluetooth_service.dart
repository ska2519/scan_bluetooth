import '../../../constants/resources.dart';
import '../../authentication/application/auth_service.dart';
import '../../authentication/domain/app_user.dart';
import '../data/bluetooth_repo.dart';
import '../domain/bluetooth.dart';
import '../domain/label.dart';
import '../presentation/label/label_dialog.dart';

final bluetoothServiceProvider =
    Provider<BluetoothService>(BluetoothService.new);

class BluetoothService {
  BluetoothService(this.ref) {
    _init();
  }
  final Ref ref;
  late final TextEditingController textEditingCtr;

  void _init() {
    logger.i('BluetoothService _init');
    textEditingCtr = TextEditingController();
  }

  Future<Bluetooth?> featchBluetooth(Bluetooth bluetooth) async {
    try {
      final fetchBluetooth = await ref
          .read(bluetoothRepoProvider)
          .fetchBluetooth(deviceId: bluetooth.deviceId);
      return fetchBluetooth;
    } catch (e) {
      logger.i('fetchBluetooth e: $e');
    }
    return null;
  }

  // Future<void> createLabel(Bluetooth bluetooth) async {
  //   final user = ref.read(authRepositoryProvider).currentUser;
  //   logger.i('updateLabel Start user: $user');
  //   final label = _stateLabel(bluetooth, user);
  // }

  Future<void> updateLabel(Bluetooth bluetooth) async {
    final user = ref.watch(authStateChangesProvider).value;

    logger.i('updateLabel start');
    try {
      if (textEditingCtr.text.isEmpty) {
        await ref.read(bluetoothRepoProvider).deleteLabel(
              deviceId: bluetooth.deviceId,
              uid: user!.uid,
            );
        return;
      }
      final fetchBluetooth = await featchBluetooth(bluetooth);

      var label = _stateLabel(bluetooth, user);
      if (fetchBluetooth == null) {
        await ref.read(bluetoothRepoProvider).setBluetooth(
              bluetooth: bluetooth.copyWith(firstUpdatedLabel: label),
            );
      } else {
        label = _stateLabel(
            bluetooth.copyWith(labelCount: fetchBluetooth.labelCount), user);
      }

      await ref.read(bluetoothRepoProvider).setLabel(
            deviceId: bluetooth.deviceId,
            label: label,
          );
    } catch (e) {
      logger.i('updateLabel e: ${e.toString()}');
    }
  }

  Label _stateLabel(Bluetooth bluetooth, AppUser? user) {
    return Label(
      bluetooth: bluetooth.copyWith(previousRssi: null),
      uid: user!.uid,
      name: textEditingCtr.text,
      user: user,
      createdAt: bluetooth.userLabel?.createdAt,
    );
  }

  Future<bool?> openLabelDialog({
    required BuildContext context,
    Bluetooth? bluetooth,
  }) async {
    logger.i('openLabelDialog bluetooth: $bluetooth');
    textEditingCtr.text = bluetooth?.userLabel?.name ?? bluetooth?.name ?? '';
    return await labelDialog(
      context: context,
      textEditingCtr: textEditingCtr,
      bluetooth: bluetooth,
    );
  }

  Future<void> deleteLabel(Bluetooth bluetooth) async => await ref
      .read(bluetoothRepoProvider)
      .deleteLabel(deviceId: bluetooth.deviceId, uid: bluetooth.userLabel!.uid);
}

final userLabelListStreamProvider = StreamProvider<List<Label>>((ref) {
  final bluetoothRepo = ref.read(bluetoothRepoProvider);
  final user = ref.watch(authStateChangesProvider).value;
  return user != null
      ? bluetoothRepo.labelsStream(user.uid)
      : const Stream<List<Label>>.empty();
});

final userLabelCountProvider = Provider.autoDispose<int>((ref) {
  return ref
      .watch(bluetoothListProvider)
      .where((bluetooth) => bluetooth.userLabel != null)
      .toList()
      .length;
});
