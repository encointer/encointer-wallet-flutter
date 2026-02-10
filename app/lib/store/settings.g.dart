// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SettingsStore on _SettingsStore, Store {
  Computed<bool>? _$endpointIsNoTeeComputed;

  @override
  bool get endpointIsNoTee =>
      (_$endpointIsNoTeeComputed ??= Computed<bool>(() => super.endpointIsNoTee,
              name: '_SettingsStore.endpointIsNoTee'))
          .value;
  Computed<String>? _$ipfsGatewayComputed;

  @override
  String get ipfsGateway =>
      (_$ipfsGatewayComputed ??= Computed<String>(() => super.ipfsGateway,
              name: '_SettingsStore.ipfsGateway'))
          .value;
  Computed<List<AccountData>>? _$knownAccountsComputed;

  @override
  List<AccountData> get knownAccounts => (_$knownAccountsComputed ??=
          Computed<List<AccountData>>(() => super.knownAccounts,
              name: '_SettingsStore.knownAccounts'))
      .value;
  Computed<bool>? _$isConnectedComputed;

  @override
  bool get isConnected =>
      (_$isConnectedComputed ??= Computed<bool>(() => super.isConnected,
              name: '_SettingsStore.isConnected'))
          .value;

  late final _$loadingAtom =
      Atom(name: '_SettingsStore.loading', context: context);

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  late final _$localeCodeAtom =
      Atom(name: '_SettingsStore.localeCode', context: context);

  @override
  String get localeCode {
    _$localeCodeAtom.reportRead();
    return super.localeCode;
  }

  @override
  set localeCode(String value) {
    _$localeCodeAtom.reportWrite(value, super.localeCode, () {
      super.localeCode = value;
    });
  }

  late final _$currentNetworkAtom =
      Atom(name: '_SettingsStore.currentNetwork', context: context);

  @override
  Network get currentNetwork {
    _$currentNetworkAtom.reportRead();
    return super.currentNetwork;
  }

  @override
  set currentNetwork(Network value) {
    _$currentNetworkAtom.reportWrite(value, super.currentNetwork, () {
      super.currentNetwork = value;
    });
  }

  late final _$ksmMockSwapEnabledAtom =
      Atom(name: '_SettingsStore.ksmMockSwapEnabled', context: context);

  @override
  bool get ksmMockSwapEnabled {
    _$ksmMockSwapEnabledAtom.reportRead();
    return super.ksmMockSwapEnabled;
  }

  @override
  set ksmMockSwapEnabled(bool value) {
    _$ksmMockSwapEnabledAtom.reportWrite(value, super.ksmMockSwapEnabled, () {
      super.ksmMockSwapEnabled = value;
    });
  }

  late final _$usdcMockSwapEnabledAtom =
      Atom(name: '_SettingsStore.usdcMockSwapEnabled', context: context);

  @override
  bool get usdcMockSwapEnabled {
    _$usdcMockSwapEnabledAtom.reportRead();
    return super.usdcMockSwapEnabled;
  }

  @override
  set usdcMockSwapEnabled(bool value) {
    _$usdcMockSwapEnabledAtom.reportWrite(value, super.usdcMockSwapEnabled, () {
      super.usdcMockSwapEnabled = value;
    });
  }

  late final _$contactListAtom =
      Atom(name: '_SettingsStore.contactList', context: context);

  @override
  ObservableList<AccountData> get contactList {
    _$contactListAtom.reportRead();
    return super.contactList;
  }

  @override
  set contactList(ObservableList<AccountData> value) {
    _$contactListAtom.reportWrite(value, super.contactList, () {
      super.contactList = value;
    });
  }

  late final _$initAsyncAction =
      AsyncAction('_SettingsStore.init', context: context);

  @override
  Future<void> init(String sysLocaleCode) {
    return _$initAsyncAction.run(() => super.init(sysLocaleCode));
  }

  late final _$setLocalCodeAsyncAction =
      AsyncAction('_SettingsStore.setLocalCode', context: context);

  @override
  Future<void> setLocalCode(String code) {
    return _$setLocalCodeAsyncAction.run(() => super.setLocalCode(code));
  }

  late final _$loadLocalCodeAsyncAction =
      AsyncAction('_SettingsStore.loadLocalCode', context: context);

  @override
  Future<void> loadLocalCode() {
    return _$loadLocalCodeAsyncAction.run(() => super.loadLocalCode());
  }

  late final _$loadContactsAsyncAction =
      AsyncAction('_SettingsStore.loadContacts', context: context);

  @override
  Future<void> loadContacts() {
    return _$loadContactsAsyncAction.run(() => super.loadContacts());
  }

  late final _$addContactAsyncAction =
      AsyncAction('_SettingsStore.addContact', context: context);

  @override
  Future<void> addContact(Map<String, dynamic> con) {
    return _$addContactAsyncAction.run(() => super.addContact(con));
  }

  late final _$removeContactAsyncAction =
      AsyncAction('_SettingsStore.removeContact', context: context);

  @override
  Future<void> removeContact(AccountData con) {
    return _$removeContactAsyncAction.run(() => super.removeContact(con));
  }

  late final _$updateContactAsyncAction =
      AsyncAction('_SettingsStore.updateContact', context: context);

  @override
  Future<void> updateContact(Map<String, dynamic> con) {
    return _$updateContactAsyncAction.run(() => super.updateContact(con));
  }

  late final _$loadEndpointAsyncAction =
      AsyncAction('_SettingsStore.loadEndpoint', context: context);

  @override
  Future<void> loadEndpoint(String sysLocaleCode) {
    return _$loadEndpointAsyncAction
        .run(() => super.loadEndpoint(sysLocaleCode));
  }

  late final _$_SettingsStoreActionController =
      ActionController(name: '_SettingsStore', context: context);

  @override
  void toggleKsmMockSwapEnabled() {
    final _$actionInfo = _$_SettingsStoreActionController.startAction(
        name: '_SettingsStore.toggleKsmMockSwapEnabled');
    try {
      return super.toggleKsmMockSwapEnabled();
    } finally {
      _$_SettingsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleUsdcMockSwapEnabled() {
    final _$actionInfo = _$_SettingsStoreActionController.startAction(
        name: '_SettingsStore.toggleUsdcMockSwapEnabled');
    try {
      return super.toggleUsdcMockSwapEnabled();
    } finally {
      _$_SettingsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNetworkLoading(bool isLoading) {
    final _$actionInfo = _$_SettingsStoreActionController.startAction(
        name: '_SettingsStore.setNetworkLoading');
    try {
      return super.setNetworkLoading(isLoading);
    } finally {
      _$_SettingsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNetwork(Network network) {
    final _$actionInfo = _$_SettingsStoreActionController.startAction(
        name: '_SettingsStore.setNetwork');
    try {
      return super.setNetwork(network);
    } finally {
      _$_SettingsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loading: ${loading},
localeCode: ${localeCode},
currentNetwork: ${currentNetwork},
ksmMockSwapEnabled: ${ksmMockSwapEnabled},
usdcMockSwapEnabled: ${usdcMockSwapEnabled},
contactList: ${contactList},
endpointIsNoTee: ${endpointIsNoTee},
ipfsGateway: ${ipfsGateway},
knownAccounts: ${knownAccounts},
isConnected: ${isConnected}
    ''';
  }
}
