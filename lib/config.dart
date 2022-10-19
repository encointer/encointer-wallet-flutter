class AppConfig {
  const AppConfig({
    this.mockLocalStorage = false,
    this.mockSubstrateApi = false,
    this.appStoreConfig = StoreConfig.Normal,
  });

  final bool mockLocalStorage;
  final bool mockSubstrateApi;
  final StoreConfig appStoreConfig;
}

enum StoreConfig { Normal, Test }

extension StoreConfigExtensions on StoreConfig {
  bool get isTest => this == StoreConfig.Test;

  bool get isNormal => this == StoreConfig.Normal;
}
