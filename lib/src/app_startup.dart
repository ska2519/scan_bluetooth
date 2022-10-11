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
import 'features/in_app_purchase/application/purchases_service.dart';
import 'firebase_options.dart';
import 'firebase_options_dev.dart';
import 'localization/string_hardcoded.dart';
import 'utils/window_size_provider.dart';

bool shouldUseFirestoreEmulator = false;

class AppStartup {
  static Future<void> run(Flavor flavor) async {
    WidgetsFlutterBinding.ensureInitialized();
    GoRouter.setUrlPathStrategy(UrlPathStrategy.path);

    await Firebase.initializeApp(
      options: flavor == Flavor.PROD
          ? DefaultFirebaseOptions.currentPlatform
          : DefaultFirebaseOptionsDev.currentPlatform,
    );
    final analytics = kReleaseMode ? FirebaseAnalytics.instance : null;
    final crashlytics = kReleaseMode ? FirebaseCrashlytics.instance : null;

    if (shouldUseFirestoreEmulator) {
      // FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
      // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
    }

    logger.i(
        'AppStartup kReleaseMode: $kReleaseMode/ analytics: $analytics/ crashlytics: $crashlytics');

    // * This code will present some error UI if any uncaught exception happens
    FlutterError.onError = (FlutterErrorDetails details) {
      // * custom error handler in order to see the logs in the console as well.
      if (kReleaseMode) {
        FlutterError.onError = crashlytics!.recordFlutterFatalError;
      } else {
        FlutterError.presentError(details);
      }
    };

    PlatformDispatcher.instance.onError = (error, stack) {
      if (kReleaseMode) {
        crashlytics!.recordError(error, stack, fatal: true);
      }
      logger.e(error, stack);
      return true;
    };

    if (kReleaseMode) {
      await analytics!.logAppOpen();
      await analytics.logEvent(name: 'app_start');
    }

    final appStartupContainer = ProviderContainer(
      observers: [AsyncErrorLogger()],
      overrides: [
        // !! This is setup Google Ads [ADType]
        // !! chnage ADType.real when release app in app market
        adTypeProvider.overrideWithProvider(Provider((ref) => ADType.real)),
        flavorProvider.overrideWithProvider(Provider((ref) => flavor)),
      ],
    );
    appStartupContainer.read(loggerProvider);

    // FirebaseCrashlytics.instance.crash();
    // FirebaseCrashlytics.instance.log('test crash');
    if (Platform.isAndroid || Platform.isIOS) {
      appStartupContainer.read(purchasesServiceProvider);
      appStartupContainer.read(admobServiceProvider);
    } else if (Platform.isMacOS) {
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
