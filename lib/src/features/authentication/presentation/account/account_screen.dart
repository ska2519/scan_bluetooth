import '../../../../common_widgets/action_text_button.dart';
import '../../../../common_widgets/alert_dialogs.dart';
import '../../../../common_widgets/primary_button.dart';
import '../../../../common_widgets/responsive_center.dart';
import '../../../../constants/resources.dart';
import '../../../bluetooth/presentation/label/label_screen.dart';
import '../../application/auth_service.dart';
import '../sign_in/email_password/email_password_sign_in_screen.dart';
import 'account_screen_controller.dart';

/// Simple account screen showing some user info and a logout button.
class AccountScreen extends HookConsumerWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(
      accountScreenControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );

    final state = ref.watch(accountScreenControllerProvider);
    final user = ref.watch(authStateChangesProvider).value;
    final isLoggedIn = user != null && !user.isAnonymous!;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Scaffold(
      appBar: AppBar(
        title: state.isLoading
            ? const CircularProgressIndicator()
            : Text('Account'.hardcoded),
        actions: [
          if (isLoggedIn)
            ActionTextButton(
              text: 'Logout'.hardcoded,
              onPressed: state.isLoading
                  ? null
                  : () async {
                      final logout = await showAlertDialog(
                        context: context,
                        title: 'Are you sure?'.hardcoded,
                        cancelActionText: 'Cancel'.hardcoded,
                        defaultActionText: 'Logout'.hardcoded,
                      );
                      if (logout == true) {
                        await ref
                            .read(accountScreenControllerProvider.notifier)
                            .signOut();
                      }
                    },
            ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: ResponsiveCenter(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.p16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              gapH16,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (isLoggedIn &&
                      user.providerData != null &&
                      user.providerData!.isNotEmpty)
                    ...user.providerData!.map((e) {
                      logger.i('providerData e: $e');
                      switch (e.providerId) {
                        case 'apple.com':
                          return Tooltip(
                            triggerMode: TooltipTriggerMode.tap,
                            message: e.email ?? 'apple.com',
                            child: Assets.svg.appleWhite
                                .svg(width: 24, height: 24),
                          );
                        case 'google.com':
                          return Tooltip(
                            triggerMode: TooltipTriggerMode.tap,
                            message: e.email ?? 'google.com',
                            child: Assets.svg.google.svg(width: 24, height: 24),
                          );
                      }
                      return const SizedBox();
                    }).toList(),
                  gapW8,
                  Text(user?.email ?? ''),
                ],
              ),
              gapH16,
              const SignInButtonList(),
              gapH20,
              PrimaryButton(
                onPressed: () => context.goNamed(AppRoute.purchase.name),
                text: 'Feature Purchases',
                style: textTheme.bodyLarge,
                radius: 20,
                backgroundColor: colorScheme(context).onPrimary,
                foregroundColor: AppColors.figmaOrangeColor,
              ),
              gapH24,
              const LabelScreen(),
              // ElevatedButton.icon(
              //   icon: const Icon(Icons.share_outlined),
              //   onPressed: () async {
              //     final dynamicLink =
              //         await ref.read(dynamicLinkProvider).createDynamicLink();
              //     if (dynamicLink != null) {
              //       await Share.share(dynamicLink.shortUrl.toString());
              //     }
              //   },
              //   label: Text('share app'.hardcoded),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
