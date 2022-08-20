import 'package:permission_handler/permission_handler.dart';

import '../../../constants/resources.dart';
import '../application/permission_service.dart';
import 'request_permission_screen.dart';

class RequestPermissionDialog extends StatefulHookConsumerWidget {
  const RequestPermissionDialog(this.permissionListStatus, {super.key});
  final bool permissionListStatus;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RequestPermissionScreenState();
}

class _RequestPermissionScreenState
    extends ConsumerState<RequestPermissionDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 40,
      ),
      insetAnimationCurve: Curves.bounceIn,
      insetAnimationDuration: const Duration(seconds: 2),
      child: AsyncValueWidget<List<Permission>>(
        value: ref.watch(requestPermissionListProvider),
        data: (requestPermissionList) => Stack(
          children:
              requestPermissionList.map(RequestPermissionScreen.new).toList(),
        ),
      ),
    );
  }
}
