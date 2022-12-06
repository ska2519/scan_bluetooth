import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../app_startup.dart';

Map<String, String> analyticsLogParameters(
    ProviderContainer appStartupContainer) {
  final packageInfo = appStartupContainer.read(packageInfoProvider);
  return {
    'packageInfo.appName': packageInfo.appName,
    'packageInfo.packageName': packageInfo.packageName,
    'packageInfo.version': packageInfo.version,
    'packageInfo.buildNumber': packageInfo.buildNumber,
    'packageInfo.buildSignature': packageInfo.buildSignature,
    'Platform.localeName': Platform.localeName,
    'Platform.operatingSystem': Platform.operatingSystem,
    'Platform.operatingSystemVersion': Platform.operatingSystemVersion,
  };
}
