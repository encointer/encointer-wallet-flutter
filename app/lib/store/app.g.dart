// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AppStore<S extends SecureStorageInterface,
    L extends LegacyStorageInterface> on _AppStore<S, L>, Store {
  Computed<DataUpdateStore>? _$dataUpdateComputed;

  @override
  DataUpdateStore get dataUpdate => (_$dataUpdateComputed ??=
          Computed<DataUpdateStore>(() => super.dataUpdate,
              name: '_AppStore.dataUpdate'))
      .value;
  Computed<AccountStore>? _$accountComputed;

  @override
  AccountStore get account =>
      (_$accountComputed ??= Computed<AccountStore>(() => super.account,
              name: '_AppStore.account'))
          .value;
  Computed<AssetsStore>? _$assetsComputed;

  @override
  AssetsStore get assets => (_$assetsComputed ??=
          Computed<AssetsStore>(() => super.assets, name: '_AppStore.assets'))
      .value;
  Computed<ChainStore>? _$chainComputed;

  @override
  ChainStore get chain => (_$chainComputed ??=
          Computed<ChainStore>(() => super.chain, name: '_AppStore.chain'))
      .value;
  Computed<EncointerStore>? _$encointerComputed;

  @override
  EncointerStore get encointer =>
      (_$encointerComputed ??= Computed<EncointerStore>(() => super.encointer,
              name: '_AppStore.encointer'))
          .value;
  Computed<OfflinePaymentStore>? _$offlinePaymentComputed;

  @override
  OfflinePaymentStore get offlinePayment => (_$offlinePaymentComputed ??=
          Computed<OfflinePaymentStore>(() => super.offlinePayment,
              name: '_AppStore.offlinePayment'))
      .value;
  Computed<bool>? _$appIsReadyComputed;

  @override
  bool get appIsReady => (_$appIsReadyComputed ??=
          Computed<bool>(() => super.appIsReady, name: '_AppStore.appIsReady'))
      .value;

  late final _$_settingsAtom =
      Atom(name: '_AppStore._settings', context: context);

  @override
  SettingsStore? get _settings {
    _$_settingsAtom.reportRead();
    return super._settings;
  }

  @override
  set _settings(SettingsStore? value) {
    _$_settingsAtom.reportWrite(value, super._settings, () {
      super._settings = value;
    });
  }

  late final _$_dataUpdateAtom =
      Atom(name: '_AppStore._dataUpdate', context: context);

  @override
  DataUpdateStore? get _dataUpdate {
    _$_dataUpdateAtom.reportRead();
    return super._dataUpdate;
  }

  @override
  set _dataUpdate(DataUpdateStore? value) {
    _$_dataUpdateAtom.reportWrite(value, super._dataUpdate, () {
      super._dataUpdate = value;
    });
  }

  late final _$_accountAtom =
      Atom(name: '_AppStore._account', context: context);

  @override
  AccountStore? get _account {
    _$_accountAtom.reportRead();
    return super._account;
  }

  @override
  set _account(AccountStore? value) {
    _$_accountAtom.reportWrite(value, super._account, () {
      super._account = value;
    });
  }

  late final _$_assetsAtom = Atom(name: '_AppStore._assets', context: context);

  @override
  AssetsStore? get _assets {
    _$_assetsAtom.reportRead();
    return super._assets;
  }

  @override
  set _assets(AssetsStore? value) {
    _$_assetsAtom.reportWrite(value, super._assets, () {
      super._assets = value;
    });
  }

  late final _$_chainAtom = Atom(name: '_AppStore._chain', context: context);

  @override
  ChainStore? get _chain {
    _$_chainAtom.reportRead();
    return super._chain;
  }

  @override
  set _chain(ChainStore? value) {
    _$_chainAtom.reportWrite(value, super._chain, () {
      super._chain = value;
    });
  }

  late final _$_encointerAtom =
      Atom(name: '_AppStore._encointer', context: context);

  @override
  EncointerStore? get _encointer {
    _$_encointerAtom.reportRead();
    return super._encointer;
  }

  @override
  set _encointer(EncointerStore? value) {
    _$_encointerAtom.reportWrite(value, super._encointer, () {
      super._encointer = value;
    });
  }

  late final _$_offlinePaymentAtom =
      Atom(name: '_AppStore._offlinePayment', context: context);

  @override
  OfflinePaymentStore? get _offlinePayment {
    _$_offlinePaymentAtom.reportRead();
    return super._offlinePayment;
  }

  @override
  set _offlinePayment(OfflinePaymentStore? value) {
    _$_offlinePaymentAtom.reportWrite(value, super._offlinePayment, () {
      super._offlinePayment = value;
    });
  }

  late final _$storeIsReadyAtom =
      Atom(name: '_AppStore.storeIsReady', context: context);

  @override
  bool get storeIsReady {
    _$storeIsReadyAtom.reportRead();
    return super.storeIsReady;
  }

  @override
  set storeIsReady(bool value) {
    _$storeIsReadyAtom.reportWrite(value, super.storeIsReady, () {
      super.storeIsReady = value;
    });
  }

  late final _$webApiIsReadyAtom =
      Atom(name: '_AppStore.webApiIsReady', context: context);

  @override
  bool get webApiIsReady {
    _$webApiIsReadyAtom.reportRead();
    return super.webApiIsReady;
  }

  @override
  set webApiIsReady(bool value) {
    _$webApiIsReadyAtom.reportWrite(value, super.webApiIsReady, () {
      super.webApiIsReady = value;
    });
  }

  late final _$initAsyncAction =
      AsyncAction('_AppStore.init', context: context);

  @override
  Future<void> init(String sysLocaleCode) {
    return _$initAsyncAction.run(() => super.init(sysLocaleCode));
  }

  late final _$_AppStoreActionController =
      ActionController(name: '_AppStore', context: context);

  @override
  void setApiReady(bool value) {
    final _$actionInfo =
        _$_AppStoreActionController.startAction(name: '_AppStore.setApiReady');
    try {
      return super.setApiReady(value);
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
storeIsReady: ${storeIsReady},
webApiIsReady: ${webApiIsReady},
dataUpdate: ${dataUpdate},
account: ${account},
assets: ${assets},
chain: ${chain},
encointer: ${encointer},
offlinePayment: ${offlinePayment},
appIsReady: ${appIsReady}
    ''';
  }
}
