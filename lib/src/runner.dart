import 'dart:async';
import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../flavors.dart';
import 'app.dart';
import 'features/admob/application/admob_service.dart';
import 'firebase_options.dart';
import 'firebase_options_dev.dart';
import 'localization/string_hardcoded.dart';

class AppRunner {
  static Future<void> run(Flavor flavor) async {
    FirebaseAnalytics analytics;
    // * For more info on error handling, see:
    // * https://docs.flutter.dev/testing/errors
    await runZonedGuarded(() async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
        options: flavor == Flavor.PROD
            ? DefaultFirebaseOptions.currentPlatform
            : DefaultFirebaseOptionsDev.currentPlatform,
      );
      analytics = FirebaseAnalytics.instance;
      await analytics.logAppOpen();
      await analytics.logEvent(name: 'app_start');
      FlutterError.onError =
          FirebaseCrashlytics.instance.recordFlutterFatalError;
      // FirebaseCrashlytics.instance.crash();
      final container = ProviderContainer();
      if (Platform.isAndroid || Platform.isIOS) {
        container.read(admobServiceProvider);
      }
      // turn off the # in the URLs on the web
      GoRouter.setUrlPathStrategy(UrlPathStrategy.path);
      // * Entry point of the app
      runApp(UncontrolledProviderScope(
        container: container,
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
      // * Log any errors to console
      debugPrint('debugPrint error: ${error.toString()}');
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    });
  }
}
