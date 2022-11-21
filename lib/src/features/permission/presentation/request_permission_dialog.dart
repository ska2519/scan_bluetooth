import 'package:permission_handler/permission_handler.dart';

import '../../../constants/resources.dart';
import 'request_permission_screen.dart';

class RequestPermissionDialog extends StatelessWidget {
  const RequestPermissionDialog(this.requestPermissionList, {super.key});
  final List<Permission> requestPermissionList;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 40,
      ),
      insetAnimationCurve: Curves.bounceIn,
      insetAnimationDuration: const Duration(seconds: 2),
      child: RequestPermissionScreen(requestPermissionList.first),
    );
  }
}
