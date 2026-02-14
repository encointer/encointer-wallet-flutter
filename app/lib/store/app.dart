import 'package:encointer_wallet/store/account/services/legacy_storage.dart';
import 'package:ew_storage/ew_storage.dart';
import 'package:mobx/mobx.dart';

import 'package:ew_log/ew_log.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/account/account.dart';
import 'package:encointer_wallet/store/assets/assets.dart';
import 'package:encointer_wallet/store/chain/chain.dart';
import 'package:encointer_wallet/store/data_update/data_update.dart';
import 'package:encointer_wallet/store/encointer/encointer.dart';
import 'package:encointer_wallet/store/offline_payment/offline_payment_store.dart';
import 'package:encointer_wallet/store/settings.dart';
import 'package:encointer_wallet/utils/local_storage.dart';
import 'package:ew_keyring/ew_keyring.dart';

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

/// Global aggregated storage for the app.
///
/// the sub-storages are marked as `late final` as they will be initialized exactly once at startup in `lib/app.dart`.
class AppStore<S extends SecureStorageInterface, L extends LegacyStorageInterface> extends _AppStore with _$AppStore {
  AppStore(super.localStorage, super.secureStorage, super.legacyStorage);
}

abstract class _AppStore<S extends SecureStorageInterface, L extends LegacyStorageInterface> with Store {
  _AppStore(this.localStorage, this.secureStorage, this.legacyStorage);

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
  OfflinePaymentStore? _offlinePayment;

  @computed
  OfflinePaymentStore get offlinePayment => _offlinePayment!;

  @observable
  bool storeIsReady = false;

  @observable
  bool webApiIsReady = false;

  @computed
  bool get appIsReady => storeIsReady && webApiIsReady;

  LocalStorage localStorage;

  final S secureStorage;

  final L legacyStorage;

  @action
  Future<void> init(String sysLocaleCode) async {
    // wait settings store loaded
    _settings = SettingsStore(this as AppStore);
    await settings.init(sysLocaleCode);

    _dataUpdate = DataUpdateStore(refreshPeriod: const Duration(minutes: 2));

    _account = AccountStore(this as AppStore);
    await account.loadAccount();

    _assets = AssetsStore(this as AppStore);
    await assets.loadCache();

    _chain = ChainStore(this as AppStore);
    await chain.loadCache();

    _offlinePayment = OfflinePaymentStore(this as AppStore);
    await offlinePayment.loadCache();

    // need to call this after settings was initialized
    final networkInfo = settings.currentNetwork.id();
    await loadOrInitEncointerCache(networkInfo);

    storeIsReady = true;
  }

  @action
  void setApiReady(bool value) {
    Log.d('Setting Api Ready: $value', '_AppStore');
    webApiIsReady = value;
    Log.d('Is App Ready?: $appIsReady', '_AppStore');
  }

  Future<void> cacheObject(String key, Object value) {
    return localStorage.setObject(getCacheKey(key), value);
  }

  Future<Object?> loadObject(String key) {
    return localStorage.getObject(getCacheKey(key));
  }

  /// Returns the network dependant cache key.
  String getCacheKey(String key) {
    return '${settings.currentNetwork.id()}_$key';
  }

  /// Returns the cache key for the encointer-storage.
  String encointerCacheKey(String networkInfo) {
    return '$encointerCachePrefix-$networkInfo';
  }

  Future<bool> purgeEncointerCache(String networkInfo) async {
    await encointer.setChosenCid();
    return localStorage.removeObject(encointerCacheKey(networkInfo));
  }

  Future<void> loadOrInitEncointerCache(String networkInfo) async {
    final cacheVersionFinalKey = getCacheKey(encointerCacheVersionPrefix);
    final cacheVersion = await localStorage.getKV(cacheVersionFinalKey);

    final encointerFinalCacheKey = encointerCacheKey(networkInfo);

    EncointerStore? maybeStore;

    if (cacheVersion == encointerCacheVersion) {
      try {
        maybeStore = await loadEncointerCache(encointerFinalCacheKey);
      } catch (e, s) {
        Log.e('Exception loading the cached store: $e', '_AppStore', s);
      }
    }

    if (maybeStore != null) {
      _encointer = maybeStore;
    } else {
      Log.d('Initializing new encointer store.', '_AppStore');
      _encointer = EncointerStore(networkInfo);
      encointer.initStore(
        this as AppStore,
        () => localStorage.setObject(encointerFinalCacheKey, encointer.toJson()),
      );

      Log.d('Persisting cacheVersion: $encointerCacheVersion', '_AppStore');
      await localStorage.setKV(cacheVersionFinalKey, encointerCacheVersion);

      Log.d('Writing the new store to cache', '_AppStore');

      return encointer.writeToCache();
    }
  }

  Future<EncointerStore?> loadEncointerCache(String encointerFinalCacheKey) async {
    final cachedEncointerStore = await localStorage.getMap(encointerFinalCacheKey);

    if (cachedEncointerStore != null) {
      Log.d('Found cached encointer store $cachedEncointerStore', '_AppStore');

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

  Future<void> addAccount(KeyringAccount acc) {
    return account.addAccount(acc);
  }

  Future<void> setCurrentAccount(String? pubKey) async {
    Log.d('setCurrentAccount: setting current account: $pubKey', '_AppStore');

    if (account.currentAccountPubKey == pubKey) {
      Log.d('setCurrentAccount: currentAccount is already new account. returning', '_AppStore');

      return Future.value();
    }

    await account.setCurrentAccount(pubKey);

    if (pubKey == '') {
      // happens only if the last account in the storage has been deleted
      return Future.value();
    }

    if (pubKey != null) {
      // Todo: #1072
      final address = AddressUtils.pubKeyHexToAddress(pubKey, prefix: settings.currentNetwork.ss58());
      Log.d('setCurrentAccount: new current account address: $address', '_AppStore');
      await encointer.initializeUninitializedStores(address);
    }

    if (!settings.loading) {
      webApi.ipfsAuthService.clearAllTokens();
      dataUpdate.setInvalidated();
      await webApi.assets.subscribeBalance();
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
