// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../constants/resources.dart';
import '../../../exceptions/error_logger.dart';
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
    logger.i(
        'AdmobService _init: ${admobStatus.adapterStatuses.values.first.state}');

    if (Platform.isAndroid || Platform.isIOS) {
      _createNativeAd();
      _createInterstitialAd();
    }
  }

  Future<InitializationStatus> _initAdmob() =>
      ref.read(admobRepositoryProvider).initGoogleMobileAds();

  String getAdsUnitId(ADFormat adFormat) {
    final adType = ref.read(adTypeProvider);
    return AdHelper.getAdsUnitId(adType, adFormat);
  }

  void _createNativeAd() {
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
          logger.i(
              'Ad load failed (code=${error.code} message=${error.message})');
        },
      ),
    ).load();
  }

  void _createInterstitialAd() {
    const maxFailedLoadAttempts = 3;
    final interstitialAd = ref.read(interstitialAdProvider);
    InterstitialAd.load(
        adUnitId: getAdsUnitId(ADFormat.interstitial),
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            logger.i('InterstitialAd loaded');
            ref.read(interstitialAdProvider.notifier).update((state) => ad);
            ref
                .read(numInterstitialLoadAttemptsProvider.notifier)
                .update((state) => 0);
            interstitialAd?.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            logger.i('InterstitialAd failed to load: $error.');
            ref
                .read(numInterstitialLoadAttemptsProvider.notifier)
                .update((state) => state + 1);
            ref.read(interstitialAdProvider.notifier).update((state) => null);
            if (ref.read(numInterstitialLoadAttemptsProvider) <
                maxFailedLoadAttempts) {
              _createInterstitialAd();
            }
          },
        ));
  }

  void showInterstitialAd() {
    final interstitialAd = ref.read(interstitialAdProvider);
    if (interstitialAd == null) {
      logger.i('Warning: attempt to show interstitial before loaded.');
      return;
    }
    interstitialAd.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          logger.i('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        //TODO: add Firebase analytics Logs
        logger.i('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        logger.i('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createInterstitialAd();
      },
      onAdImpression: (InterstitialAd ad) =>
          logger.i('$ad impression occurred.'),
    );
    interstitialAd.show();
    ref.read(interstitialAdProvider.notifier).update((state) => null);
    ref.read(interstitialAdStateProvider.notifier).update((state) => true);
  }
}

final adTypeProvider = Provider<ADType>((ref) => throw UnimplementedError());
final admobServiceProvider = Provider<AdmobService>(AdmobService.new);

final nativeAdProvider =
    StateProvider.family<NativeAd?, Key?>((ref, key) => null);

final nativeAdStateProvider = StateProvider.autoDispose<bool>((ref) => false);

final interstitialAdProvider = StateProvider<InterstitialAd?>((ref) => null);

final interstitialAdStateProvider =
    StateProvider.autoDispose<bool>((ref) => false);

final numInterstitialLoadAttemptsProvider = StateProvider<int>((ref) => 0);
