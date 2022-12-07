// ignore_for_file: unused_shown_name, depend_on_referenced_packages

import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart'
    show PlatformDispatcher, kIsWeb, kReleaseMode;
import 'package:flutter/material.dart';

import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../flavors.dart';
import 'app.dart';
import 'exceptions/async_error_logger.dart';
import 'exceptions/error_logger.dart';
import 'features/admob/application/ad_helper.dart';
import 'features/admob/application/admob_service.dart';
import 'features/firebase/analytics.dart';
import 'features/firebase/remote_config.dart';
import 'features/in_app_purchase/application/purchases_service.dart';
import 'features/presence_user/application/presence_user_service.dart';
import 'firebase_options.dart';
import 'firebase_options_dev.dart';
import 'localization/string_hardcoded.dart';
import 'utils/window_size_provider.dart';

bool shouldUseFirestoreEmulator = false;
final flavorProvider = Provider<Flavor>((ref) => throw UnimplementedError());
final sharedPreferencesProvider =
    Provider<SharedPreferences>((ref) => throw UnimplementedError());
final packageInfoProvider =
    Provider<PackageInfo>((ref) => throw UnimplementedError());

class AppStartup {
  static Future<void> run(Flavor flavor) async {
    if (kIsWeb) usePathUrlStrategy();
    WidgetsFlutterBinding.ensureInitialized();
    try {
      await Firebase.initializeApp(
        options: flavor == Flavor.PROD
            ? DefaultFirebaseOptions.currentPlatform
            : DefaultFirebaseOptionsDev.currentPlatform,
      );
    } catch (e) {
      logger.e(
          'Firebase.initializeApp [A Firebase App named "[DEFAULT]" already exists] error try catch e: $e');
    }

    final analytics = kReleaseMode ? FirebaseAnalytics.instance : null;
    final crashlytics =
        kReleaseMode && !kIsWeb ? FirebaseCrashlytics.instance : null;

    if (shouldUseFirestoreEmulator) {
      // FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
      // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
    }

    //* Report uncaught exceptions
    //* https://firebase.google.com/docs/crashlytics/customize-crash-reports?authuser=0&platform=flutter#report-uncaught-exceptions
    // * custom error handler in order to see the logs in the console as well.
    FlutterError.onError = (FlutterErrorDetails details) {
      if (kReleaseMode && !kIsWeb && crashlytics != null) {
        FlutterError.onError = crashlytics.recordFlutterFatalError;
      } else {
        FlutterError.presentError(details);
      }
    };

    PlatformDispatcher.instance.onError = (error, stack) {
      if (kReleaseMode && !kIsWeb && crashlytics != null) {
        crashlytics.recordError(error, stack, fatal: true);
      } else {
        logger.e('PlatformDispatcher e: $error, stack: $stack');
      }
      return true;
    };

    //* Errors outside of Flutter
    //* https://firebase.google.com/docs/crashlytics/customize-crash-reports?authuser=0&platform=flutter#errors-outside-flutter
    Isolate.current.addErrorListener(
      RawReceivePort((pair) async {
        if (kReleaseMode && !kIsWeb && crashlytics != null) {
          final List<dynamic> errorAndStacktrace = pair;
          await crashlytics.recordError(
            errorAndStacktrace.first,
            errorAndStacktrace.last,
            fatal: true,
          );
        }
      }).sendPort,
    );

    if (kReleaseMode && analytics != null) {
      await analytics.logAppOpen();
      await analytics.logEvent(name: 'app_start');
    }
    const adType = kReleaseMode ? ADType.real : ADType.sample;
    // final sharedPreferences = await SharedPreferences.getInstance();
    final packageInfo = await PackageInfo.fromPlatform();

    final appStartupContainer = ProviderContainer(
      observers: [AsyncErrorLogger()],
      overrides: [
        flavorProvider.overrideWithValue(flavor),
        adTypeProvider.overrideWithValue(adType),
        packageInfoProvider.overrideWithValue(packageInfo),
        // sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
    );
    appStartupContainer.read(loggerProvider);

    await appStartupContainer.read(remoteConfigProvider).init();
    final disabledApp = appStartupContainer.read(disabledAppProvider);
    if (disabledApp) {
      if (analytics != null) {
        await analytics.logEvent(
          name: 'disabledApp',
          parameters: analyticsLogParameters(appStartupContainer),
        );
      }
    } else {
      if (Platform.isAndroid) {
        appStartupContainer.read(admobServiceProvider);
      }
      if (Platform.isAndroid || Platform.isIOS) {
        appStartupContainer.read(presenceUserServiceProvider);
        appStartupContainer.read(purchasesServiceProvider);
      }
    }
    if (Platform.isMacOS) {
      appStartupContainer.read(setWindowSizeProvider);
    }

    // * Entry point of the app
    runApp(UncontrolledProviderScope(
      container: appStartupContainer,
      child: const MyApp(),
    ));

    ErrorWidget.builder = (FlutterErrorDetails details) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text('An error occurred'.hardcoded),
        ),
        body: Center(
          child: Text(details.toString()),
        ),
      );
    };
  }
}
