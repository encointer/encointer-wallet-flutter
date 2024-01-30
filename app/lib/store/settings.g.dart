// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$NetworkStateToJson(NetworkState instance) => <String, dynamic>{
      'endpoint': instance.endpoint,
      'ss58Format': instance.ss58Format,
      'tokenDecimals': instance.tokenDecimals,
      'tokenSymbol': instance.tokenSymbol,
    };

EndpointData _$EndpointDataFromJson(Map<String, dynamic> json) => EndpointData()
  ..color = json['color'] as String?
  ..info = json['info'] as String?
  ..ss58 = json['ss58'] as int?
  ..text = json['text'] as String?
  ..value = json['value'] as String?
  ..worker = json['worker'] as String?
  ..mrenclave = json['mrenclave'] as String?
  ..ipfsGateway = json['ipfsGateway'] as String?;

Map<String, dynamic> _$EndpointDataToJson(EndpointData instance) => <String, dynamic>{
      'color': instance.color,
      'info': instance.info,
      'ss58': instance.ss58,
      'text': instance.text,
      'value': instance.value,
      'worker': instance.worker,
      'mrenclave': instance.mrenclave,
      'ipfsGateway': instance.ipfsGateway,
    };

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SettingsStore on _SettingsStore, Store {
  Computed<bool>? _$endpointIsEncointerComputed;

  @override
  bool get endpointIsEncointer => (_$endpointIsEncointerComputed ??=
          Computed<bool>(() => super.endpointIsEncointer, name: '_SettingsStore.endpointIsEncointer'))
      .value;
  Computed<bool>? _$endpointIsNoTeeComputed;

  @override
  bool get endpointIsNoTee => (_$endpointIsNoTeeComputed ??=
          Computed<bool>(() => super.endpointIsNoTee, name: '_SettingsStore.endpointIsNoTee'))
      .value;
  Computed<bool>? _$endpointIsTeeProxyComputed;

  @override
  bool get endpointIsTeeProxy => (_$endpointIsTeeProxyComputed ??=
          Computed<bool>(() => super.endpointIsTeeProxy, name: '_SettingsStore.endpointIsTeeProxy'))
      .value;
  Computed<String>? _$ipfsGatewayComputed;

  @override
  String get ipfsGateway =>
      (_$ipfsGatewayComputed ??= Computed<String>(() => super.ipfsGateway, name: '_SettingsStore.ipfsGateway')).value;
  Computed<List<EndpointData>>? _$endpointListComputed;

  @override
  List<EndpointData> get endpointList => (_$endpointListComputed ??=
          Computed<List<EndpointData>>(() => super.endpointList, name: '_SettingsStore.endpointList'))
      .value;
  Computed<List<AccountData>>? _$knownAccountsComputed;

  @override
  List<AccountData> get knownAccounts => (_$knownAccountsComputed ??=
          Computed<List<AccountData>>(() => super.knownAccounts, name: '_SettingsStore.knownAccounts'))
      .value;
  Computed<bool>? _$isConnectedComputed;

  @override
  bool get isConnected =>
      (_$isConnectedComputed ??= Computed<bool>(() => super.isConnected, name: '_SettingsStore.isConnected')).value;

  late final _$enableBazaarAtom = Atom(name: '_SettingsStore.enableBazaar', context: context);

  @override
  bool get enableBazaar {
    _$enableBazaarAtom.reportRead();
    return super.enableBazaar;
  }

  @override
  set enableBazaar(bool value) {
    _$enableBazaarAtom.reportWrite(value, super.enableBazaar, () {
      super.enableBazaar = value;
    });
  }

  late final _$loadingAtom = Atom(name: '_SettingsStore.loading', context: context);

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

  late final _$localeCodeAtom = Atom(name: '_SettingsStore.localeCode', context: context);

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

  late final _$endpointAtom = Atom(name: '_SettingsStore.endpoint', context: context);

  @override
  EndpointData get endpoint {
    _$endpointAtom.reportRead();
    return super.endpoint;
  }

  @override
  set endpoint(EndpointData value) {
    _$endpointAtom.reportWrite(value, super.endpoint, () {
      super.endpoint = value;
    });
  }

  late final _$customSS58FormatAtom = Atom(name: '_SettingsStore.customSS58Format', context: context);

  @override
  Map<String, dynamic> get customSS58Format {
    _$customSS58FormatAtom.reportRead();
    return super.customSS58Format;
  }

  @override
  set customSS58Format(Map<String, dynamic> value) {
    _$customSS58FormatAtom.reportWrite(value, super.customSS58Format, () {
      super.customSS58Format = value;
    });
  }

  late final _$contactListAtom = Atom(name: '_SettingsStore.contactList', context: context);

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

  late final _$localeAtom = Atom(name: '_SettingsStore.locale', context: context);

  @override
  Locale get locale {
    _$localeAtom.reportRead();
    return super.locale;
  }

  @override
  set locale(Locale value) {
    _$localeAtom.reportWrite(value, super.locale, () {
      super.locale = value;
    });
  }

  late final _$initAsyncAction = AsyncAction('_SettingsStore.init', context: context);

  @override
  Future<void> init(String sysLocaleCode) {
    return _$initAsyncAction.run(() => super.init(sysLocaleCode));
  }

  late final _$setLocalCodeAsyncAction = AsyncAction('_SettingsStore.setLocalCode', context: context);

  @override
  Future<void> setLocalCode(String code) {
    return _$setLocalCodeAsyncAction.run(() => super.setLocalCode(code));
  }

  late final _$loadLocalCodeAsyncAction = AsyncAction('_SettingsStore.loadLocalCode', context: context);

  @override
  Future<void> loadLocalCode() {
    return _$loadLocalCodeAsyncAction.run(() => super.loadLocalCode());
  }

  late final _$loadContactsAsyncAction = AsyncAction('_SettingsStore.loadContacts', context: context);

  @override
  Future<void> loadContacts() {
    return _$loadContactsAsyncAction.run(() => super.loadContacts());
  }

  late final _$addContactAsyncAction = AsyncAction('_SettingsStore.addContact', context: context);

  @override
  Future<void> addContact(Map<String, dynamic> con) {
    return _$addContactAsyncAction.run(() => super.addContact(con));
  }

  late final _$removeContactAsyncAction = AsyncAction('_SettingsStore.removeContact', context: context);

  @override
  Future<void> removeContact(AccountData con) {
    return _$removeContactAsyncAction.run(() => super.removeContact(con));
  }

  late final _$updateContactAsyncAction = AsyncAction('_SettingsStore.updateContact', context: context);

  @override
  Future<void> updateContact(Map<String, dynamic> con) {
    return _$updateContactAsyncAction.run(() => super.updateContact(con));
  }

  late final _$loadEndpointAsyncAction = AsyncAction('_SettingsStore.loadEndpoint', context: context);

  @override
  Future<void> loadEndpoint(String sysLocaleCode) {
    return _$loadEndpointAsyncAction.run(() => super.loadEndpoint(sysLocaleCode));
  }

  late final _$loadCustomSS58FormatAsyncAction = AsyncAction('_SettingsStore.loadCustomSS58Format', context: context);

  @override
  Future<void> loadCustomSS58Format() {
    return _$loadCustomSS58FormatAsyncAction.run(() => super.loadCustomSS58Format());
  }

  late final _$_SettingsStoreActionController = ActionController(name: '_SettingsStore', context: context);

  @override
  void changeLang(BuildContext context, String? code) {
    final _$actionInfo = _$_SettingsStoreActionController.startAction(name: '_SettingsStore.changeLang');
    try {
      return super.changeLang(context, code);
    } finally {
      _$_SettingsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleEnableBazaar() {
    final _$actionInfo = _$_SettingsStoreActionController.startAction(name: '_SettingsStore.toggleEnableBazaar');
    try {
      return super.toggleEnableBazaar();
    } finally {
      _$_SettingsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNetworkLoading(bool isLoading) {
    final _$actionInfo = _$_SettingsStoreActionController.startAction(name: '_SettingsStore.setNetworkLoading');
    try {
      return super.setNetworkLoading(isLoading);
    } finally {
      _$_SettingsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNetworkName(String? name) {
    final _$actionInfo = _$_SettingsStoreActionController.startAction(name: '_SettingsStore.setNetworkName');
    try {
      return super.setNetworkName(name);
    } finally {
      _$_SettingsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEndpoint(EndpointData value) {
    final _$actionInfo = _$_SettingsStoreActionController.startAction(name: '_SettingsStore.setEndpoint');
    try {
      return super.setEndpoint(value);
    } finally {
      _$_SettingsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCustomSS58Format(Map<String, dynamic> value) {
    final _$actionInfo = _$_SettingsStoreActionController.startAction(name: '_SettingsStore.setCustomSS58Format');
    try {
      return super.setCustomSS58Format(value);
    } finally {
      _$_SettingsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
enableBazaar: ${enableBazaar},
loading: ${loading},
localeCode: ${localeCode},
endpoint: ${endpoint},
customSS58Format: ${customSS58Format},
contactList: ${contactList},
locale: ${locale},
endpointIsEncointer: ${endpointIsEncointer},
endpointIsNoTee: ${endpointIsNoTee},
endpointIsTeeProxy: ${endpointIsTeeProxy},
ipfsGateway: ${ipfsGateway},
endpointList: ${endpointList},
knownAccounts: ${knownAccounts},
isConnected: ${isConnected}
    ''';
  }
}
