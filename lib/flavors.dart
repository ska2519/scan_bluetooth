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
