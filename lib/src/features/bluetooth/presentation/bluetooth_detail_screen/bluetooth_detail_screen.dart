import 'dart:async';
import 'dart:math';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../../../../constants/resources.dart';
import 'scan_result_tile.dart';

class FindDevicesScreen extends StatelessWidget {
  const FindDevicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Devices'),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.black,
            ),
            onPressed: Platform.isAndroid
                ? () => FlutterBluePlus.instance.turnOff()
                : null,
            child: const Text('TURN OFF'),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => FlutterBluePlus.instance
            .startScan(timeout: const Duration(seconds: 4)),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              StreamBuilder<List<BluetoothDevice>>(
                stream: Stream.periodic(const Duration(seconds: 2))
                    .asyncMap((_) => FlutterBluePlus.instance.connectedDevices),
                initialData: const [],
                builder: (c, snapshot) => Column(
                  children: snapshot.data!
                      .map((d) => ListTile(
                            title: Text(d.name),
                            subtitle: Text(d.id.toString()),
                            trailing: StreamBuilder<BluetoothDeviceState>(
                              stream: d.state,
                              initialData: BluetoothDeviceState.disconnected,
                              builder: (c, snapshot) {
                                if (snapshot.data ==
                                    BluetoothDeviceState.connected) {
                                  return ElevatedButton(
                                    child: const Text('OPEN'),
                                    onPressed: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DeviceScreen(device: d))),
                                  );
                                }
                                return Text(snapshot.data.toString());
                              },
                            ),
                          ))
                      .toList(),
                ),
              ),
              StreamBuilder<List<ScanResult>>(
                stream: FlutterBluePlus.instance.scanResults,
                initialData: const [],
                builder: (c, snapshot) => Column(
                  children: snapshot.data!
                      .map(
                        (r) => ScanResultTile(
                          result: r,
                          onTap: () => Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            r.device.connect();
                            return DeviceScreen(device: r.device);
                          })),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: StreamBuilder<bool>(
        stream: FlutterBluePlus.instance.isScanning,
        initialData: false,
        builder: (c, snapshot) {
          if (snapshot.data!) {
            return FloatingActionButton(
              onPressed: () => FlutterBluePlus.instance.stopScan(),
              backgroundColor: Colors.red,
              child: const Icon(Icons.stop),
            );
          } else {
            return FloatingActionButton(
                child: const Icon(Icons.search),
                onPressed: () => FlutterBluePlus.instance
                    .startScan(timeout: const Duration(seconds: 4)));
          }
        },
      ),
    );
  }
}

class DeviceScreen extends StatelessWidget {
  const DeviceScreen({super.key, required this.device});

  final BluetoothDevice device;

  List<int> _getRandomBytes() {
    final math = Random();
    return [
      math.nextInt(255),
      math.nextInt(255),
      math.nextInt(255),
      math.nextInt(255)
    ];
  }

