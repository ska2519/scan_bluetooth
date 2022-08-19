// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

const requiredPermissionList = [
  Permission.bluetooth,
  Permission.locationWhenInUse,
  // Permission.locationAlways,
];

class PermissionService {
  PermissionService(this.ref);
  Ref ref;

  Future<bool> checkPermissionListStatus() async {
    for (var permission in requiredPermissionList) {
      if (await checkPermissionStatus(permission) != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  Future<PermissionStatus> checkPermissionStatus(Permission permission) async =>
      await permission.status;
}

final checkPermissionListStatusProvider = FutureProvider.autoDispose<bool>(
    (ref) async =>
        ref.read(permissionServiceProvider).checkPermissionListStatus());

final checkPermissionStatusProvider = FutureProvider.family
    .autoDispose<PermissionStatus, Permission>((ref, permission) async =>
        await ref
            .read(permissionServiceProvider)
            .checkPermissionStatus(permission));

final permissionServiceProvider =
    Provider<PermissionService>(PermissionService.new);
