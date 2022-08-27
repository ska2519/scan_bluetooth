// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../constants/resources.dart';
import '../data/admob_repository.dart';
import 'ad_helper.dart';

class AdmobService {
  AdmobService(this.ref) {
    _init();
  }
  final Ref ref;

  Future<void> _init() async {
    // const testDeviceIds = ['50700EE678D6F6995AD82C2CE5545365'];
    // var configuration = RequestConfiguration(testDeviceIds: testDeviceIds);
    // await MobileAds.instance.updateRequestConfiguration(configuration);
    final admobStatus = await _initAdmob();
    print(
        '_init AdmobService: ${admobStatus.adapterStatuses.values.first.state}');

    if (Platform.isAndroid) {
      createNativeAd();
      createInterstitialAd();
    }
  }

  Future<InitializationStatus> _initAdmob() =>
      ref.read(admobRepositoryProvider).initGoogleMobileAds();

  String getAdsUnitId(ADFormat adFormat) {
    final adType = ref.read(adTypeProvider);
    return AdHelper.getAdsUnitId(adType, adFormat);
  }

  void createNativeAd() {
    NativeAd(
      adUnitId: getAdsUnitId(ADFormat.nativeAdvanced),
      factoryId: 'listTile',
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (ad) => ref
            .read(nativeAdProvider(null).notifier)
            .update((state) => ad as NativeAd),
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          print('Ad load failed (code=${error.code} message=${error.message})');
        },
      ),
    ).load();
  }

  void createInterstitialAd() {
    const maxFailedLoadAttempts = 3;
    final interstitialAd = ref.read(interstitialAdProvider);
    InterstitialAd.load(
        adUnitId: getAdsUnitId(ADFormat.interstitial),
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('$InterstitialAd loaded');
            ref.read(interstitialAdProvider.notifier).update((state) => ad);
            ref
                .read(numInterstitialLoadAttemptsProvider.notifier)
                .update((state) => 0);
            interstitialAd?.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error.');
            ref
                .read(numInterstitialLoadAttemptsProvider.notifier)
                .update((state) => state + 1);
            ref.read(interstitialAdProvider.notifier).update((state) => null);
            if (ref.read(numInterstitialLoadAttemptsProvider) <
                maxFailedLoadAttempts) {
              createInterstitialAd();
            }
          },
        ));
  }

  void showInterstitialAd() {
    final interstitialAd = ref.read(interstitialAdProvider);
    if (interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    interstitialAd.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        //TODO: add Firebase analytics Logs
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
    ref.read(interstitialAdProvider.notifier).update((state) => null);
    ref.read(interstitialAdStateProvider.notifier).update((state) => true);
  }
}

final adTypeProvider = Provider<ADType>((ref) => throw UnimplementedError());
final admobServiceProvider = Provider<AdmobService>(AdmobService.new);

// final nativeAdProvider = StateProvider<NativeAd?>((ref) => null);
final nativeAdProvider =
    StateProvider.family.autoDispose<NativeAd?, Key?>((ref, key) => null);

final interstitialAdProvider = StateProvider<InterstitialAd?>((ref) => null);

final interstitialAdStateProvider = StateProvider<bool>((ref) => false);
final numInterstitialLoadAttemptsProvider = StateProvider<int>((ref) => 0);