  List<Widget> _buildServiceTiles(List<BluetoothService> services) {
    return services
        .map(
          (s) => ServiceTile(
            service: s,
            characteristicTiles: s.characteristics
                .map(
                  (c) => CharacteristicTile(
                    characteristic: c,
                    onReadPressed: () => c.read(),
                    onWritePressed: () async {
                      await c.write(_getRandomBytes(), withoutResponse: true);
                      await c.read();
                    },
                    onNotificationPressed: () async {
                      await c.setNotifyValue(!c.isNotifying);
                      await c.read();
                    },
                    descriptorTiles: c.descriptors
                        .map(
                          (d) => DescriptorTile(
                            descriptor: d,
                            onReadPressed: () => d.read(),
                            onWritePressed: () => d.write(_getRandomBytes()),
                          ),
                        )
                        .toList(),
                  ),
                )
                .toList(),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(device.name),
        actions: <Widget>[
          StreamBuilder<BluetoothDeviceState>(
            stream: device.state,
            initialData: BluetoothDeviceState.connecting,
            builder: (c, snapshot) {
              VoidCallback? onPressed;
              String text;
              switch (snapshot.data) {
                case BluetoothDeviceState.connected:
                  onPressed = device.disconnect;
                  text = 'DISCONNECT';
                  break;
                case BluetoothDeviceState.disconnected:
                  onPressed = device.connect;
                  text = 'CONNECT';
                  break;
                default:
                  onPressed = null;
                  text = snapshot.data.toString().substring(21).toUpperCase();
                  break;
              }
              return TextButton(
                  onPressed: onPressed,
                  child: Text(
                    text,
                    style: Theme.of(context)
                        .primaryTextTheme
                        .button
                        ?.copyWith(color: Colors.white),
                  ));
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            StreamBuilder<BluetoothDeviceState>(
              stream: device.state,
              initialData: BluetoothDeviceState.connecting,
              builder: (c, snapshot) => ListTile(
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    snapshot.data == BluetoothDeviceState.connected
                        ? const Icon(Icons.bluetooth_connected)
                        : const Icon(Icons.bluetooth_disabled),
                    snapshot.data == BluetoothDeviceState.connected
                        ? StreamBuilder<int>(
                            stream: rssiStream(),
                            builder: (context, snapshot) {
                              return Text(
                                  snapshot.hasData ? '${snapshot.data}dBm' : '',
                                  style: Theme.of(context).textTheme.caption);
                            })
                        : Text('', style: Theme.of(context).textTheme.caption),
                  ],
                ),
                title: Text(
                    'Device is ${snapshot.data.toString().split('.')[1]}.'),
                subtitle: Text('${device.id}'),
                trailing: StreamBuilder<bool>(
                  stream: device.isDiscoveringServices,
                  initialData: false,
                  builder: (c, snapshot) => IndexedStack(
                    index: snapshot.data! ? 1 : 0,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.refresh),
                        onPressed: device.discoverServices,
                      ),
                      const IconButton(
                        icon: SizedBox(
                          width: 18.0,
                          height: 18.0,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.grey),
                          ),
                        ),
                        onPressed: null,
                      )
                    ],
                  ),
                ),
              ),
            ),
            StreamBuilder<int>(
              stream: device.mtu,
              initialData: 0,
              builder: (c, snapshot) => ListTile(
                title: const Text('MTU Size'),
                subtitle: Text('${snapshot.data} bytes'),
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => device.requestMtu(223),
                ),
              ),
            ),
            StreamBuilder<List<BluetoothService>>(
              stream: device.services,
              initialData: const [],
              builder: (c, snapshot) {
                return Column(
                  children: _buildServiceTiles(snapshot.data!),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Stream<int> rssiStream() async* {
    var isConnected = true;
    final subscription = device.state.listen((state) {
      isConnected = state == BluetoothDeviceState.connected;
    });
    while (isConnected) {
      yield await device.readRssi();
      await Future.delayed(const Duration(seconds: 1));
    }
    await subscription.cancel();
    // Device disconnected, stopping RSSI stream
  }
}

// class DeviceScreen extends StatefulWidget {
//   const DeviceScreen({required this.device, super.key});
//   final BluetoothDevice device;

//   @override
//   DeviceScreenState createState() => DeviceScreenState();
// }

// class DeviceScreenState extends State<DeviceScreen> {
//   // 연결 상태 표시 문자열
//   String stateText = 'Connecting';

//   // 연결 버튼 문자열
//   String connectButtonText = 'Disconnect';

//   // 현재 연결 상태 저장용
//   BluetoothDeviceState deviceState = BluetoothDeviceState.disconnected;

//   // 연결 상태 리스너 핸들 화면 종료시 리스너 해제를 위함
//   StreamSubscription<BluetoothDeviceState>? _stateListener;

//   List<BluetoothService> bluetoothService = [];

//   //
//   Map<String, List<int>> notifyDatas = {};

//   @override
//   void initState() {
//     super.initState();
//     // 상태 연결 리스너 등록
//     _stateListener = widget.device.state.listen((event) {
//       logger.i('device event :  $event');
//       if (deviceState == event) {
//         // 상태가 동일하다면 무시
//         return;
//       }
//       // 연결 상태 정보 변경
//       setBleConnectionState(event);
//     });
//     // 연결 시작
//     connect();
//   }

//   @override
//   void dispose() {
//     // 상태 리스터 해제
//     _stateListener?.cancel();
//     // 연결 해제
//     disconnect();
//     super.dispose();
//   }

//   @override
//   void setState(VoidCallback fn) {
//     if (mounted) {
//       // 화면이 mounted 되었을때만 업데이트 되게 함
//       super.setState(fn);
//     }
//   }

//   /* 연결 상태 갱신 */
//   void setBleConnectionState(BluetoothDeviceState event) {
//     switch (event) {
//       case BluetoothDeviceState.disconnected:
//         stateText = 'Disconnected';
//         // 버튼 상태 변경
//         connectButtonText = 'Connect';
//         break;
//       case BluetoothDeviceState.disconnecting:
//         stateText = 'Disconnecting';
//         break;
//       case BluetoothDeviceState.connected:
//         stateText = 'Connected';
//         // 버튼 상태 변경
//         connectButtonText = 'Disconnect';
//         break;
//       case BluetoothDeviceState.connecting:
//         stateText = 'Connecting';
//         break;
//     }
//     //이전 상태 이벤트 저장
//     deviceState = event;
//     setState(() {});
//   }

//   /* 연결 시작 */
//   Future<bool> connect() async {
//     Future<bool>? returnValue;
//     setState(() {
//       /* 상태 표시를 Connecting으로 변경 */
//       stateText = 'Connecting';
//     });

//     /* 
//       타임아웃을 15초(15000ms)로 설정 및 autoconnect 해제
//        참고로 autoconnect가 true되어있으면 연결이 지연되는 경우가 있음.
//      */
//     await widget.device
//         .connect(autoConnect: false)
//         .timeout(const Duration(milliseconds: 15000), onTimeout: () {
//       //타임아웃 발생
//       //returnValue를 false로 설정
//       returnValue = Future.value(false);
//       logger.i('timeout failed');

//       //연결 상태 disconnected로 변경
//       setBleConnectionState(BluetoothDeviceState.disconnected);
//     }).then((data) async {
//       bluetoothService.clear();
//       if (returnValue == null) {
//         //returnValue가 null이면 timeout이 발생한 것이 아니므로 연결 성공
//         logger.i('connection successful');
//         logger.i('start discover service');
//         var bleServices = await widget.device.discoverServices();
//         setState(() {
//           bluetoothService = bleServices;
//         });
//         // 각 속성을 디버그에 출력
//         for (var service in bleServices) {
//           logger.i('============================================');
//           logger.i('Service UUID: ${service.uuid}');
//           for (var c in service.characteristics) {
//             logger.i('\tcharacteristic UUID: ${c.uuid.toString()}');
//             logger.i('\t\twrite: ${c.properties.write}');
//             logger.i('\t\tread: ${c.properties.read}');
//             logger.i('\t\tnotify: ${c.properties.notify}');
//             logger.i('\t\tisNotifying: ${c.isNotifying}');
//             logger.i(
//                 '\t\twriteWithoutResponse: ${c.properties.writeWithoutResponse}');
//             logger.i('\t\tindicate: ${c.properties.indicate}');

//             // notify나 indicate가 true면 디바이스에서 데이터를 보낼 수 있는 캐릭터리스틱이니 활성화 한다.
//             // 단, descriptors가 비었다면 notify를 할 수 없으므로 패스!
//             if (c.properties.notify && c.descriptors.isNotEmpty) {
//               // 진짜 0x2902 가 있는지 단순 체크용!
//               for (var d in c.descriptors) {
//                 logger.i('BluetoothDescriptor uuid ${d.uuid}');
//                 if (d.uuid == BluetoothDescriptor.cccd) {
//                   logger.i('d.lastValue: ${d.lastValue}');
//                 }
//               }

//               // notify가 설정 안되었다면...
//               if (!c.isNotifying) {
//                 try {
//                   await c.setNotifyValue(true);
//                   // 받을 데이터 변수 Map 형식으로 키 생성
//                   notifyDatas[c.uuid.toString()] = List.empty();
//                   c.value.listen((value) {
//                     // 데이터 읽기 처리!
//                     logger.i('${c.uuid}: $value');
//                     setState(() {
//                       // 받은 데이터 저장 화면 표시용
//                       notifyDatas[c.uuid.toString()] = value;
//                     });
//                   });

//                   // 설정 후 일정시간 지연
//                   await Future.delayed(const Duration(milliseconds: 500));
//                 } catch (e) {
//                   logger.i('error ${c.uuid} $e');
//                 }
//               }
//             }
//           }
//         }
//         returnValue = Future.value(true);
//       }
//     });

//     return returnValue ?? Future.value(false);
//   }

//   /* 연결 해제 */
//   void disconnect() {
//     try {
//       setState(() {
//         stateText = 'Disconnecting';
//       });
//       widget.device.disconnect();
//     } catch (e) {}
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         /* 장치명 */
//         title: Text(widget.device.name),
//       ),
//       body: Center(
//           child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               /* 연결 상태 */
//               Text(stateText),
//               /* 연결 및 해제 버튼 */
//               OutlinedButton(
//                   onPressed: () {
//                     if (deviceState == BluetoothDeviceState.connected) {
//                       /* 연결된 상태라면 연결 해제 */
//                       disconnect();
//                     } else if (deviceState ==
//                         BluetoothDeviceState.disconnected) {
//                       /* 연결 해재된 상태라면 연결 */
//                       connect();
//                     }
//                   },
//                   child: Text(connectButtonText)),
//             ],
//           ),

//           /* 연결된 BLE의 서비스 정보 출력 */
//           Expanded(
//             child: ListView.separated(
//               itemCount: bluetoothService.length,
//               itemBuilder: (context, index) {
//                 return listItem(bluetoothService[index]);
//               },
//               separatorBuilder: (BuildContext context, int index) {
//                 return const Divider();
//               },
//             ),
//           ),
//         ],
//       )),
//     );
//   }

//   /* 각 캐릭터리스틱 정보 표시 위젯 */
//   Widget characteristicInfo(BluetoothService r) {
//     var name = '';
//     var properties = '';
//     var data = '';
//     // 캐릭터리스틱을 한개씩 꺼내서 표시
//     for (var c in r.characteristics) {
//       properties = '';
//       data = '';
//       name += '\t\t${c.uuid}\n';
//       if (c.properties.write) {
//         properties += 'Write ';
//       }
//       if (c.properties.read) {
//         properties += 'Read ';
//       }
//       if (c.properties.notify) {
//         properties += 'Notify ';
//         if (notifyDatas.containsKey(c.uuid.toString())) {
//           // notify 데이터가 존재한다면
//           if (notifyDatas[c.uuid.toString()]!.isNotEmpty) {
//             data = notifyDatas[c.uuid.toString()].toString();
//           }
//         }
//       }
//       if (c.properties.writeWithoutResponse) {
//         properties += 'WriteWR ';
//       }
//       if (c.properties.indicate) {
//         properties += 'Indicate ';
//       }
//       name += '\t\t\tProperties: $properties\n';
//       if (data.isNotEmpty) {
//         // 받은 데이터 화면에 출력!
//         name += '\t\t\t\t$data\n';
//       }
//     }
//     return Text(name);
//   }

//   /* Service UUID 위젯  */
//   Widget serviceUUID(BluetoothService r) {
//     var name = '';
//     name = r.uuid.toString();
//     return Text(name);
//   }

//   /* Service 정보 아이템 위젯 */
//   Widget listItem(BluetoothService r) {
//     return ListTile(
//       title: serviceUUID(r),
//       subtitle: characteristicInfo(r),
//     );
//   }
// }


// import 'dart:typed_data';

// import 'package:convert/convert.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// import '../../../../constants/resources.dart';
// import '../../../../utils/toast_context.dart';
// import '../../domain/bluetooth_list.dart';
// import '../bluetooth_card/bluetooth_tile.dart';
// import '../bluetooth_grid/bluetooth_grid_screen_controller.dart';

// String gssUuid(String code) => '0000$code-0000-1000-8000-00805f9b34fb';

// final GSS_SERV__BATTERY = gssUuid('180f');
// final GSS_CHAR__BATTERY_LEVEL = gssUuid('2a19');

// const WOODEMI_SUFFIX = 'ba5e-f4ee-5ca1-eb1e5e4b1ce0';

// const WOODEMI_SERV__COMMAND = '57444d01-$WOODEMI_SUFFIX';
// const WOODEMI_CHAR__COMMAND_REQUEST = '57444e02-$WOODEMI_SUFFIX';
// const WOODEMI_CHAR__COMMAND_RESPONSE = WOODEMI_CHAR__COMMAND_REQUEST;

// const WOODEMI_MTU_WUART = 247;

// final autoConnectProvider = StateProvider<bool>((ref) => true);

// class BluetoothDetailScreen extends StatefulHookConsumerWidget {
//   const BluetoothDetailScreen(this.deviceId);
//   final String deviceId;

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() =>
//       _BluetoothDetailScreenState();
// }

// class _BluetoothDetailScreenState extends ConsumerState<BluetoothDetailScreen> {
//   String get deviceId => widget.deviceId;
//   bool connected = false;
//   Map<String, List<String>> bluetoothCharacteristcs = {};
//   bool isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     // QuickBlue.setConnectionHandler(handleConnectionChange);
//     // QuickBlue.setServiceHandler(handleServiceDiscovery);
//     // QuickBlue.setValueHandler(handleValueChange);

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       // if (ref.watch(autoConnectProvider)) toggleConnect();
//     });
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     // QuickBlue.setValueHandler(null);
//     // QuickBlue.setServiceHandler(null);
//     // QuickBlue.setConnectionHandler(null);
//   }

//   // void handleConnectionChange(String deviceId) {
//   //   logger.i('handleConnectionChange $deviceId, ${state.value}');
//   //   if (state.value == BlueConnectionState.connected.value) {
//   //     setState(() {
//   //       isLoading = false;
//   //       connected = true;
//   //     });
//   //     // ref.read(scanBluetoothRepoProvider).discoverServices(deviceId);
//   //   } else if (state.value == BlueConnectionState.disconnected.value) {
//   //     setState(() {
//   //       isLoading = false;
//   //       connected = false;
//   //     });
//   //   }
//   // }

//   void toggleAutoConnect(bool value) =>
//       ref.read(autoConnectProvider.notifier).state = value;

//   void handleServiceDiscovery(
//       String deviceId, String serviceId, List<String> characteristics) {
//     // bluetoothCharacteristcs.clear();
//     setState(
//         () => bluetoothCharacteristcs.addAll({serviceId: characteristics}));
//     logger.i('handleServiceDiscoverey serviceId: $serviceId');
//     logger.i(
//         'handleServiceDiscovery serviceIdsCharacteristicIds: ${characteristics.toString()}');
//     logger.i(
//         'handleServiceDiscovery characteristics[0: ${characteristics[0].characters}');
//   }

//   void handleValueChange(
//       String deviceId, String characteristicId, Uint8List value) {
//     logger.i(
//         'handleValueChange deviceId: $deviceId, characteristicId: $characteristicId, ${hex.encode(value)}');
//     logger.i(
//         '_handleValueChange deviceId: $deviceId, characteristicId: $characteristicId, value: ${value.toList()}');
//   }

//   final serviceUUID = TextEditingController(text: WOODEMI_SERV__COMMAND);
//   final characteristicUUID =
//       TextEditingController(text: WOODEMI_CHAR__COMMAND_REQUEST);
//   final binaryCode = TextEditingController(
//       text: hex.encode([0x01, 0x0A, 0x00, 0x00, 0x00, 0x01]));

//   // Future<void> sendValue({
//   //   required String serviceId,
//   //   required String characteristicId,
//   //   required TextEditingController binaryCode,
//   // }) async {
//   //   try {
//   //     final value = Uint8List.fromList(hex.decode(binaryCode.text));
//   //     await ref.read(scanBluetoothRepoProvider).writeValue(
//   //           deviceId: deviceId,
//   //           serviceId: serviceId, //serviceUUID.text,
//   //           characteristicId: characteristicId, //characteristicUUID.text,
//   //           value: value,
//   //           bleOutputProperty: BleOutputProperty.withResponse,
//   //         );
//   //   } catch (e) {
//   //     logger.e('writeValue e: $e');
//   //   }
//   // }

//   // Future<void> readValue({
//   //   required String serviceId,
//   //   required String characteristicId,
//   // }) async {
//   //   try {
//   //     await ref.read(scanBluetoothRepoProvider).readValue(
//   //         deviceId: deviceId,
//   //         serviceId: serviceId, //GSS_SERV__BATTERY,
//   //         characteristic: characteristicId // GSS_CHAR__BATTERY_LEVEL,
//   //         );
//   //   } catch (e) {
//   //     logger.e('readValue e: $e');
//   //   }
//   // }

//   void toggleConnect() {
//     // setState(() {
//     //   isLoading = true;
//     // });
//     // return connected
//     //     ? ref.read(scanBluetoothRepoProvider).disconnect(deviceId)
//     //     : ref.read(scanBluetoothRepoProvider).connect(deviceId);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final bluetooth = ref.watch(bluetoothListProvider
//         .select((list) => list.singleWhere((bt) => bt.deviceId == deviceId)));
//     final autoConnect = ref.watch(autoConnectProvider);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Bluetooth Detail'),
//         actions: [
//           Switch(
//             value: autoConnect,
//             onChanged: toggleAutoConnect,
//           )
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               SizedBox(
//                 height: 84,
//                 child: Card(
//                   elevation: 0.4,
//                   child: Padding(
//                     padding: const EdgeInsets.all(Sizes.p8),
//                     child: BluetoothTile(
//                       bluetooth: bluetooth,
//                       onPressed: () async => await ref
//                           .read(bluetoothGridScreenControllerProvider.notifier)
//                           .onTapTile(bluetooth, context),
//                     ),
//                   ),
//                 ),
//               ),
//               gapH24,
//               ElevatedButton.icon(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: isLoading
//                       ? Colors.orange
//                       : connected
//                           ? Colors.red
//                           : Colors.green,
//                 ),
//                 icon: isLoading
//                     ? const SizedBox()
//                     : connected
//                         ? Assets.svg.icons8Disconnected
//                             .svg(height: 36, width: 36)
//                         : Assets.svg.icons8Connected.svg(height: 36, width: 36),
//                 label: isLoading
//                     ? CupertinoActivityIndicator(
//                         color: colorScheme(context).primary,
//                       )
//                     : Text(connected ? 'Disconnect' : 'Connect'),
//                 onPressed: isLoading ? null : toggleConnect,
//               ),
//               gapH24,
//               if (bluetoothCharacteristcs.isNotEmpty)
//                 ...bluetoothCharacteristcs.entries.map((e) => Column(
//                       children: [
//                         ...e.value.map((characteristicId) => Column(
//                               crossAxisAlignment: CrossAxisAlignment.stretch,
//                               children: [
//                                 ElevatedButton.icon(
//                                   icon: Assets.logo.bomb1024.image(
//                                     color: Colors.white70,
//                                     height: 24,
//                                     width: 24,
//                                   ),
//                                   onPressed: () =>
//                                       ref.read(fToastProvider).showToast(
//                                             child: const ToastContext(
//                                                 'Sorry 🙏 developing feature 🧑‍💻'),
//                                             gravity: ToastGravity.CENTER,
//                                           ),
//                                   //  () async {
//                                   //   await sendValue(
//                                   //     serviceId: e.key,
//                                   //     characteristicId: characteristicId,
//                                   //     binaryCode: binaryCode,
//                                   //   );
//                                   // },
//                                   label: Text(
//                                       'Test Characteristic\n$characteristicId'),
//                                 ),
//                                 gapH8,
//                               ],
//                             )),
//                       ],
//                     )),

//               // ElevatedButton(
//               //   onPressed: !connected
//               //       ? null
//               //       : () {
//               //           ref.read(fToastProvider).showToast(
//               //               child: const ToastContext(
//               //                   'Sorry 🙏 developing feature 🧑‍💻'),
//               //               gravity: ToastGravity.CENTER);
//               //           // try {
//               //           //   QuickBlue.setNotifiable(
//               //           //       deviceId,
//               //           //       WOODEMI_SERV__COMMAND,
//               //           //       WOODEMI_CHAR__COMMAND_RESPONSE,
//               //           //       BleInputProperty.indication);
//               //           // } catch (e) {
//               //           //   logger.e('setNotifiable e: $e');
//               //           // }
//               //         },
//               //   child: const Text('setNotifiable'),
//               // ),
//               // gapH16,
//               // TextField(
//               //   controller: serviceUUID,
//               //   decoration: const InputDecoration(
//               //     labelText: 'ServiceUUID',
//               //   ),
//               // ),
//               // gapH16,
//               // TextField(
//               //   controller: characteristicUUID,
//               //   decoration: const InputDecoration(
//               //     labelText: 'CharacteristicUUID',
//               //   ),
//               // ),
//               gapH16,
//               if (bluetoothCharacteristcs.isNotEmpty)
//                 TextField(
//                   controller: binaryCode,
//                   decoration: const InputDecoration(
//                     labelText: 'Binary code',
//                   ),
//                 ),

//               // ElevatedButton(
//               //   onPressed: !connected
//               //       ? null
//               //       : () async => await sendValue(deviceId, characteristicId ?? '', null),
//               //   child: const Text('Send Value '),
//               // ),

//               // ElevatedButton(
//               //   onPressed: !connected
//               //       ? null
//               //       : () async {
//               //           // try {
//               //           //   final mtu = await QuickBlue.requestMtu(
//               //           //       deviceId, WOODEMI_MTU_WUART);
//               //           //   logger.i('requestMtu $mtu');
//               //           // } catch (e) {
//               //           //   logger.e('rrequestMtu e: $e');
//               //           // }
//               //         },
//               //   child: const Text('requestMtu'),
//               // ),
//               // gapH16,
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
