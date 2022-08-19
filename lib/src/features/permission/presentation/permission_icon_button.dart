import 'package:permission_handler/permission_handler.dart';

import '../../../../generated/flutter_gen/assets.gen.dart';
import '../../../constants/resources.dart';

class PermissionIconButton extends StatelessWidget {
  const PermissionIconButton({
    required this.permission,
    required this.onPressed,
    super.key,
  });

  final Permission permission;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Need Permission',
      onPressed: onPressed,
      icon: permission == Permission.bluetooth
          ? Assets.svg.bluetooth50.svg(color: Colors.redAccent)
          : Assets.svg.gpsLocation128.svg(color: Colors.redAccent),
    );
  }
}
