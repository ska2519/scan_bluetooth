import 'dart:io';

enum AdType { test, real }

class AdHelper {
  // static String get bannerAdUnitId {
  //   if (Platform.isAndroid) {
  //     return 'ca-app-pub-3940256099942544/6300978111';
  //   } else if (Platform.isIOS) {
  //     return 'ca-app-pub-3940256099942544/2934735716';
  //   }
  //   throw UnsupportedError('Unsupported platform');
  // }

  static String nativeAdUnitId(AdType? adType) {
    if (Platform.isAndroid) {
      return adType == AdType.real
          ? 'ca-app-pub-2418665308297154/3742117811'
          : 'ca-app-pub-3940256099942544/2247696110';
    } else if (Platform.isIOS) {
      return adType == AdType.real
          ? 'ca-app-pub-2418665308297154~2401115988'
          : 'ca-app-pub-3940256099942544/3986624511';
    }
    throw UnsupportedError('Unsupported platform');
  }
}
