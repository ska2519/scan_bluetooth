import 'constants/resources.dart';
import 'constants/theme.dart';
import 'features/permission/application/permission_service.dart';

final scaffoldMessengerKeyProvider =
    Provider((ref) => GlobalKey<ScaffoldMessengerState>());

class MyApp extends StatefulHookConsumerWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    logger.i('didChangeAppLifecycleState state: $state');
    if (state == AppLifecycleState.detached) return;
    final isBackgroud = state == AppLifecycleState.paused;
    logger.i('isBackgroud: $isBackgroud');
    if (!isBackgroud) {
      logger.i('Platform: ${Platform.operatingSystem}');
      if (Platform.isAndroid) {
        ref.refresh(
            requestPermissionListProvider(defaultBluetoothPermissionList));
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final goRouter = ref.watch(goRouterProvider);
    final themeMode = ref.watch(themeModeProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: goRouter,
      scaffoldMessengerKey: ref.read(scaffoldMessengerKeyProvider),
      restorationScopeId: 'app',
      onGenerateTitle: (BuildContext context) => 'BOMB'.hardcoded,
      themeMode: themeMode,
      // theme: shrineTheme,
      theme: lightTheme,
      darkTheme: darkTheme,
    );
  }
}
