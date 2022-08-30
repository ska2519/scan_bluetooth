import 'dart:math';

import 'package:flutter_layout_grid/flutter_layout_grid.dart';

import '../../../../constants/resources.dart';
import '../../../../utils/current_date_provider.dart';
import '../../../../utils/destination_item_index.dart';
import '../../../admob/application/admob_service.dart';
import '../../../admob/presentation/native_ad_card.dart';
import '../../../authentication/data/auth_repository.dart';
import '../../application/nickname_bt_service.dart';
import '../../application/scan_bt_service.dart';
import '../../data/nickname_bt_repo.dart';
import '../../domain/bluetooth.dart';
import '../../domain/nickname.dart';
import '../scanning_fab/scanning_fab_controller.dart';
import 'bluetooth_card.dart';

class BluetoothGrid extends HookConsumerWidget {
  const BluetoothGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateChangesProvider).value;

    final bluetoothListValue = ref.watch(bluetoothListStreamProvider);
    final scanning = ref.watch(scanFABStateProvider);
    final interstitialAdState = ref.watch(interstitialAdStateProvider);
    final nativeAd = ref.watch(nativeAdProvider(key));

    return AsyncValueWidget<List<Bluetooth>>(
      value: bluetoothListValue,
      data: (bluetoothList) {
        var kAdIndex = 1;
        if (bluetoothList.isNotEmpty && !scanning && nativeAd != null) {
          kAdIndex = Random()
              .nextInt(bluetoothList.length >= 7 ? 7 : bluetoothList.length);
        }

        const adLength = 1;
        // final adLength = bluetoothList.length ~/ kAdIndex;
        return bluetoothList.isEmpty
            ? Center(
                child: Text(
                  'No Bluetooth found'.hardcoded,
                  style: Theme.of(context).textTheme.headline4,
                ),
              )
            : BluetoothLayoutGrid(
                itemCount: !scanning && !interstitialAdState && nativeAd != null
                    ? bluetoothList.length + adLength
                    : bluetoothList.length,
                itemBuilder: (_, index) {
                  return !scanning &&
                          !interstitialAdState &&
                          nativeAd != null &&
                          index == kAdIndex
                      // (index != 0 && index % kAdIndex == 0)
                      ? NativeAdCard(nativeAd)
                      : BluetoothCardTile(
                          onPressed: () async {
                            
                            await ref
                                .read(nickNameBluetoothRepoProvider)
                                .updateBluetooth(
                                    bluetooth: bluetoothList[!scanning
                                        ? getDestinationItemIndex(
                                            kAdIndex, index)
                                        : index]);
                            print('bluetooth grid user: $user');
                            await ref
                                .read(nicknameBTServiceProvider)
                                .updateNickname(
                                  deviceId: bluetoothList[!scanning
                                          ? getDestinationItemIndex(
                                              kAdIndex, index)
                                          : index]
                                      .deviceId,
                                  nickname: Nickname(
                                    nickname: 'nickname',
                                    user: user!,
                                    createdAt: ref
                                        .read(currentDateBuilderProvider)
                                        .call(),
                                  ),
                                );
                          },
                          // onPressed: currentUser!.isAnonymous!
                          //     ? () async {
                          //         final goSignIn = await showAlertDialog(
                          //             context: context,
                          //             title: '🏷 Make nickname',
                          //             defaultActionText: '🚪 Go to Sign In',
                          //             cancelActionText: 'Cancel',
                          //             content:
                          //                 'U can make nickname of unkown Bluetooth');
                          //         if (goSignIn != null && goSignIn) {
                          //           context.goNamed(AppRoute.signIn.name);
                          //         }
                          //       }
                          //     : null,
                          index: !scanning
                              ? getDestinationItemIndex(kAdIndex, index)
                              : index,
                          bluetooth: !scanning
                              ? bluetoothList[
                                  getDestinationItemIndex(kAdIndex, index)]
                              : bluetoothList[index],
                        );
                },
              );
      },
    );
  }
}

/// Grid widget with content-sized items.
/// See: https://codewithandrea.com/articles/flutter-layout-grid-content-sized-items/
class BluetoothLayoutGrid extends StatelessWidget {
  const BluetoothLayoutGrid({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
  });

  /// Total number of items to display.
  final int itemCount;

  /// Function used to build a widget for a given index in the grid.
  final Widget Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    // use a LayoutBuilder to determine the crossAxisCount
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      // 1 column for width < 500px
      // then add one more column for each 250px
      final crossAxisCount = max(1, width ~/ 250);
      // once the crossAxisCount is known, calculate the column and row sizes
      // set some flexible track sizes based on the crossAxisCount with 1.fr
      final columnSizes = List.generate(crossAxisCount, (_) => 1.fr);
      final numRows = (itemCount / crossAxisCount).ceil();
      // set all the row sizes to auto (self-sizing height)
      final rowSizes = List.generate(numRows, (_) => auto);
      // Custom layout grid. See: https://pub.dev/packages/flutter_layout_grid
      return LayoutGrid(
        columnSizes: columnSizes,
        rowSizes: rowSizes,
        // rowGap: Sizes.p4, // equivalent to mainAxisSpacing
        // columnGap: Sizes.p24, // equivalent to crossAxisSpacing
        children: [
          // render all the items with automatic child placement
          for (var i = 0; i < itemCount; i++) itemBuilder(context, i),
        ],
      );
    });
  }
}
