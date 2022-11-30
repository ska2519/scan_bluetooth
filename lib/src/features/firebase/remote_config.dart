import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../exceptions/error_logger.dart';
import '../in_app_purchase/application/purchases_service.dart';

enum RemoteConfigKeys {
  minimumScanInterval('minimumScanInterval', 4),
  labelLimitCount('labelLimitCount', 5),
  disableInterstitialAd('disableInterstitialAd', false);

  const RemoteConfigKeys(this.key, this.value);
  final String key;
  final dynamic value;

  @override
  String toString() => 'RemoteConfigKeys(key: $key / value: $value)';
}

final remoteConfigProvider = Provider<RemoteConfig>(RemoteConfig.new);

final disableInterstitialAdProvider =
    StateProvider<bool>((ref) => RemoteConfigKeys.disableInterstitialAd.value);

class RemoteConfig {
  RemoteConfig(this.ref) {
    _init();
  }
  final Ref ref;
  static final _instance = FirebaseRemoteConfig.instance;

  Future<void> _init() async {
    try {
      await _setConfigSettings();
      await _setDefaults();
      final activated = await _fetchAndActivate();
      logger.i('RemoteConfig activated: $activated');
      if (activated) activateRemoteConfig();
    } catch (e) {
      logger.e('RemoteConfig _init e: $e');
    }
  }

  void activateRemoteConfig() {
    ref.read(minimumScanIntervalProvider.notifier).state =
        getMinimumScanInterval();
    ref.read(labelLimitCountProvider.notifier).state = getLabelLimitCount();
    ref.read(disableInterstitialAdProvider.notifier).state =
        getDisableInterstitialAd();
  }

  int getMinimumScanInterval() =>
      _instance.getInt(RemoteConfigKeys.minimumScanInterval.key);
  int getLabelLimitCount() =>
      _instance.getInt(RemoteConfigKeys.labelLimitCount.key);
  bool getDisableInterstitialAd() =>
      _instance.getBool(RemoteConfigKeys.disableInterstitialAd.key);

  Future<void> _setConfigSettings() async {
    try {
      return await _instance.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(minutes: 1),
          minimumFetchInterval: const Duration(minutes: 30),
        ),
      );
    } catch (e) {
      logger.e('RemoteConfig _setConfigSettings e: $e');
    }
  }

  Future<void> _setDefaults() async {
    try {
      var defaultParameters = <String, dynamic>{};
      for (var remoteConfig in RemoteConfigKeys.values) {
        defaultParameters[remoteConfig.key] = remoteConfig.value;
      }
      await _instance.setDefaults(defaultParameters);
    } catch (e) {
      logger.e('RemoteConfig _setDefaults e: $e');
    }
  }

  Future<bool> _fetchAndActivate() async => _instance.fetchAndActivate();
}
