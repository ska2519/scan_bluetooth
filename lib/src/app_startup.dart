import 'dart:async';
import 'dart:io';

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
import 'features/in_app_purchase/application/purchases_service.dart';
import 'features/presence_user/application/presence_user_service.dart';
import 'firebase_options.dart';
import 'firebase_options_dev.dart';
import 'localization/string_hardcoded.dart';
import 'utils/window_size_provider.dart';

bool shouldUseFirestoreEmulator = false;

final sharedPreferencesProvider =
    Provider<SharedPreferences>((ref) => throw UnimplementedError());
final packageInfoProvider =
    Provider<PackageInfo>((ref) => throw UnimplementedError());

class AppStartup {
  static Future<void> run(Flavor flavor) async {
    if (kIsWeb) usePathUrlStrategy();
    WidgetsFlutterBinding.ensureInitialized();
    // logger.i('Firebase.initializeApp kIsWeb: $kIsWeb /flavor: $flavor');
    // if (Firebase.apps.isNotEmpty) {
    try {
      await Firebase.initializeApp(
        options: flavor == Flavor.PROD
            ? DefaultFirebaseOptions.currentPlatform
            : DefaultFirebaseOptionsDev.currentPlatform,
      );
    } catch (e) {
      logger.i('Firebase initializeApp e: $e');
    }

    // }

    logger.i('after await Firebase.initializeApp: ');
    final analytics = kReleaseMode ? FirebaseAnalytics.instance : null;
    final crashlytics =
        kReleaseMode && !kIsWeb ? FirebaseCrashlytics.instance : null;

    if (shouldUseFirestoreEmulator) {
      // FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
      // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
    }

    logger.i(
        'AppStartup kReleaseMode: $kReleaseMode/ analytics: $analytics/ crashlytics: $crashlytics');

    // * This code will present some error UI if any uncaught exception happens
    FlutterError.onError = (FlutterErrorDetails details) {
      // * custom error handler in order to see the logs in the console as well.
      if (kReleaseMode && !kIsWeb) {
        FlutterError.onError = crashlytics!.recordFlutterFatalError;
      } else {
        FlutterError.presentError(details);
      }
    };

    PlatformDispatcher.instance.onError = (error, stack) {
      if (kReleaseMode && !kIsWeb) {
        crashlytics!.recordError(error, stack, fatal: true);
      }
      logger.e(error);
      return true;
    };

    if (kReleaseMode) {
      await analytics!.logAppOpen();
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
        // sharedPreferencesProvider.overrideWithValue(sharedPreferences),
        packageInfoProvider.overrideWithValue(packageInfo),
      ],
    );
    appStartupContainer.read(loggerProvider);

    if (Platform.isAndroid || Platform.isIOS) {
      appStartupContainer.read(presenceUserServiceProvider);
      appStartupContainer.read(purchasesServiceProvider);
      appStartupContainer.read(admobServiceProvider);
    } else if (Platform.isMacOS) {
      appStartupContainer.read(setWindowSizeProvider);
    }
    logger.i('appStartupContainer state: $appStartupContainer');
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
