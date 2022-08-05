import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'constants/theme.dart';
import 'localization/string_hardcoded.dart';
import 'routing/app_router.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);
    return MaterialApp.router(
      routeInformationProvider: goRouter.routeInformationProvider,
      routeInformationParser: goRouter.routeInformationParser,
      routerDelegate: goRouter.routerDelegate,
      debugShowCheckedModeBanner: false,
      restorationScopeId: 'app',
      onGenerateTitle: (BuildContext context) =>
          'Bluetooth on my body'.hardcoded,
      theme: FlexThemeData.light(
        extensions: <ThemeExtension<dynamic>>{
          lightBrandTheme,
        },
        // primarySwatch: Colors.grey,
        // appBarTheme: const AppBarTheme(
        //   backgroundColor: Colors.black87,
        //   foregroundColor: Colors.white,
        //   elevation: 0,
        // ),
        // elevatedButtonTheme: ElevatedButtonThemeData(
        //   style: ElevatedButton.styleFrom(
        //     primary: Colors.black, // background (button) color
        //     onPrimary: Colors.white, // foreground (text) color
        //   ),
        // ),
      ),
    );
  }
}
