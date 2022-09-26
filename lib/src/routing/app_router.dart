import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../features/authentication/data/auth_repository.dart';
import '../features/authentication/presentation/sign_in/email_password_sign_in_screen.dart';
import '../features/authentication/presentation/sign_in/email_password_sign_in_state.dart';
import '../features/in_app_purchase/presentation/purchase_screen.dart';
import '../home_screen.dart';
import 'not_found_screen.dart';

enum AppRoute {
  home,
  bluetooth,
  leaveReview,
  cart,
  checkout,
  orders,
  purchase,
  account,
  signIn,
}

final goRouterProvider = Provider<GoRouter>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return GoRouter(
    initialLocation: '/',
    // debugLogDiagnostics: false,
    redirect: (state) {
      final isLoggedIn = authRepository.currentUser != null &&
          !authRepository.currentUser!.isAnonymous!;
      if (isLoggedIn) {
        // if (state.location == '/signIn') {
        //   return '/';
        // }
        // } else {
        //   if (state.location == '/account' || state.location == '/orders') {
        //     return '/';
        //   }
      }
      return null;
    },
    refreshListenable: GoRouterRefreshStream(authRepository.authStateChanges()),
    routes: [
      GoRoute(
        path: '/',
        name: AppRoute.home.name,
        builder: (context, state) => const HomeScreen(),
        routes: [
          GoRoute(
            path: 'signIn',
            name: AppRoute.signIn.name,
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              fullscreenDialog: true,
              child: const EmailPasswordSignInScreen(
                formType: EmailPasswordSignInFormType.signIn,
              ),
            ),
          ),
          GoRoute(
            path: 'purchase',
            name: AppRoute.purchase.name,
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              fullscreenDialog: true,
              child: const PurchaseScreen(),
            ),
          ),
          // GoRoute(
          //   path: 'product/:id',
          //   name: AppRoute.bluetooth.name,
          //   builder: (context, state) {
          //     final productId = state.params['id']!;
          //     return BluetoothScreen(deviceId: productId);
          //   },
          // ),
          //   routes: [
          //     GoRoute(
          //       path: 'review',
          //       name: AppRoute.leaveReview.name,
          //       pageBuilder: (context, state) {
          //         final productId = state.params['id']!;
          //         return MaterialPage(
          //           key: state.pageKey,
          //           fullscreenDialog: true,
          //           child: LeaveReviewScreen(productId: productId),
          //         );
          //       },
          //     ),
          //   ],
          // ),
          // GoRoute(
          //   path: 'cart',
          //   name: AppRoute.cart.name,
          //   pageBuilder: (context, state) => MaterialPage(
          //     key: state.pageKey,
          //     fullscreenDialog: true,
          //     child: const ShoppingCartScreen(),
          //   ),
          //   routes: [
          //     GoRoute(
          //       path: 'checkout',
          //       name: AppRoute.checkout.name,
          //       pageBuilder: (context, state) => MaterialPage(
          //         key: ValueKey(state.location),
          //         fullscreenDialog: true,
          //         child: const CheckoutScreen(),
          //       ),
          //     ),
          //   ],
          // ),
          // GoRoute(
          //   path: 'orders',
          //   name: AppRoute.orders.name,
          //   pageBuilder: (context, state) => MaterialPage(
          //     key: state.pageKey,
          //     fullscreenDialog: true,
          //     child: const OrdersListScreen(),
          //   ),
          // ),
          // GoRoute(
          //   path: 'account',
          //   name: AppRoute.account.name,
          //   pageBuilder: (context, state) => MaterialPage(
          //     key: state.pageKey,
          //     fullscreenDialog: true,
          //     child: const AccountScreen(),
          //   ),
          // ),
        ],
      ),
    ],
    errorBuilder: (context, state) => const NotFoundScreen(),
  );
});
