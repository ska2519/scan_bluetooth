import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../constants/resources.dart';
import '../../in_app_purchase/application/purchases_service.dart';
import '../application/ad_helper.dart';
import '../application/admob_service.dart';

final nativeAdWidgetProvider = StateProvider<AdWidget?>((ref) => null);

class NativeAdCard extends HookConsumerWidget {
  const NativeAdCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final removeAdsUpgrade = ref.watch(removeAdsProvider);
    // final adWidget = ref.watch(nativeAdWidgetProvider);
    logger.i('NativeAdCard removeAdsUpgrade: $removeAdsUpgrade');
    if (removeAdsUpgrade) {
      return const SizedBox();
    }
    final adWidget = useState<AdWidget?>(null);

    final createNativeAd = useCallback(() {
      logger.i('NativeAdCard _createNativeAd');
      // if (adWidget == null) {
      NativeAd(
        adUnitId: ref
            .read(admobServiceProvider)
            .getAdsUnitId(ADFormat.nativeAdvanced),
        factoryId: 'listTile',
        request: const AdRequest(),
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            logger.i('NativeAdCard _createNativeAd onAdLoaded');
            if (adWidget.value == null) {
              logger.i(
                  'NativeAdCard  ref.read(nativeAdWidgetProvider.notifier) add');
              adWidget.value = AdWidget(ad: ad as NativeAd);
            }
          },
          onAdFailedToLoad: (ad, e) {
            ad.dispose();
            logger.i('NativeAdCard Ad load failed e:${e.toString()}');
          },
        ),
      ).load();
      logger.i('NativeAdCard nativeAd.load();');
      // }
    }, []);

    useEffect(() {
      if (removeAdsUpgrade) {
        logger.i('NativeAdCard useEffect removeAdsUpgrade: $removeAdsUpgrade');
      } else if ((Platform.isAndroid || Platform.isIOS) &&
          adWidget.value == null) {
        logger.i(
            'NativeAdCard useEffect: ((Platform.isAndroid || Platform.isIOS) && adWidget == null)');
        createNativeAd();
      }
      logger.i('NativeAdCard useEffect else adWidget: $adWidget');
      return null;
    }, [removeAdsUpgrade]);

    return SizedBox(
      height: 80,
      child: Card(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: adWidget.value ?? const SizedBox(),
        ),
      ),
    );
  }
}
