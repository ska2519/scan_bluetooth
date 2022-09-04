import 'package:permission_handler/permission_handler.dart';

import '../../../../layout/adaptive.dart';
import '../../../../layout/letter_spacing.dart';
import '../../../common_widgets/alert_dialogs.dart';
import '../../../constants/resources.dart';
import '../../../constants/theme.dart';

class RequestPermissionScreen extends HookConsumerWidget {
  const RequestPermissionScreen(this.permission, {super.key});
  final Permission permission;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    final isDesktop = isDisplayDesktop(context);
    final permissionName = permission.toString().split('.').last;

    final buttonTextPadding = isDesktop
        ? const EdgeInsets.symmetric(horizontal: 24, vertical: 16)
        : EdgeInsets.zero;

    Future<void> submitPermission() async {
      final permissionStatus = await permission.request();
      if (permissionStatus.isGranted) {
        Navigator.of(context).pop();
      }
      if (permissionStatus == PermissionStatus.permanentlyDenied) {
        final buttonAction = await showAlertDialog(
          context: context,
          title: 'Update $permissionName settings',
          defaultActionText: 'Update Settings',
          cancelActionText: 'No Thanks',
          content: Text(
              'Please update your $permissionName setting in order to use feature.'),
        );
        if (buttonAction == true) {
          Navigator.of(context).pop();
          await openAppSettings();
        }
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.p20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.location_on_outlined,
            color: colorScheme.primary,
            size: 36,
          ),
          gapH12,
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'Use your ',
              style: textTheme.titleLarge,
              children: [
                TextSpan(
                  text: permissionName,
                  style: textTheme.headline6!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.secondary,
                  ),
                ),
                const TextSpan(text: ' permission'),
              ],
            ),
          ),
          gapH20,
          Text(
            '🔔 BOMB collects $permissionName data to find Bluetooth device location when Bluetooth device search feature is turned on, and is also used to support ads.',
            textAlign: TextAlign.center,
          ),
          gapH24,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.p48),
            child: Assets.image.requestLocationPermission.image(),
          ),
          gapH48,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  shape: const BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Text(
                    'DENY',
                    style: TextStyle(color: colorScheme.onSurface),
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 8,
                  shape: const BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                  ),
                ),
                onPressed: submitPermission,
                child: Padding(
                  padding: buttonTextPadding,
                  child: Text(
                    'ACCEPT',
                    style: TextStyle(
                      letterSpacing: letterSpacingOrNone(largeLetterSpacing),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
