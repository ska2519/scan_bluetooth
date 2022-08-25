import 'dart:io';

enum ADType { sample, real }

enum ADFormat {
  appOpen,
  banner,
  interstitial,
  interstitialVideo,
  rewarded,
  nativeAdvanced,
  nativeAdvancedVideo,
}

enum AndroidTestADUnitId {
  appOpen('ca-app-pub-3940256099942544/3419835294'),
  banner('ca-app-pub-3940256099942544/6300978111'),
  interstitial('ca-app-pub-3940256099942544/1033173712'),
  interstitialVideo('ca-app-pub-3940256099942544/8691691433'),
  rewarded('ca-app-pub-3940256099942544/5224354917'),
  nativeAdvanced('ca-app-pub-3940256099942544/2247696110'),
  nativeAdvancedVideo('ca-app-pub-3940256099942544/1044960115');

  const AndroidTestADUnitId(this.id);
  final String id;
}

enum AndroidRealADUnitId {
  banner('ca-app-pub-2418665308297154/1307526167'),
  interstitial('ca-app-pub-2418665308297154/2536663570'),
  nativeAdvanced('ca-app-pub-2418665308297154/3742117811');

  const AndroidRealADUnitId(this.id);
  final String id;
}

enum IosTestADUnitId {
  appOpen('ca-app-pub-3940256099942544/5662855259'),
  banner('ca-app-pub-3940256099942544/2934735716'),
  interstitial('ca-app-pub-3940256099942544/4411468910'),
  interstitialVideo('ca-app-pub-3940256099942544/5135589807'),
  rewarded('ca-app-pub-3940256099942544/1712485313'),
  rewardedInterstitial('ca-app-pub-3940256099942544/6978759866'),
  nativeAdvanced('ca-app-pub-3940256099942544/3986624511'),
  nativeAdvancedVideo('ca-app-pub-3940256099942544/2521693316');

  const IosTestADUnitId(this.id);
  final String id;
}

enum IosRealADUnitId {
  banner('ca-app-pub-2418665308297154/6148789301'),
  interstitial('ca-app-pub-2418665308297154/2508743415'),
  nativeAdvanced('ca-app-pub-2418665308297154/6068898259');

  const IosRealADUnitId(this.id);
  final String id;
}

class AdHelper {
  static String getAdsUnitId(
    ADType adType,
    ADFormat adFormat,
  ) {
    if (Platform.isAndroid) {
      switch (adType) {
        case ADType.sample:
          switch (adFormat) {
            case ADFormat.appOpen:
              return AndroidTestADUnitId.appOpen.id;
            case ADFormat.banner:
              return AndroidTestADUnitId.banner.id;
            case ADFormat.interstitial:
              return AndroidTestADUnitId.interstitial.id;
            case ADFormat.interstitialVideo:
              return AndroidTestADUnitId.interstitialVideo.id;
            case ADFormat.rewarded:
              return AndroidTestADUnitId.rewarded.id;
            case ADFormat.nativeAdvanced:
              return AndroidTestADUnitId.nativeAdvanced.id;
            case ADFormat.nativeAdvancedVideo:
              return AndroidTestADUnitId.nativeAdvancedVideo.id;
          }
        case ADType.real:
          switch (adFormat) {
            case ADFormat.interstitial:
              return AndroidRealADUnitId.interstitial.id;
            case ADFormat.nativeAdvanced:
              return AndroidRealADUnitId.nativeAdvanced.id;
          }
      }
    } else if (Platform.isIOS) {
      switch (adType) {
        case ADType.sample:
          switch (adFormat) {
            case ADFormat.appOpen:
              return IosTestADUnitId.appOpen.id;
            case ADFormat.banner:
              return IosTestADUnitId.banner.id;
            case ADFormat.interstitial:
              return IosTestADUnitId.interstitial.id;
            case ADFormat.interstitialVideo:
              return IosTestADUnitId.interstitialVideo.id;
            case ADFormat.rewarded:
              return IosTestADUnitId.rewarded.id;
            case ADFormat.nativeAdvanced:
              return IosTestADUnitId.nativeAdvanced.id;
            case ADFormat.nativeAdvancedVideo:
              return IosTestADUnitId.nativeAdvancedVideo.id;
          }
        case ADType.real:
          switch (adFormat) {
            case ADFormat.interstitial:
              return IosRealADUnitId.interstitial.id;
            case ADFormat.nativeAdvanced:
              return IosRealADUnitId.nativeAdvanced.id;
          }
      }
    }
    throw UnsupportedError('Unsupported platform');
  }
}
