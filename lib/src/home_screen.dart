import 'constants/resources.dart';
import 'features/bluetooth/presentation/bluetooth_list/bluetooth_list_screen.dart';
import 'features/permission/application/permission_service.dart';

class HomeScreen extends StatefulHookConsumerWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AsyncValueWidget<bool>(
        value: ref.watch(checkPermissionListStatusProvider),
        data: BluetoothListScreen.new,
      ),
    );
  }
}
