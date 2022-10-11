import 'dart:io';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../constants/resources.dart';
import '../../../exceptions/error_logger.dart';
import '../../in_app_purchase/application/purchases_service.dart';
import '../application/ad_helper.dart';
import '../application/admob_service.dart';

final nativeAdWidgetProvider = StateProvider<AdWidget?>((ref) => null);

class NativeAdCard extends HookConsumerWidget {
  const NativeAdCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final removeAdsUpgrade = ref.watch(removeAdsUpgradeProvider);
    final adWidget = ref.watch(nativeAdWidgetProvider);
    logger.i('NativeAdCard removeAdsUpgrade: $removeAdsUpgrade');

    void createNativeAd() {
      logger.i('NativeAdCard _createNativeAd');
      if (adWidget == null) {
        NativeAd(
          adUnitId: ref
              .read(admobServiceProvider)
              .getAdsUnitId(ADFormat.nativeAdvanced),
          factoryId: 'listTile',
          request: const AdRequest(),
          listener: NativeAdListener(
            onAdLoaded: (ad) {
              logger.i('NativeAdCard _createNativeAd onAdLoaded');
              ref.read(nativeAdWidgetProvider.notifier).state =
                  AdWidget(ad: ad as NativeAd);
            },
            onAdFailedToLoad: (ad, e) {
              ad.dispose();
              logger.i('NativeAdCard Ad load failed e:${e.toString()}');
            },
          ),
        ).load();
        logger.i('NativeAdCard nativeAd.load();');
      }
    }

    useEffect(() {
      logger.i('NativeAdCard useEffect removeAdsUpgrade: $removeAdsUpgrade');
      if (Platform.isAndroid ||
          Platform.isIOS ||
          !removeAdsUpgrade ||
          adWidget == null) {
        logger.i(
            'NativeAdCard useEffect: isAndroid || isIOS || !removeAdsUpgrade');
        createNativeAd();
      } else {
        ref.read(nativeAdWidgetProvider.notifier).state = null;
        logger.i('NativeAdCard useEffect else adWidget: $adWidget');
      }
      return null;
    }, []);

    return SizedBox(
      height: 80,
      child: Card(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: adWidget ?? const SizedBox(),
        ),
      ),
    );
  }
}
