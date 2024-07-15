import 'package:encointer_wallet/config/networks/networks.dart';
import 'package:mobx/mobx.dart';

import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/account/types/account_data.dart';
import 'package:encointer_wallet/store/app.dart';

part 'settings.g.dart';

class SettingsStore extends _SettingsStore with _$SettingsStore {
  SettingsStore(super.store);
}

abstract class _SettingsStore with Store {
  _SettingsStore(this.rootStore);

  final AppStore rootStore;

  final String localStorageLocaleKey = 'locale';
  final String localStorageNetworkKey = 'network';

  /// The bazaar is not active currently. This variable can only be set under profile -> developer options.
  @observable
  bool enableBazaar = false;

  @observable
  bool loading = true;

  @observable
  String localeCode = '';

  @observable
  Network endpoint = Network.kusama;

  @observable
  ObservableList<AccountData> contactList = ObservableList<AccountData>();

  @computed
  bool get endpointIsNoTee {
    return true;
  }

  @computed
  String get ipfsGateway => endpoint.ipfsGateway();

  /// Set of known accounts.
  ///
  /// Contains all the accounts and contacts stored on the device.
  @computed
  List<AccountData> get knownAccounts {
    final uniqueIds = <String>{};
    final allAccountsWithDuplicates = rootStore.account.accountList.toList()..addAll(contactList);
    return allAccountsWithDuplicates.where((data) => uniqueIds.add(data.pubKey)).toList();
  }

  @action
  Future<void> init(String sysLocaleCode) async {
    await loadLocalCode();
    await loadEndpoint(sysLocaleCode);
    await Future.wait([
      loadContacts(),
    ]);
  }

  @action
  Future<void> setLocalCode(String code) async {
    await rootStore.localStorage.setObject(localStorageLocaleKey, code);
    localeCode = code;
  }

  @action
  void toggleEnableBazaar() {
    enableBazaar = !enableBazaar;
  }

  @action
  Future<void> loadLocalCode() async {
    final stored = await rootStore.localStorage.getObject(localStorageLocaleKey) as String?;
    if (stored != null) {
      localeCode = stored;
    }
  }

  @action
  void setNetworkLoading(bool isLoading) {
    loading = isLoading;
  }

  @computed
  bool get isConnected {
    return !loading;
  }

  @action
  Future<void> loadContacts() async {
    final ls = await rootStore.localStorage.getContactList();
    contactList = ObservableList.of(ls.map(AccountData.fromJson));
  }

  @action
  Future<void> addContact(Map<String, dynamic> con) async {
    await rootStore.localStorage.addContact(con);
    await loadContacts();
  }

  @action
  Future<void> removeContact(AccountData con) async {
    await rootStore.localStorage.removeContact(con.pubKey);
    await loadContacts();
  }

  @action
  Future<void> updateContact(Map<String, dynamic> con) async {
    await rootStore.localStorage.updateContact(con);
    await loadContacts();
  }

  @action
  void setNetwork(Network network) {
    endpoint = network;
    rootStore.localStorage.setKV(localStorageNetworkKey, network.info());
  }

  @action
  Future<void> loadEndpoint(String sysLocaleCode) async {
    final networkInfo = await rootStore.localStorage.getKV(localStorageNetworkKey);
    if (networkInfo == null) {
      endpoint = Network.kusama;
    } else {
      endpoint = Network.fromInfoOrDefault(networkInfo);
    }
  }

  String getCacheKey(String key) {
    return '${endpoint.info()}_$key';
  }

  Future<void> reloadNetwork(Network network) async {
    // Stop networking before loading cache
    await webApi.close();

    setNetwork(network);

    // load cache before starting networking again
    await Future.wait(<Future<void>>[
      rootStore.loadAccountCache(),
      rootStore.assets.loadCache(),
      rootStore.chain.loadCache(),
      rootStore.loadOrInitEncointerCache(network.info()),
    ]);

    return webApi.init();
  }
}
