// ignore_for_file: constant_identifier_names

import 'package:hooks_riverpod/hooks_riverpod.dart';

final flavorProvider = Provider<Flavor>((ref) => throw UnimplementedError());

enum Flavor {
  DEV,
  PROD,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.DEV:
        return 'DEV_BOMB';
      case Flavor.PROD:
        return 'BOMB';
      default:
        return 'title';
    }
  }
}
