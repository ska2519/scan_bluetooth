import 'package:package_info_plus/package_info_plus.dart';

import '../exceptions/error_logger.dart';

Future getPackageInfo() async {
  final packageInfo = await PackageInfo.fromPlatform();
  final appName = packageInfo.appName;
  final packageName = packageInfo.packageName;
  logger.i('appName: $appName / packageName: $packageName');
  return packageInfo;
}
