// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/admob_repository.dart';

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
}

final admobServiceProvider = Provider<AdmobService>(AdmobService.new);
