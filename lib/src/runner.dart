import 'dart:async';
import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../flavors.dart';
import 'app.dart';
import 'exceptions/async_error_logger.dart';
import 'exceptions/error_logger.dart';
import 'features/admob/application/ad_helper.dart';
import 'features/admob/application/admob_service.dart';
import 'firebase_options.dart';
import 'firebase_options_dev.dart';
import 'localization/string_hardcoded.dart';

class AppRunner {
  static Future<void> run(Flavor flavor) async {
    late ErrorLogger errorLogger;
    FirebaseAnalytics? analytics;
    // * For more info on error handling, see:
    // * https://docs.flutter.dev/testing/errors
    await runZonedGuarded(() async {
      WidgetsFlutterBinding.ensureInitialized();
      // turn off the # in the URLs on the web
      GoRouter.setUrlPathStrategy(UrlPathStrategy.path);

      await Firebase.initializeApp(
        options: flavor == Flavor.PROD
            ? DefaultFirebaseOptions.currentPlatform
            : DefaultFirebaseOptionsDev.currentPlatform,
      );
      // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);

      if (kReleaseMode) {
        analytics = FirebaseAnalytics.instance;
        await analytics!.logAppOpen();
        await analytics!.logEvent(name: 'app_start');
        FlutterError.onError =
            FirebaseCrashlytics.instance.recordFlutterFatalError;
      }

      final appStartupContainer = ProviderContainer(
        observers: [AsyncErrorLogger()],
        overrides: [
          // !! This is setup Google Ads [ADType]
          // !! chnage ADType.real when release app in app market
          adTypeProvider.overrideWithProvider(Provider((ref) => ADType.sample)),
          flavorProvider.overrideWithProvider(Provider((ref) => flavor)),
        ],
      );
      errorLogger = appStartupContainer.read(errorLoggerProvider);
      // FirebaseCrashlytics.instance.crash();
      // FirebaseCrashlytics.instance.log('test crash');
      if (Platform.isAndroid) {
        appStartupContainer.read(admobServiceProvider);
      } else if (Platform.isMacOS) {
        // appStartupContainer.read(windowSizeProvider);
      }

      // * Entry point of the app
      runApp(UncontrolledProviderScope(
        container: appStartupContainer,
        child: const MyApp(),
      ));

      // * This code will present some error UI if any uncaught exception happens
      FlutterError.onError = (FlutterErrorDetails details) {
        FlutterError.presentError(details);
      };

      ErrorWidget.builder = (FlutterErrorDetails details) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.red,
            title: Text('An error occurred'.hardcoded),
          ),
          body: Center(child: Text(details.toString())),
        );
      };
    }, (Object error, StackTrace stack) {
      if (kReleaseMode) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      }
      errorLogger.logError(error, stack);
    });
  }
}
