import 'package:flutter/foundation.dart';

import '../../../../constants/resources.dart';
import '../../../authentication/application/auth_service.dart';

enum PopupMenuOption {
  signIn,
  purchase,
  account,
}

class MoreMenuButton extends ConsumerWidget {
  const MoreMenuButton({super.key});

  // * Keys for testing using find.byKey()
  static const signInKey = Key('menuSignIn');
  static const purchaseKey = Key('menuPurchase');
  static const accountKey = Key('menuAccount');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateChangesProvider).value;
    return PopupMenuButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      icon: const Icon(Icons.more_vert),
      itemBuilder: (_) => <PopupMenuEntry<PopupMenuOption>>[
        if (!kReleaseMode)
          PopupMenuItem(
            key: purchaseKey,
            value: PopupMenuOption.purchase,
            child: Text('Purchase'.hardcoded),
          ),
        if (user != null && !user.isAnonymous!)
          PopupMenuItem(
            key: accountKey,
            value: PopupMenuOption.account,
            child: Text('Account'.hardcoded),
          )
        else
          PopupMenuItem(
            key: signInKey,
            value: PopupMenuOption.signIn,
            child: Text('Sign In'.hardcoded),
          ),
      ],
      onSelected: (option) {
        // push to different routes based on selected option
        switch (option) {
          // case PopupMenuOption.signIn:
          //   context.pushNamed(AppRoute.signIn.name);
          //   break;
          case PopupMenuOption.purchase:
            context.pushNamed(AppRoute.purchase.name);
            break;
          case PopupMenuOption.account:
            context.pushNamed(AppRoute.account.name);
            break;
        }
      },
    );
  }
}
