import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'constants/resources.dart';
import 'constants/theme.dart';
import 'localization/string_hardcoded.dart';

final scaffoldKeyProvider = Provider<GlobalKey<ScaffoldMessengerState>>(
    (ref) => GlobalKey<ScaffoldMessengerState>());

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      routeInformationProvider: goRouter.routeInformationProvider,
      routeInformationParser: goRouter.routeInformationParser,
      routerDelegate: goRouter.routerDelegate,
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: ref.read(scaffoldKeyProvider),
      restorationScopeId: 'app',
      onGenerateTitle: (BuildContext context) =>
          'Bluetooth on my body'.hardcoded,
      themeMode: themeMode,
      // theme: flexThemeLightData,
      theme: lightTheme,
      // darkTheme: flexThemeDarkData,
      darkTheme: darkTheme,
    );
  }
}
