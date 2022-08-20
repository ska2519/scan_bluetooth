// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

final requiredPermissionList = Platform.isAndroid
    ? [
        Permission.bluetooth,
        Permission.locationWhenInUse,
      ]
    : [
        Permission.bluetooth,
        Permission.locationWhenInUse,
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

  Future<List<Permission>> requestPermissionList() async {
    final requestPermissionList = <Permission>[];

    for (var requiredPermission in requiredPermissionList) {
      final status = await checkPermissionStatus(requiredPermission);
      if (!status.isGranted) {
        requestPermissionList.add(requiredPermission);
      }
    }
    print('permissionStatusList: $requestPermissionList');
    return requestPermissionList;
  }
}

final checkPermissionListStatusProvider = FutureProvider.autoDispose<bool>(
    (ref) async =>
        ref.read(permissionServiceProvider).checkPermissionListStatus());

final checkPermissionStatusProvider = FutureProvider.family
    .autoDispose<PermissionStatus, Permission>((ref, permission) async =>
        await ref
            .read(permissionServiceProvider)
            .checkPermissionStatus(permission));

final requestPermissionListProvider =
    FutureProvider.autoDispose<List<Permission>>((ref) async =>
        await ref.read(permissionServiceProvider).requestPermissionList());

final permissionServiceProvider =
    Provider<PermissionService>(PermissionService.new);
