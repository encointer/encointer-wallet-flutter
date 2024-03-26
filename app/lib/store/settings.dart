import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';

import 'package:encointer_wallet/config/consts.dart';
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
  final String localStorageEndpointKey = 'endpoint';

  /// The bazaar is not active currently. This variable can only be set under profile -> developer options.
  @observable
  bool enableBazaar = false;

  @observable
  bool loading = true;

  @observable
  String localeCode = '';

  @observable
  EndpointData endpoint = networkEndpointEncointerMainnet;

  @observable
  ObservableList<AccountData> contactList = ObservableList<AccountData>();

  @observable
  Locale locale = const Locale('en', '');

  @action
  void changeLang(BuildContext context, String? code) {
    locale = switch (code) {
      'en' => const Locale('en', ''),
      'de' => const Locale('de', ''),
      _ => Localizations.localeOf(context),
    };
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

  String getCacheKey(String key) {
    return '${endpoint.info}_$key';
  }

  Future<void> reloadNetwork(EndpointData network) async {
    // Stop networking before loading cache
    await webApi.close();

    setEndpoint(network);

    // load cache before starting networking again
    await Future.wait(<Future<void>>[
      rootStore.loadAccountCache(),
      rootStore.assets.loadCache(),
      rootStore.chain.loadCache(),
      rootStore.loadOrInitEncointerCache(network.info!),
    ]);

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
  String? ipfsGateway = '';
}
