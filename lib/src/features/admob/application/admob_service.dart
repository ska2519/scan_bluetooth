import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/admob_repository.dart';

class AdmobService {
  AdmobService(this.ref);
  final Ref ref;

  Future<InitializationStatus> initAdmob() =>
      ref.read(admobRepositoryProvider).initGoogleMobileAds();
}

final admobServiceProvider = Provider<AdmobService>(AdmobService.new);

final initAdmobProvider = FutureProvider<InitializationStatus>((ref) async {
  final admobStatus = await ref.read(admobServiceProvider).initAdmob();
  print('admobStatus: ${admobStatus.adapterStatuses.values.first.state}');
  ref.read(admobStatusProvider.notifier).state = admobStatus;
  return admobStatus;
});

final admobStatusProvider = StateProvider<InitializationStatus?>((ref) {
  // print(
  //     'admobStatusProvider: ${ref.controller.state?.adapterStatuses.values.first.state}');
  return null;
});
