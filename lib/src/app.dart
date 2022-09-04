import 'constants/resources.dart';
import 'constants/theme.dart';

final scaffoldKeyProvider = Provider<GlobalKey<ScaffoldMessengerState>>(
    (ref) => GlobalKey<ScaffoldMessengerState>());

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);
    final themeMode = ref.watch(themeModeProvider);
    return MaterialApp.router(
      routeInformationProvider: goRouter.routeInformationProvider,
      routeInformationParser: goRouter.routeInformationParser,
      routerDelegate: goRouter.routerDelegate,
      scaffoldMessengerKey: ref.read(scaffoldKeyProvider),
      restorationScopeId: 'app',
      onGenerateTitle: (BuildContext context) =>
          'BOMB'.hardcoded,
      themeMode: themeMode,
      // theme: shrineTheme,
      theme: lightTheme,
      darkTheme: darkTheme,
    );
  }
}
