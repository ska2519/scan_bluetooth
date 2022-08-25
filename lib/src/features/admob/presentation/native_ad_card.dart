import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../constants/resources.dart';
import '../application/ad_helper.dart';
import '../application/admob_service.dart';

class NativeAdCard extends StatefulHookConsumerWidget {
  const NativeAdCard({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NativeAdCardState();
}

class _NativeAdCardState extends ConsumerState<NativeAdCard> {
  NativeAd? _ad;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid || Platform.isIOS) {
      NativeAd(
        adUnitId: ref
            .read(admobServiceProvider)
            .getAdsUnitId(ADFormat.nativeAdvanced),
        factoryId: 'listTile',
        request: const AdRequest(),
        listener: NativeAdListener(
          onAdLoaded: (ad) => setState(() => _ad = ad as NativeAd),
          onAdFailedToLoad: (ad, error) {
            ad.dispose();
            print(
                'Ad load failed (code=${error.code} message=${error.message})');
          },
        ),
      ).load();
    }
  }

  @override
  void dispose() {
    _ad?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: _ad != null ? AdWidget(ad: _ad!) : const SizedBox(),
      ),
    );
  }
}
