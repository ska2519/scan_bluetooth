import '../../../constants/resources.dart';
import '../../../exceptions/error_logger.dart';
import '../../authentication/data/auth_repository.dart';
import '../data/bluetooth_repo.dart';
import '../domain/bluetooth.dart';
import '../domain/label.dart';
import '../presentation/bluetooth_label/label_dialog.dart';

final bluetoothServiceProvider =
    Provider<BluetoothService>(BluetoothService.new);

class BluetoothService {
  BluetoothService(this.ref) {
    _init();
  }
  final Ref ref;
  late final TextEditingController textEditingCtr;

  Future<void> _init() async {
    textEditingCtr = TextEditingController();
  }

  Future<Bluetooth?> fetchBluetooth(Bluetooth bluetooth) async {
    Bluetooth? firestoreBluetooth;
    try {
      firestoreBluetooth = await ref
          .read(bluetoothRepoProvider)
          .fetchBluetooth(deviceId: bluetooth.deviceId);
      logger.i('BluetoothService/firestoreBluetooth: $firestoreBluetooth');
      return firestoreBluetooth;
    } catch (e) {
      logger.i('BluetoothService/fetchBluetooth/e: ${e.toString()}');
      return null;
    }
  }

  Future<void> updateLabel(Bluetooth bluetooth) async {
    final user = ref.read(authRepositoryProvider).currentUser;
    logger.i('updateLabel Start user: $user');
    final label = Label(
      bluetoothName: bluetooth.name,
      deviceId: bluetooth.deviceId,
      uid: user!.uid,
      name: textEditingCtr.text,
      rssi: bluetooth.rssi,
      user: user,
      createdAt: bluetooth.userLabel?.createdAt,
    );
    logger.i('bluetooth.userLabel: ${bluetooth.userLabel}');
//TODO : Cloud functions 으로 대체
    var firestoreBluetooth = await fetchBluetooth(bluetooth);

    final setBluetooth = bluetooth.copyWith(
      userLabel: null,
      lastUpdatedLabel: label,
      labelCount: firestoreBluetooth == null ? 1 : null,
    );
    await ref.read(bluetoothRepoProvider).setBluetooth(
          bluetooth: setBluetooth,
        );
    logger.i('Finish setBluetooth');
//TODO : 여기까지

    await ref.read(bluetoothRepoProvider).setLabel(
          deviceId: bluetooth.deviceId,
          label: label,
        );
    logger.i('updated setLabel');
  }

  Future<bool?> openLabelDialog(
    Bluetooth bluetooth,
    BuildContext context,
  ) async {
    logger.i('openLabelDialog bluetooth: $bluetooth');
    textEditingCtr.text = bluetooth.userLabel?.name ?? bluetooth.name;
    return await labelDialog(context, textEditingCtr);
  }
}
