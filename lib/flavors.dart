enum Flavor {
  dev,
  prod,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return '[DEV]Bluetooth On my Body';
      case Flavor.prod:
        return 'Bluetooth On my Body';
      default:
        return 'title';
    }
  }
}
