import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'firebase_options.dart';
import 'firebase_options_dev.dart';
import 'flavors.dart';
import 'src/app.dart';
import 'src/localization/string_hardcoded.dart';

class AppRunner {
  static Future<void> run(Flavor flavor) async {
    // * For more info on error handling, see:
    // * https://docs.flutter.dev/testing/errors
    await runZonedGuarded(() async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
        options: flavor == Flavor.PROD
            ? DefaultFirebaseOptions.currentPlatform
            : DefaultFirebaseOptionsDev.currentPlatform,
      );

      final container = ProviderContainer();
      // container.read(dynamicLinksServiceProvider);
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
      debugPrint(error.toString());
    });
  }
}
