// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names, constant_identifier_names

import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quick_blue/quick_blue.dart';

import '../../../../constants/resources.dart';
import '../../../../utils/toast_context.dart';
import '../../data/scan_bluetooth_repository.dart';
import '../../domain/bluetooth.dart';
import '../bluetooth_card/bluetooth_tile.dart';
import '../bluetooth_grid/bluetooth_grid_screen_controller.dart';

String gssUuid(String code) => '0000$code-0000-1000-8000-00805f9b34fb';

final GSS_SERV__BATTERY = gssUuid('180f');
final GSS_CHAR__BATTERY_LEVEL = gssUuid('2a19');

const WOODEMI_SUFFIX = 'ba5e-f4ee-5ca1-eb1e5e4b1ce0';

const WOODEMI_SERV__COMMAND = '57444d01-$WOODEMI_SUFFIX';
const WOODEMI_CHAR__COMMAND_REQUEST = '57444e02-$WOODEMI_SUFFIX';
const WOODEMI_CHAR__COMMAND_RESPONSE = WOODEMI_CHAR__COMMAND_REQUEST;

const WOODEMI_MTU_WUART = 247;

class BluetoothDetailPage extends StatefulHookConsumerWidget {
  const BluetoothDetailPage(this.bluetooth);
  final Bluetooth bluetooth;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BluetoothDetailPageState();
}

class _BluetoothDetailPageState extends ConsumerState<BluetoothDetailPage> {
  Bluetooth get bluetooth => widget.bluetooth;
  String get deviceId => widget.bluetooth.deviceId;
  bool connected = false;
  bool showID = false;
  Map<String, List<String>> serviceIdsCharacteristicIds = {};
  @override
  void initState() {
    super.initState();
    QuickBlue.setConnectionHandler(handleConnectionChange);
    QuickBlue.setServiceHandler(handleServiceDiscovery);
    QuickBlue.setValueHandler(handleValueChange);
  }

  @override
  void dispose() {
    super.dispose();
    QuickBlue.setValueHandler(null);
    QuickBlue.setServiceHandler(null);
    QuickBlue.setConnectionHandler(null);
  }

  void handleConnectionChange(String deviceId, BlueConnectionState state) {
    logger.i('handleConnectionChange $deviceId, ${state.value}');
    if (state.value == BlueConnectionState.connected.value) {
      setState(() => connected = true);
      ref.read(scanBluetoothRepoProvider).discoverServices(deviceId);
    } else if (state.value == BlueConnectionState.disconnected.value) {
      setState(() => connected = false);
    }
  }

  void handleServiceDiscovery(
      String deviceId, String serviceId, List<String> characteristicIds) {
    setState(() =>
        serviceIdsCharacteristicIds.addAll({serviceId: characteristicIds}));
    logger.i(
        'handleServiceDiscovery serviceIdsCharacteristicIds: ${serviceIdsCharacteristicIds.toString()}');
    logger.i(
        'handleServiceDiscovery serviceIdsCharacteristicIds.length: ${serviceIdsCharacteristicIds.length}');
  }

  void handleValueChange(
      String deviceId, String characteristicId, Uint8List value) {
    logger.i(
        'handleValueChange deviceId: $deviceId, characteristicId: $characteristicId, ${hex.encode(value)}');
    logger.i(
        '_handleValueChange deviceId: $deviceId, characteristicId: $characteristicId, value: ${value.toList()}');
  }

  final serviceUUID = TextEditingController(text: WOODEMI_SERV__COMMAND);
  final characteristicUUID =
      TextEditingController(text: WOODEMI_CHAR__COMMAND_REQUEST);
  final binaryCode = TextEditingController(
      text: hex.encode([0x01, 0x0A, 0x00, 0x00, 0x00, 0x01]));

  Future<void> sendValue({
    required String serviceId,
    required String characteristicId,
    required TextEditingController binaryCode,
  }) async {
    try {
      final value = Uint8List.fromList(hex.decode(binaryCode.text));
      await ref.read(scanBluetoothRepoProvider).writeValue(
            deviceId: deviceId,
            serviceId: serviceId, //serviceUUID.text,
            characteristicId: characteristicId, //characteristicUUID.text,
            value: value,
            bleOutputProperty: BleOutputProperty.withResponse,
          );
    } catch (e) {
      logger.e('writeValue e: $e');
    }
  }

