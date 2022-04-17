import 'package:encointer_wallet/store/account/account.dart';
import 'package:encointer_wallet/store/assets/assets.dart';
import 'package:encointer_wallet/store/chain/chain.dart';
import 'package:encointer_wallet/store/encointer/encointer.dart';
import 'package:encointer_wallet/store/settings.dart';
import 'package:encointer_wallet/utils/localStorage.dart';
import 'package:mobx/mobx.dart';

part 'app.g.dart';

AppStore globalAppStore = AppStore(LocalStorage());

const encointerCachePrefix = 'encointer-store';

class AppStore extends _AppStore with _$AppStore {
  AppStore(LocalStorage localStorage) : super(localStorage);
}

enum StoreConfig {
  Normal,
  Test,
}

abstract class _AppStore with Store {
  _AppStore(this.localStorage, {this.mode = StoreConfig.Normal});

  final mode;

  @observable
  SettingsStore settings;

  @observable
  AccountStore account;

  @observable
  AssetsStore assets;

  @observable
  ChainStore chain;

  @observable
  EncointerStore encointer;

  @observable
  bool isReady = false;

  LocalStorage localStorage;

  @action
  Future<void> init(String sysLocaleCode) async {
    // wait settings store loaded
    settings = SettingsStore(this);
    await settings.init(sysLocaleCode);

    account = AccountStore(this);
    await account.loadAccount();

    assets = AssetsStore(this);
    assets.loadCache();

    chain = ChainStore(this);
    chain.loadCache();

    // need to call this after settings was initialized
    String networkInfo = settings.endpoint.info;
    await loadEncointerCache(networkInfo);

    isReady = true;
  }

  Future<void> cacheObject(String key, value) {
    return localStorage.setObject(getCacheKey(key), value);
  }

  Future<Object> loadObject(String key) {
    return localStorage.getObject(getCacheKey(key));
  }

  /// Returns the network dependant cache key.
  ///
  /// Prefixes the key with `test-` if we are in test-mode to prevent overwriting of
  /// the real cache with (unit-)test runs.
  String getCacheKey(String key) {
    var cacheKey = '${settings.endpoint.info}_$key';
    return mode == StoreConfig.Test ? "test-$cacheKey": cacheKey;
  }

  /// Returns the cache key for the encointer-storage.
  ///
  /// Prefixes the key with `test-` if we are in test-mode to prevent overwriting of
  /// the real cache with (unit-)test runs.
  String encointerCacheKey(String networkInfo) {
    var key = "$encointerCachePrefix-$networkInfo";
    return mode == StoreConfig.Test ? "test-$key": key;
  }

  Future<void> purgeEncointerCache(String networkInfo) async {
    return localStorage.setObject(encointerCacheKey(networkInfo), new Map<String, dynamic>());
  }

  Future<void> loadEncointerCache(String networkInfo) async {
    String encointerFinalCacheKey = encointerCacheKey(networkInfo);
    var cachedEncointerStore = await localStorage.getObject(encointerFinalCacheKey);

    if (cachedEncointerStore != null) {
      _log("Found cached encointer store");
      encointer = EncointerStore.fromJson(cachedEncointerStore);
      encointer.rootStore = this;
    } else {
      _log("Initializing new encointer store.");
      encointer = EncointerStore(networkInfo, store: this);
    }

    // Cache the entire encointer store at once: Check if this is too expensive ???
    encointer.setCacheFn(() => localStorage.setObject(encointerFinalCacheKey, encointer.toJson()));
  }

  /// Loads all account associated data.
  ///
  /// Should be used whenever one switches to a new account. This function needs to be awaited most of the time.
  /// Otherwise, calling webApi queries when the cache has not finished loading might result in outdated or wrong data.
  /// E.g. not awaiting this call was the cause of #357.
  Future<void> loadAccountCache() {
    return Future.wait([assets.clearTxs(), assets.loadAccountCache()]);
  }
}

void _log(String msg) {
  print("[AppStore] $msg");
}
