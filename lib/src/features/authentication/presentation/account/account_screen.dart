import 'package:fluttertoast/fluttertoast.dart';

import '../../../../common_widgets/action_text_button.dart';
import '../../../../common_widgets/alert_dialogs.dart';
import '../../../../common_widgets/loading_stack_body.dart';
import '../../../../common_widgets/primary_button.dart';
import '../../../../common_widgets/responsive_center.dart';
import '../../../../constants/resources.dart';
import '../../../../utils/toast_context.dart';
import '../../../firebase/remote_config.dart';
import '../../../in_app_purchase/presentation/fruit_count.dart';
import '../../../presence_user/presentation/user_count_banner.dart';
import '../../application/auth_service.dart';
import '../profile/go_profile_screen_user_avatar.dart';
import '../sign_in/sign_in_button_list.dart';
import 'account_screen_controller.dart';

/// Simple account screen showing some user info and a logout button.
class AccountScreen extends HookConsumerWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(appUserStateChangesProvider).value;
    ref.listen<AsyncValue>(
      accountScreenControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );

    final state = ref.watch(accountScreenControllerProvider);
    final enablePurchaseScreen = ref.watch(enablePurchaseScreenProvider);
    final isLoggedIn = user != null && !user.isAnonymous!;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return AbsorbPointer(
      absorbing: state.isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Account'.hardcoded),
          leading: Center(
            child: GoProfileScreenUserAvatar(
              onTap: user != null && !user.isAnonymous!
                  ? () => context.goNamed(
                        AppRoute.profile.name,
                        params: {'uid': user.uid},
                      )
                  : () => ref.read(fToastProvider).showToast(
                        gravity: ToastGravity.TOP,
                        child: const ToastContext(
                          'Need Login 🚪 to Profile',
                        ),
                      ),
            ),
          ),
          actions: [
            // if (isLoggedIn)
            ActionTextButton(
              text: 'Logout'.hardcoded,
              onPressed: () async {
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
        body: LoadingStackBody(
          isLoading: state.isLoading,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ResponsiveCenter(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.p8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  gapH8,
                  const UserCountBanner(),
                  gapH16,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (isLoggedIn &&
                          user.providerData != null &&
                          user.providerData!.isNotEmpty)
                        ...user.providerData!.map((userInfo) {
                          switch (userInfo.providerId) {
                            case 'apple.com':
                              return Row(
                                children: [
                                  Tooltip(
                                    triggerMode: TooltipTriggerMode.tap,
                                    message: userInfo.email ?? 'apple.com',
                                    child: CircleAvatar(
                                      radius: 16,
                                      child: Assets.svg.appleWhite
                                          .svg(width: 24, height: 24),
                                    ),
                                  ),
                                  gapW8,
                                ],
                              );
                            case 'google.com':
                              return Row(
                                children: [
                                  Tooltip(
                                    triggerMode: TooltipTriggerMode.tap,
                                    message: userInfo.email ?? 'google.com',
                                    child: CircleAvatar(
                                      radius: 16,
                                      backgroundColor: Colors.white,
                                      child: Assets.svg.google
                                          .svg(width: 24, height: 24),
                                    ),
                                  ),
                                  gapW8,
                                ],
                              );
                          }
                          return const SizedBox();
                        }).toList(),
                      gapW8,
                      Text(user?.email ?? ''),
                    ],
                  ),

                  if (!isLoggedIn)
                    Column(
                      children: const [
                        gapH8,
                        SignInButtonList(),
                      ],
                    ),
                  gapH24,
                  if (enablePurchaseScreen)
                    Column(
                      children: [
                        PrimaryButton(
                          onPressed: () =>
                              context.goNamed(AppRoute.purchase.name),
                          text: '🔺 Upgrade Features',
                          style: textTheme.bodyLarge,
                          radius: 20,
                          backgroundColor: colorScheme(context).onPrimary,
                          foregroundColor: AppColors.figmaOrangeColor,
                        ),
                        gapH8,
                      ],
                    ),

                  const FruitCount(),
                  gapH24,
                  // const LabelScreen(),
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
        ),
      ),
    );
  }
}
