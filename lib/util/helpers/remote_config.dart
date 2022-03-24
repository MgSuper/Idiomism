import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfiguration {
  static Future<FirebaseRemoteConfig> initConfig() async {
    final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(
          seconds: 1), // a fetch will wait up to 10 seconds before timing out
      minimumFetchInterval: const Duration(
          seconds:
              10), // fetch parameters will be cached for a maximum of 1 hour
    ));
    return _remoteConfig;
  }
}
