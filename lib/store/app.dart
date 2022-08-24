import 'package:mobx/mobx.dart';

import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/account/account.dart';
import 'package:encointer_wallet/store/assets/assets.dart';
import 'package:encointer_wallet/store/chain/chain.dart';
import 'package:encointer_wallet/store/encointer/encointer.dart';
import 'package:encointer_wallet/store/settings.dart';
import 'package:encointer_wallet/utils/local_storage.dart';

import 'data_update/data_update.dart';

part 'app.g.dart';

AppStore globalAppStore = AppStore(LocalStorage());

/// Encointer cache key prefix for the local storage.
///
/// Should be prepended with the network prefix.
const encointerCachePrefix = 'encointer-store';

/// Encointer cache version key prefix for the local storage.
///
/// Should be prepended with the network prefix.
const encointerCacheVersionPrefix = 'encointer-cache-version-key';

/// Should be increased if cache incompatibilities have been introduced.
const encointerCacheVersion = 'v1.0';

/// Global aggregated storage for the app.
///
/// the sub-storages are marked as `late final` as they will be initialized exactly once at startup in `lib/app.dart`.
class AppStore extends _AppStore with _$AppStore {
  AppStore(
    LocalStorage localStorage, {
    StoreConfig config = StoreConfig.Normal,
  }) : super(localStorage, config: config);
}

enum StoreConfig {
  Normal,
  Test,
}

abstract class _AppStore with Store {
  _AppStore(
    this.localStorage, {
    this.config = StoreConfig.Normal,
  });

  final config;

  // Note, following pattern of a nullable field with a non-nullable getter
  // is here because mobx can't handle `late` initialization:
  // https://github.com/mobxjs/mobx.dart/issues/598#issuecomment-814875535
  //
  // However, the store initialization process should be refactored so we do not need
  // to depend on `late`, which should be used as a very last resort only because
  // it removes the `null`-compiler checks and turns them into runtime-checks.
  @observable
  SettingsStore? _settings;
  SettingsStore get settings => _settings!;

  @observable
  DataUpdateStore? _dataUpdate;
  @computed
  DataUpdateStore get dataUpdate => _dataUpdate!;

  @observable
  AccountStore? _account;
  @computed
  AccountStore get account => _account!;

  @observable
  AssetsStore? _assets;
  @computed
  AssetsStore get assets => _assets!;

  @observable
  ChainStore? _chain;
  @computed
  ChainStore get chain => _chain!;

  @observable
  EncointerStore? _encointer;
  @computed
  EncointerStore get encointer => _encointer!;

  @observable
  bool storeIsReady = false;

  @observable
  bool webApiIsReady = false;

  @computed
  bool get appIsReady => storeIsReady && webApiIsReady;

  LocalStorage localStorage;

  @action
  Future<void> init(String sysLocaleCode) async {
    // wait settings store loaded
    _settings = SettingsStore(this as AppStore);
    await settings.init(sysLocaleCode);

    _dataUpdate = DataUpdateStore(refreshPeriod: Duration(minutes: 2));

    _account = AccountStore(this as AppStore);
    await account.loadAccount();

    _assets = AssetsStore(this as AppStore);
    assets.loadCache();

    _chain = ChainStore(this as AppStore);
    chain.loadCache();

    // need to call this after settings was initialized
    String? networkInfo = settings.endpoint.info;
    await loadOrInitEncointerCache(networkInfo!);

    storeIsReady = true;
  }

  @action
  void setApiReady(bool value) {
    print("Setting Api Ready: $value");
    webApiIsReady = value;
    print("Is App Ready?: $appIsReady");
  }

  Future<void> cacheObject(String key, value) {
    return localStorage.setObject(getCacheKey(key), value);
  }

  Future<Object?> loadObject(String key) {
    return localStorage.getObject(getCacheKey(key));
  }

