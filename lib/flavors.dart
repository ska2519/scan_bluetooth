// ignore_for_file: constant_identifier_names

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
        return '[DEV]Bluetooth On my Body';
      case Flavor.PROD:
        return 'Bluetooth On my Body';
      default:
        return 'title';
    }
  }
}
