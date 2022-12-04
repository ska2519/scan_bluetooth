import '../../../constants/resources.dart';
import '../../authentication/application/auth_service.dart';
import '../../authentication/domain/app_user.dart';
import '../data/bluetooth_repo.dart';
import '../domain/bluetooth.dart';
import '../domain/bluetooth_list.dart';
import '../domain/label.dart';
import '../presentation/label/label_dialog.dart';

final userLabelListCountProvider = StateProvider<int>((ref) => 0);

final userLabelListStreamProvider = StreamProvider<List<Label?>>((ref) {
  final bluetoothRepo = ref.read(bluetoothRepoProvider);
  final user = ref.watch(authStateChangesProvider).value;

  if (user == null) return const Stream<List<Label?>>.empty();

  final labelListStream = bluetoothRepo.labelsStream(user.uid);

  labelListStream.listen((labelList) =>
      ref.read(userLabelListCountProvider.notifier).state = labelList.length);
  return labelListStream;
});

final userLabelCountProvider = Provider.autoDispose<int>((ref) {
  var length = 0;
  if (ref.watch(bluetoothListProvider).isNotEmpty) {
    length = ref
        .read(bluetoothListProvider)
        .where((bluetooth) => bluetooth.userLabel != null)
        .toList()
        .length;
  }
  return length;
});

final bluetoothServiceProvider =
    Provider<BluetoothService>(BluetoothService.new);

class BluetoothService {
  BluetoothService(this.ref) {
    _init();
  }
  final Ref ref;
  late final TextEditingController textEditingCtr;

  void _init() {
    textEditingCtr = TextEditingController();
  }

  Future<Bluetooth?> featchBluetooth(Bluetooth bluetooth) async {
    try {
      return await ref
          .read(bluetoothRepoProvider)
          .fetchBluetooth(deviceId: bluetooth.deviceId);
    } catch (e) {
      logger.e('fetchBluetooth e: $e');
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

      var label = _stateLabel(bluetooth, user);
      final fetchBluetooth = await featchBluetooth(bluetooth);
      if (fetchBluetooth == null) {
        await ref.read(bluetoothRepoProvider).setBluetooth(
              bluetooth: bluetooth.copyWith(firstUpdatedLabel: label),
            );
      } else {}
      await ref.read(bluetoothRepoProvider).setLabel(
            deviceId: bluetooth.deviceId,
            label: label,
          );
    } catch (e) {
      logger.e('updateLabel e: $e');
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
