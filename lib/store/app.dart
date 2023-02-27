import 'dart:async';

import 'package:encointer_wallet/common/data/substrate_api/api.dart';
import 'package:encointer_wallet/common/services/preferences/local_data.dart';
import 'package:encointer_wallet/extras/config/build_options.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service_locator/service_locator.dart';
import 'package:encointer_wallet/store/account/account.dart';
import 'package:encointer_wallet/store/assets/assets.dart';
import 'package:encointer_wallet/store/chain/chain.dart';
import 'package:encointer_wallet/store/data_update/data_update.dart';
import 'package:encointer_wallet/store/encointer/encointer.dart';
import 'package:encointer_wallet/store/settings.dart';
import 'package:mobx/mobx.dart';

part 'app.g.dart';

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

const _tag = 'app_store';

/// Global aggregated storage for the app.
///
/// the sub-storages are marked as `late final` as they will be initialized exactly once at startup in `lib/app.dart`.
class AppStore extends _AppStore with _$AppStore {
  AppStore();
}

abstract class _AppStore with Store {
  _AppStore() : localStorage = sl();

  // final AppConfig config;

  late final LocalData localStorage;

  // Note, following pattern of a nullable field with a non-nullable getter
  // is here because mobx can't handle `late` initialization:
  // https://github.com/mobxjs/mobx.dart/issues/598#issuecomment-814875535
  //
  // However, the store initialization process should be refactored so we do not need
  // to depend on `late`, which should be used as a very last resort only because
  // it removes the `null`-compiler checks and turns them into runtime-checks.
  @observable
  SettingsStore? _settings;
  @computed
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

  @action
  void _setSettingsStore() {
    Log.d('_setSettingsStore', _tag);
    _settings = SettingsStore();
  }

  @action
  Future<void> init() async {
    Log.d('_init', _tag);

    _setSettingsStore();

    // wait settings store loaded

    await settings.init();

    _dataUpdate = DataUpdateStore(refreshPeriod: const Duration(minutes: 2));

    _account = AccountStore();
    await account.loadAccount();

    _assets = AssetsStore();
    assets.loadCache();

    _chain = ChainStore();
    chain.loadCache();

    // need to call this after settings was initialized
    final networkInfo = settings.endpoint.info;
    await loadOrInitEncointerCache(networkInfo!);

    storeIsReady = true;
  }

  @action
  void setApiReady(bool value) {
    Log.d('Setting Api Ready: $value', _tag);
    webApiIsReady = value;
    Log.d('Is App Ready?: $appIsReady', _tag);
  }

  @action
  Future<void> cacheObject(String key, Object value) {
    Log.d(' cacheObject: key = $key, value = $value', _tag);
    return localStorage.setObject(getCacheKey(key), value);
  }

  @action
  Future<Object?> loadObject(String key) {
    Log.d(' loadObject: key = $key', _tag);
    return localStorage.getObject(getCacheKey(key));
  }

  /// Returns the network dependant cache key.
  ///
  /// Prefixes the key with `test-` if we are in test-mode to prevent overwriting of
  /// the real cache with (unit-)test runs.
  @action
  String getCacheKey(String key) {
    Log.d(' getCacheKey: key = $key', _tag);
    final cacheKey = '${settings.endpoint.info}_$key';
    return buildConfig == BuildConfig.unitTest ? 'test-$cacheKey' : cacheKey;
  }

  /// Returns the cache key for the encointer-storage.
  ///
  /// Prefixes the key with `test-` if we are in test-mode to prevent overwriting of
  /// the real cache with (unit-)test runs.
  @action
  String encointerCacheKey(String networkInfo) {
    Log.d(' encointerCacheKey: networkInfo = $networkInfo', _tag);
    final key = '$encointerCachePrefix-$networkInfo';
    return buildConfig == BuildConfig.unitTest ? 'test-$key' : key;
  }

  @action
  Future<bool> purgeEncointerCache(String networkInfo) async {
    Log.d(' purgeEncointerCache: networkInfo = $networkInfo', _tag);
    return localStorage.removeKey(encointerCacheKey(networkInfo));
  }

  @action
  Future<void> loadOrInitEncointerCache(String networkInfo) async {
    Log.d(' loadOrInitEncointerCache: networkInfo = $networkInfo', _tag);
    final cacheVersionFinalKey = getCacheKey(encointerCacheVersionPrefix);
    final cacheVersion = await localStorage.getKV(cacheVersionFinalKey);

    final encointerFinalCacheKey = encointerCacheKey(networkInfo);

    EncointerStore? maybeStore;

    if (cacheVersion == encointerCacheVersion) {
      try {
        maybeStore = await loadEncointerCache(encointerFinalCacheKey);
      } catch (e, s) {
        Log.e('Exception loading the cached store: $e', _tag, s);
      }
    }

    if (maybeStore != null) {
      _encointer = maybeStore;
    } else {
      Log.d('Initializing new encointer store.', _tag);
      _encointer = EncointerStore(networkInfo);
      encointer.initStore(
        this as AppStore,
        () => localStorage.setObject(encointerFinalCacheKey, encointer.toJson()),
      );

      Log.d('Persisting cacheVersion: $encointerCacheVersion', _tag);
      await localStorage.setKV(cacheVersionFinalKey, encointerCacheVersion);

      Log.d('Writing the new store to cache', _tag);

      return encointer.writeToCache();
    }
  }

  @action
  Future<EncointerStore?> loadEncointerCache(String encointerFinalCacheKey) async {
    Log.d(' loadEncointerCache: encointerFinalCacheKey = $encointerFinalCacheKey', _tag);
    final cachedEncointerStore = await localStorage.getMap(encointerFinalCacheKey);

    if (cachedEncointerStore != null) {
      Log.d(' Found cached encointer store $cachedEncointerStore', _tag);

      // Cache the entire encointer store at once: Check if this is too expensive,
      // when many accounts/cids exist in store. But as the caching future is in general not awaited,
      // it should be fine.
      final encointerStore = EncointerStore.fromJson(cachedEncointerStore)
        ..initStore(
          this as AppStore,
          () => localStorage.setObject(
            encointerFinalCacheKey,
            encointer.toJson(),
          ),
        );

      return encointerStore;
    } else {
      return Future.value();
    }
  }

  @action
  Future<List<void>> addAccount(Map<String, dynamic> acc, String password, String? address) {
    Log.d('addAccount: acc = $acc, password = $password, address = $address', _tag);
    return Future.wait([
      account.addAccount(acc, password),
    ]);
  }

  @action
  Future<void> setCurrentAccount(String? pubKey) async {
    Log.d('setCurrentAccount: setting current account: $pubKey', _tag);

    if (account.currentAccountPubKey == pubKey) {
      Log.d('setCurrentAccount: currentAccount is already new account. returning', _tag);

      return Future.value();
    }

    await account.setCurrentAccount(pubKey);

    if (pubKey == '') {
      // happens only if the last account in the storage has been deleted
      return Future.value();
    }

    final address = account.getNetworkAddress(pubKey);
    Log.d('setCurrentAccount: new current account address: $address', _tag);
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
  @action
  Future<List<void>> loadAccountCache() async {
    return Future.wait([assets.clearTxs(), assets.loadAccountCache()]);
  }
}
