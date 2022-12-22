import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';

import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/config/node.dart';
import 'package:encointer_wallet/page/profile/settings/ss58_prefix_list_page.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/account/types/account_data.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/format.dart';

part 'settings.g.dart';

class SettingsStore extends _SettingsStore with _$SettingsStore {
  SettingsStore(AppStore store) : super(store);
}

abstract class _SettingsStore with Store {
  _SettingsStore(this.rootStore);

  final AppStore rootStore;

  final String localStorageLocaleKey = 'locale';
  final String localStorageEndpointKey = 'endpoint';
  final String localStorageSS58Key = 'custom_ss58';

  final String cacheNetworkStateKey = 'network';
  final String cacheNetworkConstKey = 'network_const';

  String _getCacheKeyOfNetwork(String key) {
    return '${endpoint.info}_$key';
  }

  /// The bazaar is not active currently. This variable can only be set under profile -> developer options.
  @observable
  bool enableBazaar = false;

  @observable
  String cachedPin = '';

  @observable
  bool loading = true;

  @observable
  String localeCode = '';

  @observable
  EndpointData endpoint = EndpointData();

  @observable
  Map<String, dynamic> customSS58Format = <String, dynamic>{};

  @observable
  String? networkName = '';

  @observable
  NetworkState? networkState;

  @observable
  Map? networkConst = {};

  @observable
  ObservableList<AccountData> contactList = ObservableList<AccountData>();

  @observable
  bool developerMode = false;

  @observable
  Locale locale = const Locale('en', '');

  @observable
  ThemeData theme = appThemeEncointer;

  @action
  void changeLang(BuildContext context, String? code) {
    switch (code) {
      case 'en':
        locale = const Locale('en', '');
        break;
      case 'de':
        locale = const Locale('de', '');
        break;
      default:
        locale = Localizations.localeOf(context);
    }
  }

  @action
  void changeTheme() {
    // todo: Remove this. It was for the network dependent theme.
    // But his can be done at the same time, when we refactor
    // the network selection page.
  }

  @computed
  bool get endpointIsEncointer {
    return endpoint.info == networkEndpointEncointerGesell.info ||
        endpoint.info == networkEndpointEncointerGesellDev.info ||
        endpoint.info == networkEndpointEncointerCantillon.info ||
        endpoint.info == networkEndpointEncointerCantillonDev.info;
  }

  @computed
  bool get endpointIsNoTee {
    return !endpointIsTeeProxy;
  }

  @computed
  bool get endpointIsTeeProxy {
    return endpoint.worker != null;
  }

  @computed
  String get ipfsGateway => endpoint.ipfsGateway!;

  @computed
  List<EndpointData> get endpointList {
    final ls = List<EndpointData>.of(networkEndpoints);
    ls.retainWhere((i) => i.info == endpoint.info);
    return ls;
  }

  @computed
  List<AccountData> get contactListAll {
    final ls = List<AccountData>.of(rootStore.account.accountList);
    ls.addAll(contactList);
    return ls;
  }

  @computed
  String get existentialDeposit {
    return Fmt.token(
        BigInt.parse(networkConst!['balances']['existentialDeposit'].toString()), networkState!.tokenDecimals);
  }

  @computed
  String get transactionBaseFee {
    return Fmt.token(BigInt.parse(networkConst!['transactionPayment']['transactionBaseFee'].toString()),
        networkState!.tokenDecimals);
  }

  @computed
  String get transactionByteFee {
    return Fmt.token(
        BigInt.parse(networkConst!['transactionPayment']['transactionByteFee'].toString()), networkState!.tokenDecimals,
        length: networkState!.tokenDecimals);
  }

  @action
  Future<void> init(String sysLocaleCode) async {
    await loadLocalCode();
    await loadEndpoint(sysLocaleCode);
    await Future.wait([
      loadCustomSS58Format(),
      loadNetworkStateCache(),
      loadContacts(),
    ]);
  }

  @action
  Future<void> setLocalCode(String code) async {
    await rootStore.localStorage.setObject(localStorageLocaleKey, code);
    localeCode = code;
  }

