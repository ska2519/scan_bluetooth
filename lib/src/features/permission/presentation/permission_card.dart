import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../common_widgets/async_value_widget.dart';
import '../../../exceptions/error_logger.dart';
import '../application/permission_service.dart';
import 'permission_icon_button.dart';

class RequestPemissionsCard extends StatefulHookConsumerWidget {
  const RequestPemissionsCard({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PemissionCardState();
}

class _PemissionCardState extends ConsumerState<RequestPemissionsCard> {
  Future<void> submitPermission(Permission permission) async {
    final permissionStatus = await permission.request();
    logger.i('permissionStatus: $permissionStatus');
    if (permissionStatus == PermissionStatus.denied ||
        permissionStatus == PermissionStatus.permanentlyDenied) {
      final isOpend = await openAppSettings();
      logger.i('Opend AppSettings: $isOpend');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          for (var permission in defaultBluetoothPermissionList)
            AsyncValueWidget<PermissionStatus>(
              loading: const SizedBox(),
              value: ref.watch(checkPermissionStatusProvider(permission)),
              data: (status) {
                logger.i('Permission status: $status');
                return status == PermissionStatus.granted
                    ? const SizedBox()
                    : PermissionIconButton(
                        permission: permission,
                        onPressed: () async =>
                            await submitPermission(permission),
                      );
              },
            ),
        ],
      ),
    );
  }
}
