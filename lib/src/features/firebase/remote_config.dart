import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../exceptions/error_logger.dart';
import '../in_app_purchase/application/purchases_service.dart';

enum RemoteConfigKeys {
  disabledApp('disabledApp', false),
  disableInterstitialAd('disableInterstitialAd', false),
  enablePurchaseScreen('disableParchaseScreen', false),

  minimumScanInterval('minimumScanInterval', 4),
  labelLimitCount('labelLimitCount', 5);

  const RemoteConfigKeys(this.key, this.value);
  final String key;
  final dynamic value;

  @override
  String toString() => 'RemoteConfigKeys(key: $key / value: $value)';
}

final remoteConfigProvider = Provider<RemoteConfig>(RemoteConfig.new);

final disabledAppProvider =
    StateProvider<bool>((ref) => RemoteConfigKeys.disabledApp.value);
final disableInterstitialAdProvider =
    StateProvider<bool>((ref) => RemoteConfigKeys.disableInterstitialAd.value);
final enablePurchaseScreenProvider =
    StateProvider<bool>((ref) => RemoteConfigKeys.enablePurchaseScreen.value);

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
    try {
      ref.read(disabledAppProvider.notifier).state = getDisabledApp();
      ref.read(disableInterstitialAdProvider.notifier).state =
          getDisableInterstitialAd();
      ref.read(enablePurchaseScreenProvider.notifier).state =
          enablePurchaseScreen();
      ref.read(minimumScanIntervalProvider.notifier).state =
          getMinimumScanInterval();
      ref.read(labelLimitCountProvider.notifier).state = getLabelLimitCount();
    } catch (e) {
      logger.e('activateRemoteConfig _init e: $e');
    }
  }

  bool getDisabledApp() => _instance.getBool(RemoteConfigKeys.disabledApp.key);
  bool getDisableInterstitialAd() =>
      _instance.getBool(RemoteConfigKeys.disableInterstitialAd.key);
  bool enablePurchaseScreen() =>
      _instance.getBool(RemoteConfigKeys.enablePurchaseScreen.key);

  int getMinimumScanInterval() =>
      _instance.getInt(RemoteConfigKeys.minimumScanInterval.key);
  int getLabelLimitCount() =>
      _instance.getInt(RemoteConfigKeys.labelLimitCount.key);

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
