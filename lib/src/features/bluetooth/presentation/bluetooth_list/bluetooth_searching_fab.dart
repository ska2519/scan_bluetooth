import 'package:flutter/material.dart';

import '../../../../../generated/flutter_gen/assets.gen.dart';

class BluetoothSearchingFAB extends StatelessWidget {
  const BluetoothSearchingFAB(
      // this.isBluetoothAvailable,
      {
    super.key,
    this.isSearching = false,
    this.onPressed,
  });
  // final bool isBluetoothAvailable;
  final bool isSearching;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.white,
      tooltip: 'Bluetooth Search',
      onPressed: onPressed,
      // label: const Text('Searching...'),
      // icon: SizedBox(width: 48, child: Assets.gif.search2.image()),
      child: isSearching
          ? SizedBox(width: 40, child: Assets.gif.search2.image())
          : const Icon(Icons.search),
    );
  }
}
