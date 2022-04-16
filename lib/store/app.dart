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

abstract class _AppStore with Store {
  _AppStore(this.localStorage);

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

  String getCacheKey(String key) {
    return '${settings.endpoint.info}_$key';
  }

  Future<void> loadEncointerCache(String networkInfo) async {
    String encointerFinalCacheKey = "$encointerCachePrefix-$networkInfo";
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
