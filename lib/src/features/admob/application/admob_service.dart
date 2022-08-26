// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/admob_repository.dart';
import 'ad_helper.dart';

class AdmobService {
  AdmobService(this.ref) {
    _init();
  }
  final Ref ref;

  Future<void> _init() async {
    final admobStatus = await _initAdmob();
    print(
        '_init AdmobService: ${admobStatus.adapterStatuses.values.first.state}');
    createInterstitialAd();
  }

  Future<InitializationStatus> _initAdmob() =>
      ref.read(admobRepositoryProvider).initGoogleMobileAds();

  String getAdsUnitId(ADFormat adFormat) {
    final adType = ref.read(adTypeProvider);
    return AdHelper.getAdsUnitId(adType, adFormat);
  }

  void createInterstitialAd() {
    print('createInterstitialAd: $createInterstitialAd');
    const maxFailedLoadAttempts = 3;
    final interstitialAd = ref.read(interstitialAdProvider);
    InterstitialAd.load(
        adUnitId: getAdsUnitId(ADFormat.interstitial),
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('$InterstitialAd loaded');
            ref.read(interstitialAdProvider.notifier).state = ad;
            ref.read(numInterstitialLoadAttemptsProvider.notifier).state = 0;
            interstitialAd?.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error.');
            ref.read(numInterstitialLoadAttemptsProvider.notifier).state += 1;
            ref.read(interstitialAdProvider.notifier).state = null;
            if (ref.read(numInterstitialLoadAttemptsProvider) <
                maxFailedLoadAttempts) {
              createInterstitialAd();
            }
          },
        ));
  }

  void showInterstitialAd() {
    print('showInterstitialAd 1: $showInterstitialAd');
    final interstitialAd = ref.read(interstitialAdProvider);
    print('showInterstitialAd 2: $showInterstitialAd');
    if (interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    interstitialAd.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        createInterstitialAd();
      },
      onAdImpression: (InterstitialAd ad) => print('$ad impression occurred.'),
    );
    interstitialAd.show();
    ref.read(interstitialAdProvider.notifier).state = null;
    ref.read(interstitialAdStateProvider.notifier).state = true;
  }
}

final admobServiceProvider = Provider<AdmobService>(AdmobService.new);

final interstitialAdStateProvider = StateProvider<bool>((ref) => false);
final interstitialAdProvider = StateProvider<InterstitialAd?>((ref) => null);
final numInterstitialLoadAttemptsProvider = StateProvider<int>((ref) => 0);

final adTypeProvider = Provider<ADType>((ref) => throw UnimplementedError());
