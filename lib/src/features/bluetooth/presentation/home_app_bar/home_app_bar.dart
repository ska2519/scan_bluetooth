import 'dart:ui';

import '../../../../constants/resources.dart';
import '../../../authentication/data/auth_repository.dart';
import '../../application/bluetooth_service.dart';

/// Custom [AppBar] widget that is reused by the [ProductsListScreen] and
/// [ProductScreen].
/// It shows the following actions, depending on the application state:
/// - [ShoppingCartIcon]
/// - Orders button
/// - Account or Sign-in button
class HomeAppBar extends HookConsumerWidget with PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateChangesProvider).value;
    // * This widget is responsive.
    // * On large screen sizes, it shows all the actions in the app bar.
    // * On small screen sizes, it shows only the shopping cart icon and a
    // * [MoreMenuButton].
    // ! MediaQuery is used on the assumption that the widget takes up the full
    // ! width of the screen. If that's not the case, LayoutBuilder should be
    // ! used instead.
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < Breakpoint.tablet) {
      return AppBar(
        title: const BluetoothCountInfo(),
        actions: const [
          // const ShoppingCartIcon(),
          // MoreMenuButton(user: user),
        ],
      );
    } else {
      return AppBar(
        title: const BluetoothCountInfo(),
        actions: const [
          // const ShoppingCartIcon(),
          // if (user != null) ...[
          //   ActionTextButton(
          //     key: MoreMenuButton.ordersKey,
          //     text: 'Orders'.hardcoded,
          //     onPressed: () => context.pushNamed(AppRoute.orders.name),
          //   ),
          //   ActionTextButton(
          //     key: MoreMenuButton.accountKey,
          //     text: 'Account'.hardcoded,
          //     onPressed: () => context.pushNamed(AppRoute.account.name),
          //   ),
          // ] else
          //   ActionTextButton(
          //     key: MoreMenuButton.signInKey,
          //     text: 'Sign In'.hardcoded,
          //     onPressed: () => context.pushNamed(AppRoute.signIn.name),
          //   )
        ],
      );
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}

class BluetoothCountInfo extends ConsumerWidget {
  const BluetoothCountInfo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bluetoothList = ref.watch(bluetoothListProvider);
    final emptyNameBtsCount = ref.watch(emptyNameBTCountProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Text(
        //   '💣',
        //   style: Theme.of(context).textTheme.titleLarge!.copyWith(
        //         letterSpacing: -0.9,
        //         fontFeatures: [const FontFeature.tabularFigures()],
        //         height: 1.1,
        //       ),
        // ),

        Text(
          '❓ $emptyNameBtsCount'.hardcoded,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            letterSpacing: -1,
            fontFeatures: [const FontFeature.tabularFigures()],
          ),
        ),
        Text(
          ' / ${bluetoothList.length}'.hardcoded,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            letterSpacing: -1,
            fontFeatures: [const FontFeature.tabularFigures()],
          ),
        ),
      ],
    );
  }
}
