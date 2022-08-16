import 'dart:io';

class AdHelper {
  // static String get bannerAdUnitId {
  //   if (Platform.isAndroid) {
  //     return 'ca-app-pub-3940256099942544/6300978111';
  //   } else if (Platform.isIOS) {
  //     return 'ca-app-pub-3940256099942544/2934735716';
  //   }
  //   throw UnsupportedError('Unsupported platform');
  // }

  static String get nativeAdUnitId {
    if (Platform.isAndroid) {
      // return 'ca-app-pub-2418665308297154/3742117811'; // real id
      return 'ca-app-pub-3940256099942544/2247696110'; //test id
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/3986624511';
    }
    throw UnsupportedError('Unsupported platform');
  }
}
