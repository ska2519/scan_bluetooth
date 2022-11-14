import 'bluetooth.dart';
import 'label.dart';

/// Helper extension used to mutate the items in the bluetoothList.
extension MutableBluetoothList on List<Bluetooth> {
  List<Bluetooth> orderBluetoothList(
    List<Bluetooth> bluetoothList,
    List<Label> labelList,
    Bluetooth scanBluetooth,
  ) {
    if (bluetoothList.isEmpty) {
      bluetoothList.add(scanBluetooth);
    } else {
      for (var i = 0; i < bluetoothList.length; i++) {
        if (bluetoothList[i].deviceId == scanBluetooth.deviceId) {
          bluetoothList[i] =
              scanBluetooth.copyWith(previousRssi: bluetoothList[i].rssi);
          break;
        } else if (i == bluetoothList.length - 1) {
          bluetoothList.add(scanBluetooth);
        }
      }
    }
    return bluetoothList;
  }

  List<Bluetooth> matchLabel(
      List<Bluetooth> bluetoothList, List<Label> labelList) {
    if (labelList.isNotEmpty) {
      for (var label in labelList) {
        for (var i = 0; i < bluetoothList.length; i++) {
          if (bluetoothList[i].deviceId == label.bluetooth.deviceId) {
            bluetoothList[i] = bluetoothList[i].copyWith(
              userLabel: label,
            );
            break;
          }
        }
      }
    }
    return bluetoothList;
  }
}
