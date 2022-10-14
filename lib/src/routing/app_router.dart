import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../exceptions/error_logger.dart';
import '../features/authentication/application/auth_service.dart';
import '../features/authentication/presentation/account/account_screen.dart';
import '../features/bluetooth/presentation/bluetooth_screen.dart';
import '../features/community/presentation/community_screen.dart';
import '../features/in_app_purchase/presentation/purchase_screen.dart';
import '../flutter_icons/custom_flutter_icon_icons.dart';
import 'not_found_screen.dart';
import 'scaffold_with_nav_bar.dart';

enum AppRoute {
  home,
  bluetooth,
  purchase,
  account,
  community,
  // signIn,
}

final _shellNavigatorKey = GlobalKey<NavigatorState>();

final goRouterProvider = Provider<GoRouter>((ref) {
  final bluetoothNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'BluetoothNav');
  final communityNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'CommunityNav');
  final accountNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'AccountNav');

  final tabs = [
    ScaffoldWithNavBarTabItem(
      rootRoutePath: '/bluetooth',
      navigatorKey: bluetoothNavigatorKey,
      icon: const Icon(Icons.bluetooth),
      label: AppRoute.bluetooth.name,
    ),
    // ScaffoldWithNavBarTabItem(
    //   rootRoutePath: '/community',
    //   navigatorKey: communityNavigatorKey,
    //   icon: const Icon(CustomFlutterIcon.group),
    //   label: AppRoute.community.name,
    // ),
    ScaffoldWithNavBarTabItem(
      rootRoutePath: '/account',
      navigatorKey: accountNavigatorKey,
      icon: const Icon(CustomFlutterIcon.user),
      label: AppRoute.account.name,
    ),
  ];

  final user = ref.watch(authStateChangesProvider).value;
  return GoRouter(
    initialLocation: '/bluetooth',
    redirect: (context, state) {
      var isLoggedIn =
          user != null && user.isAnonymous != null && !user.isAnonymous!;
      logger.i('isLoggedIn: $isLoggedIn / state.location: ${state.location}');

      if (isLoggedIn) {
        if (state.location == '/bluetooth') {
          return null;
        }
        // if (state.location == 'signIn') {
        //   return '/bluetooth';
        // }
      } else {}
      return null;
    },
    routes: [
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          logger.i('ShellRoute state: ${state.location}');
          return ScaffoldWithNavBar(tabs: tabs, child: child);
        },
        routes: [
          GoRoute(
            path: '/bluetooth',
            name: AppRoute.bluetooth.name,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: BluetoothScreen(),
            ),
          ),
          GoRoute(
            path: '/community',
            name: AppRoute.community.name,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: CommunityScreen(),
            ),
          ),
          GoRoute(
            path: '/account',
            name: AppRoute.account.name,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: AccountScreen(),
            ),
            routes: [
              // GoRoute(
              //   path: 'signIn',
              //   name: AppRoute.signIn.name,
              //   builder: (context, state) => const SignInScreen(),
              // ),
              GoRoute(
                path: 'purchase',
                name: AppRoute.purchase.name,
                builder: (context, state) => const PurchaseScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => const NotFoundScreen(),
  );
});
