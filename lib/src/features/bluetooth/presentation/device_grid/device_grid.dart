import 'dart:math';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../constants/resources.dart';
import '../../../../utils/destination_item_index.dart';
import '../../../../utils/toast_context.dart';
import '../../../admob/presentation/native_ad_card.dart';
import '../../../in_app_purchase/application/purchases_service.dart';
import '../../application/bluetooth_service.dart';
import '../../application/scan_device_service.dart';
import '../../domain/bluetooth_list.dart';
import '../bluetooth_card/bluetooth_card.dart';
import '../bluetooth_detail_screen/bluetooth_detail_screen.dart';
import '../scanning_fab/scanning_fab_controller.dart';
import 'device_grid_screen_controller.dart';
import 'device_layout_grid.dart';

class DeviceGrid extends HookConsumerWidget {
  const DeviceGrid({super.key});
  static const bluetootGridKey = Key('bluetooth-grid');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// ** google Ads package support only 1 ADS now. **
    const adLength = 1;
    final scanning = ref.watch(scanningProvider);
    final removeAds = ref.watch(removeAdsProvider);
    final bluetoothList = ref.watch(bluetoothListProvider);
    var kAdIndex = 1;
    if (!scanning && bluetoothList.isNotEmpty) {
      kAdIndex = Random()
          .nextInt(bluetoothList.length >= 7 ? 7 : bluetoothList.length);
    }
    final labelCount = ref.watch(userLabelListCountProvider);
    final labelLimitCount = ref.watch(labelLimitCountProvider);

    return bluetoothList.isEmpty
        ? Center(
            child: Text(
              'No Bluetooth found'.hardcoded,
              style: Theme.of(context).textTheme.headline4,
            ),
          )
        : Column(
            children: [
              AsyncValueWidget<List<BluetoothDevice>>(
                value: ref.watch(connectedDevicesProvider),
                loading: const Text('loading'),
                error: const Text('error'),
                data: (devices) {
                  logger.i('connectedDevices length: ${devices.length}');
                  return Column(
                    children: devices
                        .map((d) => ListTile(
                              title: Text(d.name),
                              // subtitle: Text(d.id.toString()),
                              trailing: StreamBuilder<BluetoothDeviceState>(
                                stream: d.state,
                                initialData: BluetoothDeviceState.disconnected,
                                builder: (c, snapshot) {
                                  if (snapshot.data ==
                                      BluetoothDeviceState.connected) {
                                    return ElevatedButton(
                                      child: const Text('OPEN'),
                                      onPressed: () => Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) =>
                                                  DeviceScreen(device: d))),
                                    );
                                  }
                                  return Text(snapshot.data.toString());
                                },
                              ),
                            ))
                        .toList(),
                  );
                },
              ),
              DeviceLayoutGrid(
                key: bluetootGridKey,
                itemCount: Platform.isAndroid && !scanning && !removeAds
                    ? bluetoothList.length + adLength
                    : bluetoothList.length,
                itemBuilder: (_, index) {
                  final i = Platform.isAndroid && !scanning && !removeAds
                      ? getItemIndex(kAdIndex, index)
                      : index;
                  //TODO: After release & setting AdMob, delete Platform.isAndroid &&
                  return Platform.isAndroid &&
                          !scanning &&
                          (index == kAdIndex && !removeAds)
                      ? const NativeAdCard()
                      : BluetoothCard(
                          onPressed: () async => labelCount >= labelLimitCount
                              ? ref.read(fToastProvider).showToast(
                                    gravity: ToastGravity.CENTER,
                                    child: const ToastContext(
                                      '99 labels to Subscribers 🏷',
                                    ),
                                  )
                              : await ref
                                  .read(deviceGridScreenControllerProvider
                                      .notifier)
                                  .onTapTile(bluetoothList[i], context),
                          bluetooth: bluetoothList[i],
                          index: i,
                        );
                },
              ),
            ],
          );
  }
}
