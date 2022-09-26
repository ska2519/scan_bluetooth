import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../localization/string_hardcoded.dart';
import '../../../../routing/app_router.dart';
import '../../../authentication/domain/app_user.dart';

enum PopupMenuOption {
  signIn,
  purchase,
  account,
}

class MoreMenuButton extends StatelessWidget {
  const MoreMenuButton({super.key, this.user});
  final AppUser? user;

  // * Keys for testing using find.byKey()
  static const signInKey = Key('menuSignIn');
  static const purchaseKey = Key('menuPurchase');
  static const accountKey = Key('menuAccount');

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      // three vertical dots icon (to reveal menu options)
      icon: const Icon(Icons.more_vert),
      itemBuilder: (_) {
        // show all the options based on conditional logic
        return user != null && !user!.isAnonymous!
            ? <PopupMenuEntry<PopupMenuOption>>[
                PopupMenuItem(
                  key: accountKey,
                  value: PopupMenuOption.account,
                  child: Text('Account'.hardcoded),
                ),
              ]
            : <PopupMenuEntry<PopupMenuOption>>[
                PopupMenuItem(
                  key: purchaseKey,
                  value: PopupMenuOption.purchase,
                  child: Text('Purchase'.hardcoded),
                ),
                PopupMenuItem(
                  key: signInKey,
                  value: PopupMenuOption.signIn,
                  child: Text('Sign In'.hardcoded),
                ),
              ];
      },
      onSelected: (option) {
        // push to different routes based on selected option
        switch (option) {
          case PopupMenuOption.signIn:
            context.pushNamed(AppRoute.signIn.name);
            break;
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
