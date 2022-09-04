import '../../../common_widgets/alert_dialogs.dart';
import '../../../constants/resources.dart';
import '../../../exceptions/error_logger.dart';
import '../../authentication/data/auth_repository.dart';
import '../data/bluetooth_repo.dart';
import '../domain/bluetooth.dart';
import '../domain/label.dart';

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

    await ref.read(bluetoothRepoProvider).setLabel(
          deviceId: bluetooth.deviceId,
          label: label,
        );
    logger.i('updated setLabel');
  }

  Future<bool?> openLabelDialog(
      Bluetooth bluetooth, BuildContext context) async {
    logger.i('openLabelDialog bluetooth: $bluetooth');
    textEditingCtr.text = bluetooth.userLabel?.name ?? bluetooth.name;
    return await showAlertDialog(
      context: context,
      cancelActionText: 'Cancel'.hardcoded,
      defaultActionText: '🖋 Make',
      title: 'Label 🏷 ',
      content: ValueListenableBuilder<TextEditingValue>(
        valueListenable: textEditingCtr,
        builder: (context, value, _) {
          return TextField(
            controller: textEditingCtr,
            autofocus: true,
            maxLength: 20,
            decoration: InputDecoration(
              isDense: true,
              hintText: 'Bluetooth Label'.hardcoded,
              suffixIcon: value.text.isNotEmpty
                  ? IconButton(
                      onPressed: textEditingCtr.clear,
                      icon: const Icon(Icons.clear),
                    )
                  : null,
            ),
          );
        },
      ),
    );
  }
}
