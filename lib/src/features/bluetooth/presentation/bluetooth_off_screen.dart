import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../../../constants/resources.dart';

class BluetoothOffScreen extends StatelessWidget {
  const BluetoothOffScreen({super.key, this.state});

  final BluetoothState? state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Icon(
              Icons.bluetooth_disabled,
              size: 200.0,
              color: Colors.white54,
            ),
            Text(
              'Bluetooth Adapter is ${state != null ? state.toString().substring(15) : 'not available'}.',
              style: Theme.of(context)
                  .primaryTextTheme
                  .subtitle2
                  ?.copyWith(color: Colors.white),
            ),
            if (Platform.isAndroid)
              ElevatedButton(
                onPressed: () => FlutterBluePlus.instance.turnOn(),
                child: const Text('TURN ON'),
              ),
          ],
        ),
      ),
    );
  }
}
