import 'package:encointer_wallet/common/data/substrate_api/api.dart';
import 'package:encointer_wallet/extras/config/build_options.dart';
import 'package:encointer_wallet/presentation/account/types/account_data.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service_locator/service_locator.dart';
import 'package:encointer_wallet/store/app_store.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';

import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/common/constants/consts.dart';
import 'package:encointer_wallet/common/nodes/node.dart';
import 'package:encointer_wallet/page/profile/settings/ss58_prefix_list_page.dart';

part 'settings_store.g.dart';

const _tag = 'settings_store';

class SettingsStore extends _SettingsStore with _$SettingsStore {}

abstract class _SettingsStore with Store {
  _SettingsStore() : appStore = sl.get<AppStore>();

  final AppStore appStore;

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
    Log.d('changeLang, code = $code', _tag);
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
    final ls = List<EndpointData>.of(networkEndpoints)..retainWhere((i) => i.info == endpoint.info);
    return ls;
  }

  @computed
  List<AccountData> get contactListAll {
    final ls = List<AccountData>.of(appStore.account.accountList)..addAll(contactList);
    return ls;
  }

  @action
  Future<void> init() async {
    Log.d('init', _tag);
    await loadLocalCode();
    await loadEndpoint();
    await Future.wait([
      loadCustomSS58Format(),
      loadNetworkStateCache(),
      loadContacts(),
    ]);
  }

  @action
  Future<void> setLocalCode(String code) async {
    Log.d('setLocalCode, code = $code', _tag);
    await appStore.localStorage.setObject(localStorageLocaleKey, code);
    localeCode = code;
  }

  @action
  void toggleDeveloperMode() {
    Log.d('toggleDeveloperMode', _tag);
    developerMode = !developerMode;
  }

  @action
  void toggleEnableBazaar() {
    Log.d('toggleEnableBazaar', _tag);
    enableBazaar = !enableBazaar;
  }

  @action
  Future<void> loadLocalCode() async {
    Log.d('loadLocalCode', _tag);
    final stored = await appStore.localStorage.getObject(localStorageLocaleKey) as String?;
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
    Log.d('setNetworkState, data = $data, needCache = $needCache', _tag);
    networkState = NetworkState.fromJson(data);

    if (needCache) {
      await appStore.localStorage.setObject(
        _getCacheKeyOfNetwork(cacheNetworkStateKey),
        data,
      );
    }
  }

  @action
  Future<void> loadNetworkStateCache() async {
    Log.d('loadNetworkStateCache', _tag);
    final data = await Future.wait([
      appStore.localStorage.getObject(_getCacheKeyOfNetwork(cacheNetworkStateKey)),
      appStore.localStorage.getObject(_getCacheKeyOfNetwork(cacheNetworkConstKey)),
    ]);
    if (data[0] != null) {
      await setNetworkState(Map<String, dynamic>.of(data[0]! as Map<String, dynamic>), needCache: false);
    } else {
      await setNetworkState({}, needCache: false);
    }

    if (data[1] != null) {
      await setNetworkConst(Map<String, dynamic>.of(data[1]! as Map<String, dynamic>), needCache: false);
    } else {
      await setNetworkConst({}, needCache: false);
    }
  }

  @action
  Future<void> setNetworkConst(
    Map<String, dynamic> data, {
    bool needCache = true,
  }) async {
    Log.d('setNetworkConst, data = $data, needCache = $needCache', _tag);
    networkConst = data;

    if (needCache) {
      await appStore.localStorage.setObject(
        _getCacheKeyOfNetwork(cacheNetworkConstKey),
        data,
      );
    }
  }

  @action
  Future<void> loadContacts() async {
    Log.d('loadContacts', _tag);
    final ls = await appStore.localStorage.getContactList();
    contactList = ObservableList.of(ls.map(AccountData.fromJson));
  }

  @action
  Future<void> addContact(Map<String, dynamic> con) async {
    Log.d('addContact', _tag);
    await appStore.localStorage.addContact(con);
    await loadContacts();
  }

  @action
  Future<void> removeContact(AccountData con) async {
    Log.d('removeContact, contact = $con', _tag);
    await appStore.localStorage.removeContact(con.address);
    await loadContacts();
  }

  @action
  Future<void> updateContact(Map<String, dynamic> con) async {
    Log.d('updateContact, contact = $con', _tag);
    await appStore.localStorage.updateContact(con);
    await loadContacts();
  }

  @action
  void setEndpoint(EndpointData value) {
    Log.d('setEndpoint, endpointData = $value', _tag);
    endpoint = value;
    appStore.localStorage.setObject(localStorageEndpointKey, EndpointData.toJson(value));
  }

  @action
  Future<void> loadEndpoint() async {
    Log.d('loadEndpoint', _tag);
    final value = await appStore.localStorage.getObject(localStorageEndpointKey) as Map<String, dynamic>?;
    if (value == null) {
      endpoint = networkEndpointEncointerMainnet;
    } else {
      endpoint = buildConfig.endpoint;
    }
  }

  @action
  void setCustomSS58Format(Map<String, dynamic> value) {
    Log.d('setCustomSS58Format, value = $value', _tag);
    customSS58Format = value;
    appStore.localStorage.setObject(localStorageSS58Key, value);
  }

  @action
  Future<void> loadCustomSS58Format() async {
    Log.d('loadEndpoint', _tag);
    final ss58 = await appStore.localStorage.getObject(localStorageSS58Key) as Map<String, dynamic>?;

    customSS58Format = ss58 ?? defaultSs58Prefix;
  }

  String getCacheKey(String key) {
    Log.d('getCacheKey, key = $key', _tag);
    return '${endpoint.info}_$key';
  }

  Future<void> reloadNetwork(EndpointData network) async {
    Log.d('reloadNetwork', _tag);
    setNetworkLoading(true);
    await setNetworkConst({}, needCache: false);
    setEndpoint(network);

    await Future.wait(<Future<void>>[
      appStore.loadAccountCache(),
      loadNetworkStateCache(),
      appStore.assets.loadCache(),
      appStore.loadOrInitEncointerCache(network.info!),
    ]);

    // Todo: remove global reference when cyclic dependency
    // between the stores and the apis are resolved
    await webApi.close();
    return webApi.init();
  }
}

@JsonSerializable(createFactory: false)
class NetworkState extends _NetworkState {
  NetworkState(super.endpoint, super.ss58Format, super.tokenDecimals, super.tokenSymbol);

  // Todo: need to test after then fix by linter
  // ignore: prefer_constructors_over_static_methods
  static NetworkState fromJson(Map<String, dynamic> json) {
    // js-api changed the return type of 'api.rpc.system.properties()', such that multiple balances are supported.
    // Hence, tokenDecimals/-symbols are returned as a List. However, encointer currently only has one token, thus the
    // `NetworkState` should use the first token.
    final decimals = (json['tokenDecimals'] is List)
        ? (json['tokenDecimals'] as List<dynamic>)[0] as int?
        : json['tokenDecimals'] as int?;
    final symbol = (json['tokenSymbol'] is List)
        ? (json['tokenSymbol'] as List<dynamic>)[0] as String?
        : json['tokenSymbol'] as String?;

    final ns = NetworkState(json['endpoint'] as String?, json['ss58Format'] as int?, decimals, symbol);
    // --dev chain doesn't specify token symbol -> will break things if not specified
    if ((ns.tokenSymbol?.length ?? 0) < 1) ns.tokenSymbol = 'ERT';

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
