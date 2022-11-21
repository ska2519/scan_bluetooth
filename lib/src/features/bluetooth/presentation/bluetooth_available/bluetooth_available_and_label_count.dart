import 'package:flutter/material.dart';

import 'bluetooth_available.dart';
import 'user_label_count.dart';

class BluetoothAvailableAndLabelCount extends StatelessWidget {
  const BluetoothAvailableAndLabelCount(this.isBluetoothAvailable, {super.key});

  final bool isBluetoothAvailable;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BluetoothAvailable(isBluetoothAvailable),
        const UserLabelCount(),
      ],
    );
  }
}