  @action
  void toggleDeveloperMode() {
    developerMode = !developerMode;
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

  @action
  void setNetworkName(String? name) {
    networkName = name;
    loading = false;
  }

  @action
  void setPin(String pin) {
    cachedPin = pin;
  }

  @computed
  bool get isConnected {
    return !loading && networkName!.isNotEmpty;
  }

  @action
  Future<void> setNetworkState(
    Map<String, dynamic> data, {
    bool needCache = true,
  }) async {
    networkState = NetworkState.fromJson(data);

    if (needCache) {
      rootStore.localStorage.setObject(
        _getCacheKeyOfNetwork(cacheNetworkStateKey),
        data,
      );
    }
  }

  @action
  Future<void> loadNetworkStateCache() async {
    final data = await Future.wait([
      rootStore.localStorage.getObject(_getCacheKeyOfNetwork(cacheNetworkStateKey)),
      rootStore.localStorage.getObject(_getCacheKeyOfNetwork(cacheNetworkConstKey)),
    ]);
    if (data[0] != null) {
      setNetworkState(Map<String, dynamic>.of(data[0] as Map<String, dynamic>), needCache: false);
    } else {
      setNetworkState({}, needCache: false);
    }

    if (data[1] != null) {
      setNetworkConst(Map<String, dynamic>.of(data[1] as Map<String, dynamic>), needCache: false);
    } else {
      setNetworkConst({}, needCache: false);
    }
  }

  @action
  Future<void> setNetworkConst(
    Map<String, dynamic> data, {
    bool needCache = true,
  }) async {
    networkConst = data;

    if (needCache) {
      rootStore.localStorage.setObject(
        _getCacheKeyOfNetwork(cacheNetworkConstKey),
        data,
      );
    }
  }

  @action
  Future<void> loadContacts() async {
    final ls = await rootStore.localStorage.getContactList();
    contactList = ObservableList.of(ls.map((i) => AccountData.fromJson(i)));
  }

  @action
  Future<void> addContact(Map<String, dynamic> con) async {
    await rootStore.localStorage.addContact(con);
    await loadContacts();
  }

  @action
  Future<void> removeContact(AccountData con) async {
    await rootStore.localStorage.removeContact(con.address);
    loadContacts();
  }

  @action
  Future<void> updateContact(Map<String, dynamic> con) async {
    await rootStore.localStorage.updateContact(con);
    loadContacts();
  }

  @action
  void setEndpoint(EndpointData value) {
    endpoint = value;
    rootStore.localStorage.setObject(localStorageEndpointKey, EndpointData.toJson(value));
  }

  @action
  Future<void> loadEndpoint(String sysLocaleCode) async {
    final value = await rootStore.localStorage.getObject(localStorageEndpointKey) as Map<String, dynamic>?;
    if (value == null) {
      endpoint = networkEndpointEncointerMainnet;
    } else {
      endpoint = EndpointData.fromJson(value);
    }
  }

  @action
  void setCustomSS58Format(Map<String, dynamic> value) {
    customSS58Format = value;
    rootStore.localStorage.setObject(localStorageSS58Key, value);
  }

  @action
  Future<void> loadCustomSS58Format() async {
    final ss58 = await rootStore.localStorage.getObject(localStorageSS58Key) as Map<String, dynamic>?;

    customSS58Format = ss58 ?? defaultSs58Prefix;
  }

  String getCacheKey(String key) {
    return '${endpoint.info}_$key';
  }

  Future<void> reloadNetwork(EndpointData network) async {
    setNetworkLoading(true);
    await setNetworkConst({}, needCache: false);
    setEndpoint(network);

    await Future.wait(<Future<void>>[
      rootStore.loadAccountCache(),
      loadNetworkStateCache(),
      rootStore.assets.loadCache(),
      rootStore.loadOrInitEncointerCache(network.info!),
    ]);

    // Todo: remove global reference when cyclic dependency
    // between the stores and the apis are resolved
    await webApi.close();
    return webApi.init();
  }
}

@JsonSerializable(createFactory: false)
class NetworkState extends _NetworkState {
  NetworkState(String? endpoint, int? ss58Format, int? tokenDecimals, String? tokenSymbol)
      : super(endpoint, ss58Format, tokenDecimals, tokenSymbol);

  // Todo: need to test after then fix by linter
  // ignore: prefer_constructors_over_static_methods
  static NetworkState fromJson(Map<String, dynamic> json) {
    // js-api changed the return type of 'api.rpc.system.properties()', such that multiple balances are supported.
    // Hence, tokenDecimals/-symbols are returned as a List. However, encointer currently only has one token, thus the
    // `NetworkState` should use the first token.
    final decimals = (json['tokenDecimals'] is List) ? json['tokenDecimals'][0] as int? : json['tokenDecimals'] as int?;
    final symbol = (json['tokenSymbol'] is List) ? json['tokenSymbol'][0] as String? : json['tokenSymbol'] as String?;

    final ns = NetworkState(json['endpoint'] as String?, json['ss58Format'] as int?, decimals, symbol);
    // --dev chain doesn't specify token symbol -> will break things if not specified
    if ((ns.tokenSymbol?.length ?? 0) < 1) {
      ns.tokenSymbol = 'ERT';
    }
    return ns;
  }

  static Map<String, dynamic> toJson(NetworkState net) => _$NetworkStateToJson(net);
}

// TODO: these were empty before, but had to add defaults for development chain
abstract class _NetworkState {
  _NetworkState(this.endpoint, this.ss58Format, this.tokenDecimals, this.tokenSymbol);

  String? endpoint = '';
  int? ss58Format = 42;
  int? tokenDecimals = 12;
  String? tokenSymbol = 'ERT';
}

@JsonSerializable(explicitToJson: true)
class EndpointData extends _EndpointData {
  static EndpointData fromJson(Map<String, dynamic> json) => _$EndpointDataFromJson(json);
  static Map<String, dynamic> toJson(EndpointData data) => _$EndpointDataToJson(data);
}

abstract class _EndpointData {
  String? color = 'pink';
  String? info = '';
  int? ss58 = 42;
  String? text = '';
  String? value = '';
  String? worker = ''; // only relevant for cantillon
  String? mrenclave = ''; // relevant until we fetch mrenclave from substrateeRegistry
  NodeConfig? overrideConfig;
  String? ipfsGateway = '';
}
