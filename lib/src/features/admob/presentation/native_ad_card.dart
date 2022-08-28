import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../constants/resources.dart';
import '../../bluetooth/application/bluetooth_service.dart';
import '../application/admob_service.dart';

class NativeAdCard extends HookConsumerWidget {
  const NativeAdCard(this.nativeAd, {this.nativeAdKey, super.key});
  final NativeAd nativeAd;
  final Key? nativeAdKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nativeAd = ref.watch(nativeAdProvider(nativeAdKey));
    final bluetoothList = ref.watch(bluetoothListProvider);
    return SizedBox(
      height: 80,
      child: Card(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: bluetoothList.isNotEmpty && nativeAd != null
              ? AdWidget(ad: nativeAd)
              : const SizedBox(),
        ),
      ),
    );
  }
}
