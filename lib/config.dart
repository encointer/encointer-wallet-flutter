import 'package:encointer_wallet/modules/modules.dart';

class AppConfig {
  const AppConfig({
    this.initialRoute = SplashView.route,
    this.mockLocalStorage = false,
    this.mockSubstrateApi = false,
    this.appStoreConfig = StoreConfig.Normal,
  });

  final String initialRoute;
  final bool mockLocalStorage;
  final bool mockSubstrateApi;
  final StoreConfig appStoreConfig;
}

enum StoreConfig { Normal, Test }

extension StoreConfigExtensions on StoreConfig {
  bool get isTest => this == StoreConfig.Test;

  bool get isNormal => this == StoreConfig.Normal;
}