  Future<void> readValue({
    required String serviceId,
    required String characteristicId,
  }) async {
    try {
      await ref.read(scanBluetoothRepoProvider).readValue(
          deviceId: deviceId,
          serviceId: serviceId, //GSS_SERV__BATTERY,
          characteristic: characteristicId // GSS_CHAR__BATTERY_LEVEL,
          );
    } catch (e) {
      logger.e('readValue e: $e');
    }
  }

  void toggleConnect() {
    return connected
        ? ref.read(scanBluetoothRepoProvider).disconnect(deviceId)
        : ref.read(scanBluetoothRepoProvider).connect(deviceId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BLuetooth Detail Page'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 84,
                child: Card(
                  elevation: 0.4,
                  child: Padding(
                    padding: const EdgeInsets.all(Sizes.p8),
                    child: BluetoothTile(
                      bluetooth: bluetooth,
                      onTapLabelEdit: () async => await ref
                          .read(bluetoothGridScreenControllerProvider.notifier)
                          .onTapTile(bluetooth, context),
                    ),
                  ),
                ),
              ),
              gapH24,
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: connected ? Colors.red : Colors.green,
                ),
                icon: connected
                    ? Assets.svg.icons8Disconnected.svg(height: 36, width: 36)
                    : Assets.svg.icons8Connected.svg(height: 36, width: 36),
                label: Text(connected ? 'Disconnect' : 'Connect'),
                onPressed: toggleConnect,
              ),
              gapH24,
              if (serviceIdsCharacteristicIds.isNotEmpty)
                ...serviceIdsCharacteristicIds.entries.map((e) => Column(
                      children: [
                        ...e.value.map((characteristicId) => Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                ElevatedButton.icon(
                                  icon: Assets.logo.bomb1024.image(
                                    color: Colors.white70,
                                    height: 24,
                                    width: 24,
                                  ),
                                  onPressed: () =>
                                      ref.read(fToastProvider).showToast(
                                            child: const ToastContext(
                                                'Sorry 🙏 developing feature 🧑‍💻'),
                                            gravity: ToastGravity.CENTER,
                                          ),
                                  //  () async {
                                  //   await sendValue(
                                  //     serviceId: e.key,
                                  //     characteristicId: characteristicId,
                                  //     binaryCode: binaryCode,
                                  //   );
                                  // },
                                  label: Text(
                                      'Test Characteristic\n$characteristicId'),
                                ),
                                gapH8,
                              ],
                            )),
                      ],
                    )),

              // ElevatedButton(
              //   onPressed: !connected
              //       ? null
              //       : () {
              //           ref.read(fToastProvider).showToast(
              //               child: const ToastContext(
              //                   'Sorry 🙏 developing feature 🧑‍💻'),
              //               gravity: ToastGravity.CENTER);
              //           // try {
              //           //   QuickBlue.setNotifiable(
              //           //       deviceId,
              //           //       WOODEMI_SERV__COMMAND,
              //           //       WOODEMI_CHAR__COMMAND_RESPONSE,
              //           //       BleInputProperty.indication);
              //           // } catch (e) {
              //           //   logger.e('setNotifiable e: $e');
              //           // }
              //         },
              //   child: const Text('setNotifiable'),
              // ),
              // gapH16,
              // TextField(
              //   controller: serviceUUID,
              //   decoration: const InputDecoration(
              //     labelText: 'ServiceUUID',
              //   ),
              // ),
              // gapH16,
              // TextField(
              //   controller: characteristicUUID,
              //   decoration: const InputDecoration(
              //     labelText: 'CharacteristicUUID',
              //   ),
              // ),
              gapH16,
              if (serviceIdsCharacteristicIds.isNotEmpty)
                TextField(
                  controller: binaryCode,
                  decoration: const InputDecoration(
                    labelText: 'Binary code',
                  ),
                ),

              // ElevatedButton(
              //   onPressed: !connected
              //       ? null
              //       : () async => await sendValue(deviceId, characteristicId ?? '', null),
              //   child: const Text('Send Value '),
              // ),

              // ElevatedButton(
              //   onPressed: !connected
              //       ? null
              //       : () async {
              //           // try {
              //           //   final mtu = await QuickBlue.requestMtu(
              //           //       deviceId, WOODEMI_MTU_WUART);
              //           //   logger.i('requestMtu $mtu');
              //           // } catch (e) {
              //           //   logger.e('rrequestMtu e: $e');
              //           // }
              //         },
              //   child: const Text('requestMtu'),
              // ),
              // gapH16,
            ],
          ),
        ),
      ),
    );
  }
}
