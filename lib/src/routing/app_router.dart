import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../exceptions/error_logger.dart';
import '../features/authentication/data/auth_repository.dart';
import '../features/authentication/presentation/account/account_screen.dart';
import '../features/authentication/presentation/profile/profile_screen.dart';
import '../features/bluetooth/presentation/bluetooth_detail_screen/bluetooth_detail_screen.dart';
import '../features/bluetooth/presentation/bluetooth_screen.dart';
import '../features/firebase/remote_config.dart';
import '../features/in_app_purchase/presentation/purchase_screen.dart';
import '../flutter_icons/custom_flutter_icon_icons.dart';
import 'disabled_app_screen.dart';
import 'home_screen.dart';
import 'not_found_screen.dart';
import 'scaffold_with_nav_bar.dart';

enum AppRoute {
  home,
  bluetooth,
  account,
  profile,
  purchase,
  community,
  device,
  disabledApp,
  // signIn,
}

final _shellNavigatorKey = GlobalKey<NavigatorState>();
final tempLocationProvider = Provider<String?>((ref) => null);
String tempLocaion = '';

final goRouterProvider = Provider<GoRouter>((ref) {
  final bluetoothNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'BluetoothNav');
  // final communityNavigatorKey =
  //     GlobalKey<NavigatorState>(debugLabel: 'CommunityNav');
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

  final disabledApp = ref.watch(disabledAppProvider);
  final user = ref.watch(authStateChangesProvider).value;

  logger.i('GoRouter tempLocaion: $tempLocaion/ user: $user');
  return GoRouter(
    initialLocation:
        tempLocaion.isNotEmpty ? tempLocaion : (kIsWeb ? '/' : '/bluetooth'),
    redirect: (context, state) {
      if (disabledApp) {
        return '/disabledApp';
      }
      var isLoggedIn = user != null && !user.isAnonymous;
      logger.i('GoRouter isLoggedIn: $isLoggedIn /location: ${state.location}');

      if (user != null) {
        tempLocaion = '';
      }

      if (state.location == '/account/purchase/account') {
        tempLocaion = '/account/purchase';
      } else if (state.location == '/account') {
        tempLocaion = '/account';
      }

      return null;
    },
    routes: disabledApp
        ? [
            GoRoute(
              path: '/disabledApp',
              name: AppRoute.disabledApp.name,
              builder: (context, state) => const DisabledAppScreen(),
            )
          ]
        : kIsWeb
            ? [
                GoRoute(
                  path: '/',
                  name: AppRoute.home.name,
                  builder: (context, state) => const HomeScreen(),
                ),
                GoRoute(
                  path: '/account',
                  name: AppRoute.account.name,
                  builder: (context, state) => const AccountScreen(),
                ),
              ]
            : [
                ShellRoute(
                  navigatorKey: _shellNavigatorKey,
                  builder: (context, state, child) {
                    logger.i('GoRouter ShellRoute state: ${state.location}');
                    return ScaffoldWithNavBar(tabs: tabs, child: child);
                  },
                  routes: [
                    GoRoute(
                      path: '/bluetooth',
                      name: AppRoute.bluetooth.name,
                      pageBuilder: (context, state) => const NoTransitionPage(
                        child: BluetoothScreen(),
                      ),
                      routes: [
                        GoRoute(
                          name: AppRoute.device.name,
                          path: 'device',
                          builder: (context, state) => DeviceScreen(
                            device: state.extra as BluetoothDevice,
                          ),
                        ),
                      ],
                    ),
                    // GoRoute(
                    //   path: '/community',
                    //   name: AppRoute.community.name,
                    //   pageBuilder: (context, state) => const NoTransitionPage(
                    //     child: CommunityScreen(),
                    //   ),
                    // ),

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
                          path: 'profile:uid',
                          name: AppRoute.profile.name,
                          builder: (context, state) {
                            final uid = state.params['uid']!;
                            return ProfileScreen(uid);
                          },
                        ),
                        GoRoute(
                          path: 'purchase',
                          name: AppRoute.purchase.name,
                          builder: (context, state) => const PurchaseScreen(),
                          // pageBuilder: (context, state) => const MaterialPage(
                          //   child: PurchaseScreen(),
                          //   fullscreenDialog: true,
                          // ),
                          routes: [
                            GoRoute(
                              path: 'account',
                              builder: (context, state) =>
                                  const AccountScreen(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
    errorBuilder: (context, state) => const NotFoundScreen(),
  );
});
