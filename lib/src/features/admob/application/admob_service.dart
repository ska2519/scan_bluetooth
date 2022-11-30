// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../constants/resources.dart';
import '../../firebase/remote_config.dart';
import '../data/admob_repository.dart';
import 'ad_helper.dart';

final admobServiceProvider = Provider<AdmobService>((ref) {
  final disableInterstitialAd = ref.watch(disableInterstitialAdProvider);
  return AdmobService(ref, disableInterstitialAd);
});
final adTypeProvider = Provider<ADType>((ref) => throw UnimplementedError());

final interstitialAdProvider = StateProvider<InterstitialAd?>((ref) => null);

class AdmobService {
  AdmobService(
    this.ref,
    this.disableInterstitialAd,
  ) {
    _init();
  }
  final Ref ref;
  final bool disableInterstitialAd;
  int _numInterstitialLoadAttempts = 0;

  Future<void> _init() async {
    try {
      final admobStatus = await _initAdmob();
      logger.i('AdmobService _init: ${admobStatus.adapterStatuses.toString()}');
      disableInterstitialAd
          ? ref.read(interstitialAdProvider.notifier).state = null
          : _createInterstitialAd();
    } catch (e) {
      logger.e('AdmobService _init e: $e');
    }
  }

  Future<InitializationStatus> _initAdmob() =>
      ref.read(admobRepositoryProvider).initGoogleMobileAds();

  String getAdsUnitId(ADFormat adFormat) {
    final adType = ref.read(adTypeProvider);
    return AdHelper.getAdsUnitId(adType, adFormat);
  }

  void _createInterstitialAd() {
    logger.i('AdmobService _createInterstitialAd()');
    const maxFailedLoadAttempts = 3;
    final interstitialAd = ref.read(interstitialAdProvider);
    if (interstitialAd == null) {
      InterstitialAd.load(
          adUnitId: getAdsUnitId(ADFormat.interstitial),
          request: const AdRequest(),
          adLoadCallback: InterstitialAdLoadCallback(
            onAdLoaded: (InterstitialAd ad) {
              logger.i('AdmobService InterstitialAd loaded');
              ref.read(interstitialAdProvider.notifier).update((state) => ad);
              _numInterstitialLoadAttempts = 0;
              ref.read(interstitialAdProvider)?.setImmersiveMode(true);
            },
            onAdFailedToLoad: (LoadAdError error) {
              logger.i('AdmobService InterstitialAd failed to load: $error.');
              _numInterstitialLoadAttempts += 1;
              ref.read(interstitialAdProvider.notifier).update((state) => null);
              if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
                _createInterstitialAd();
              }
            },
          ));
    }
  }

  void showInterstitialAd() {
    final interstitialAd = ref.read(interstitialAdProvider);
    if (interstitialAd == null) {
      logger.i(
          'AdmobService Warning: attempt to show interstitial before loaded.');
      return;
    }
    interstitialAd.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          logger.i('AdmobService ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        //TODO: add Firebase analytics Logs
        logger.i('AdmobService $ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        logger.i('AdmobService $ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createInterstitialAd();
      },
      onAdImpression: (InterstitialAd ad) =>
          logger.i('AdmobService $ad impression occurred.'),
    );
    interstitialAd.show();
    ref.read(interstitialAdProvider.notifier).state = null;
  }
}
