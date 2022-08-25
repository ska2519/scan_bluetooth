// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../flavors.dart';
import '../../../runner.dart';
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
  }

  Future<InitializationStatus> _initAdmob() =>
      ref.read(admobRepositoryProvider).initGoogleMobileAds();

  String getAdsUnitId(ADFormat adFormat) {
    final flavor = ref.read(flavorProvider);
    final adType = ref.read(adTypeProvider(flavor));
    return AdHelper.getAdsUnitId(adType, adFormat);
  }

  ADType getAdType(Flavor flavor) {
    if (kReleaseMode && flavor == Flavor.PROD) {
      return ADType.real;
    }
    return ADType.sample;
  }
}

final admobServiceProvider = Provider<AdmobService>(AdmobService.new);

final adTypeProvider = Provider.family<ADType, Flavor>(
    (ref, flavor) => ref.read(admobServiceProvider).getAdType(flavor));
