import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/account/account.dart';
import 'package:encointer_wallet/store/assets/assets.dart';
import 'package:encointer_wallet/store/chain/chain.dart';
import 'package:encointer_wallet/store/encointer/encointer.dart';
import 'package:encointer_wallet/store/settings.dart';
import 'package:encointer_wallet/utils/localStorage.dart';
import 'package:mobx/mobx.dart';

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
  _AppStore(this.localStorage, {this.config = StoreConfig.Normal});

  final config;

  @observable
  late final SettingsStore settings;

  @observable
  late final AccountStore account;

  @observable
  late final AssetsStore assets;

  @observable
  late final ChainStore chain;

  @observable
  late final EncointerStore encointer;

  @observable
  bool isReady = false;

  LocalStorage localStorage;

  @action
  Future<void> init(String sysLocaleCode) async {
    // wait settings store loaded
    settings = SettingsStore(this as AppStore);
    await settings.init(sysLocaleCode);

    account = AccountStore(this as AppStore);
    await account.loadAccount();

    assets = AssetsStore(this as AppStore);
    assets.loadCache();

    chain = ChainStore(this as AppStore);
    chain.loadCache();

    // need to call this after settings was initialized
    String? networkInfo = settings.endpoint.info;
    await loadOrInitEncointerCache(networkInfo!);

    isReady = true;
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

    var maybeStore = cacheVersion == encointerCacheVersion ? await loadEncointerCache(encointerFinalCacheKey) : null;

    if (maybeStore != null) {
      encointer = maybeStore;
    } else {
      _log("Initializing new encointer store.");
      encointer = EncointerStore(networkInfo);
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

  Future<void> addAccount(Map<String, dynamic> acc, String password, String? address) {
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
      encointer.updateState();
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
