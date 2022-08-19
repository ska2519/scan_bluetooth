import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../constants/resources.dart';
import '../ad_helper.dart';

class NativeAdCard extends StatefulWidget {
  const NativeAdCard({super.key});

  @override
  State<NativeAdCard> createState() => _NativeAdCardState();
}

class _NativeAdCardState extends State<NativeAdCard> {
  NativeAd? _ad;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid || Platform.isIOS) {
      NativeAd(
        adUnitId: AdHelper.nativeAdUnitId(AdType.test),
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
