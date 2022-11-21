import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AdmobRepository {
  AdmobRepository({this.addDelay = true});
  final bool addDelay;

  Future<InitializationStatus> initGoogleMobileAds() async =>
      await MobileAds.instance.initialize();
}

final admobRepositoryProvider =
    Provider<AdmobRepository>((ref) => AdmobRepository());
