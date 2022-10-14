import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../common_widgets/action_text_button.dart';
import '../../../../common_widgets/alert_dialogs.dart';
import '../../../../common_widgets/responsive_center.dart';
import '../../../../constants/app_sizes.dart';
import '../../../../localization/string_hardcoded.dart';
import '../../../../utils/async_value_ui.dart';
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
    final isLoggedIn =
        user != null && user.isAnonymous != null && !user.isAnonymous!;

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
      body: ResponsiveCenter(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.p16),
        child: Column(
          children: [
            gapH16,
            Text(user?.email ?? ''),
            gapH16,
            if (user?.providerData != null)
              ...user!.providerData!
                  .map((e) => Text(e.providerId ?? ''))
                  .toList(),
            gapH16,
            const SignInButtonList(),
            gapH16,
            // ElevatedButton.icon(
            //   icon: const Icon(Icons.share_outlined),
            //   onPressed: ref.read(dynamicLinkProvider).createDynamicLink,
            //   label: Text('share app'.hardcoded),
            // ),
          ],
        ),
      ),
    );
  }
}
