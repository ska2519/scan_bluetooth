import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../constants/resources.dart';
import '../application/admob_service.dart';

class NativeAdCard extends HookConsumerWidget {
  const NativeAdCard({required this.nativeAd, this.nativeAdKey, super.key});
  final NativeAd nativeAd;
  final Key? nativeAdKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nativeAd = ref.watch(nativeAdProvider(nativeAdKey));
    return SizedBox(
      height: 80,
      child: Card(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: nativeAd != null
              ? AdWidget(key: nativeAdKey, ad: nativeAd)
              : const SizedBox(),
        ),
      ),
    );
  }
}
