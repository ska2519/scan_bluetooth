import 'package:flutter/material.dart';

import '../../../../../generated/flutter_gen/assets.gen.dart';

class BluetoothSearchingFAB extends StatelessWidget {
  const BluetoothSearchingFAB(this.isBluetoothAvailable, {super.key});
  final bool isBluetoothAvailable;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.white,
      tooltip: 'Bluetooth Search',
      // label: const Text('Searching...'),
      // icon: SizedBox(width: 48, child: Assets.gif.search2.image()),
      child: SizedBox(width: 40, child: Assets.gif.search2.image()),
      onPressed: () {},
    );
  }
}
