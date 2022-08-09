import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_blue/models.dart';

import '../data/bluetooth_repository.dart';

class BluetoothService {
  BluetoothService(this.ref);
  final Ref ref;

  Future<void> startScan() async {
    ref.read(bluetoothRepositoryProvider).startScan();
    await ref.read(bluetoothRepositoryProvider).isBluetoothAvailable();
    ref.read(bluetoothListProvider.notifier).state = [];
    // TODO: 이게 꼭 필요한지 고민해보자 예)주위에 블루투스가 하나도 없을 때
    //본인 폰도 안잡힐때 리스트가 리셋이 될까?
    await ref.read(bluetoothListStreamProvider.stream).join('[]');
  }

  Future<void> stopScan() async {
    ref.read(bluetoothRepositoryProvider).stopScan();
    await ref.read(bluetoothRepositoryProvider).isBluetoothAvailable();
  }

  Future<void> connect(String deviceId) async {
    print('QuickBlue.connect');
    ref.read(bluetoothRepositoryProvider).connect(deviceId);
    // await ref.read(bluetoothRepositoryProvider).isBluetoothAvailable();
  }

  int emptyNameBTCount() {
    final scanResults = ref.read(bluetoothListProvider);
    var emptyBTCount = 0;
    for (var i = 0; i < scanResults.length; i++) {
      if (scanResults[i].name.isEmpty) {
        emptyBTCount++;
      }
    }
    return emptyBTCount;
  }

  Stream<List<BlueScanResult>> createBluetoothListStream() async* {
    final bluetoothList = ref.read(bluetoothListProvider);

    ref.watch(scanResultStreamProvider).whenData((scanBluetooth) {
      print('bluetooth: ${scanBluetooth.name} / ${scanBluetooth.deviceId}');
      print('bluetoothList.length: ${bluetoothList.length}');
      if (bluetoothList.isEmpty) {
        bluetoothList.add(scanBluetooth);
      } else {
        for (var i = 0; i < bluetoothList.length; i++) {
          if (bluetoothList[i].deviceId == scanBluetooth.deviceId) {
            bluetoothList[i] = scanBluetooth;
            break;
          } else if (i == bluetoothList.length - 1) {
            bluetoothList.add(scanBluetooth);
          }
        }
      }

      bluetoothList.sort((a, b) => b.rssi.compareTo(a.rssi));
      ref.read(bluetoothListProvider.notifier).state = bluetoothList.toList();
    });
    yield bluetoothList;
  }
}

final bluetoothServiceProvider =
    Provider<BluetoothService>(BluetoothService.new);

final emptyNameBTCountProvider = StateProvider<int>(
  (ref) => ref.watch(bluetoothServiceProvider).emptyNameBTCount(),
);
final bluetoothListProvider = StateProvider<List<BlueScanResult>>((ref) => []);

final bluetoothListStreamProvider = StreamProvider<List<BlueScanResult>>(
  (ref) => ref.watch(bluetoothServiceProvider).createBluetoothListStream(),
);