  /// Returns the network dependant cache key.
  ///
  /// Prefixes the key with `test-` if we are in test-mode to prevent overwriting of
  /// the real cache with (unit-)test runs.
  String getCacheKey(String key) {
    var cacheKey = '${settings.endpoint.info}_$key';
    return config == StoreConfig.Test ? "test-$cacheKey" : cacheKey;
  }

  /// Returns the cache key for the encointer-storage.
  ///
  /// Prefixes the key with `test-` if we are in test-mode to prevent overwriting of
  /// the real cache with (unit-)test runs.
  String encointerCacheKey(String networkInfo) {
    var key = "$encointerCachePrefix-$networkInfo";
    return config == StoreConfig.Test ? "test-$key" : key;
  }

  Future<bool> purgeEncointerCache(String networkInfo) async {
    return localStorage.removeKey(encointerCacheKey(networkInfo));
  }

  Future<void> loadOrInitEncointerCache(String networkInfo) async {
    final cacheVersionFinalKey = getCacheKey(encointerCacheVersionPrefix);
    var cacheVersion = await localStorage.getKV(cacheVersionFinalKey);

    String encointerFinalCacheKey = encointerCacheKey(networkInfo);

    var maybeStore;

    if (cacheVersion == encointerCacheVersion) {
      try {
        maybeStore = await loadEncointerCache(encointerFinalCacheKey);
      } catch (e) {
        _log("Exception loading the cached store: ${e.toString()}");
      }
    }

    if (maybeStore != null) {
      _encointer = maybeStore;
    } else {
      _log("Initializing new encointer store.");
      _encointer = EncointerStore(networkInfo);
      encointer.initStore(
        this as AppStore,
        () => localStorage.setObject(encointerFinalCacheKey, encointer.toJson()),
      );

      _log("Persisting cacheVersion: $encointerCacheVersion");
      await localStorage.setKV(cacheVersionFinalKey, encointerCacheVersion);

      _log("Writing the new store to cache");
      return encointer.writeToCache();
    }
  }

  Future<EncointerStore?> loadEncointerCache(String encointerFinalCacheKey) async {
    var cachedEncointerStore = await localStorage.getMap(encointerFinalCacheKey);

    if (cachedEncointerStore != null) {
      _log("Found cached encointer store $cachedEncointerStore");
      var encointerStore = EncointerStore.fromJson(cachedEncointerStore);

      // Cache the entire encointer store at once: Check if this is too expensive,
      // when many accounts/cids exist in store. But as the caching future is in general not awaited,
      // it should be fine.
      encointerStore.initStore(
        this as AppStore,
        () => localStorage.setObject(
          encointerFinalCacheKey,
          encointer.toJson(),
        ),
      );

      return encointerStore;
    } else {
      return Future.value(null);
    }
  }

  Future<List<void>> addAccount(Map<String, dynamic> acc, String password, String? address) {
    return Future.wait([
      account.addAccount(acc, password),
    ]);
  }

  Future<void> setCurrentAccount(String? pubKey) async {
    _log("setCurrentAccount: setting current account: $pubKey");

    if (account.currentAccountPubKey == pubKey) {
      _log("setCurrentAccount: currentAccount is already new account. returning");
      return Future.value(null);
    }

    await account.setCurrentAccount(pubKey);

    if (pubKey == "") {
      // happens only if the last account in the storage has been deleted
      return Future.value(null);
    }

    final address = account.getNetworkAddress(pubKey);
    _log("setCurrentAccount: new current account address: $address");
    await encointer.initializeUninitializedStores(address);

    if (!settings.loading) {
      dataUpdate.setInvalidated();
      webApi.assets.subscribeBalance();
    }
  }

  /// Loads all account associated data.
  ///
  /// Should be used whenever one switches to a new account. This function needs to be awaited most of the time.
  /// Otherwise, calling webApi queries when the cache has not finished loading might result in outdated or wrong data.
  /// E.g. not awaiting this call was the cause of #357.
  Future<List<void>> loadAccountCache() async {
    return Future.wait([assets.clearTxs(), assets.loadAccountCache()]);
  }
}

void _log(String msg) {
  print("[AppStore] $msg");
}
