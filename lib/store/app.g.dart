// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AppStore on _AppStore, Store {
  late final _$_settingsAtom = Atom(name: '_AppStore._settings', context: context);

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

  late final _$_accountAtom = Atom(name: '_AppStore._account', context: context);

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

  late final _$_encointerAtom = Atom(name: '_AppStore._encointer', context: context);

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

  late final _$isReadyAtom = Atom(name: '_AppStore.isReady', context: context);

  @override
  bool get isReady {
    _$isReadyAtom.reportRead();
    return super.isReady;
  }

  @override
  set isReady(bool value) {
    _$isReadyAtom.reportWrite(value, super.isReady, () {
      super.isReady = value;
    });
  }

  late final _$appIsReadyAtom = Atom(name: '_AppStore.appIsReady', context: context);

  @override
  bool get appIsReady {
    _$appIsReadyAtom.reportRead();
    return super.appIsReady;
  }

  @override
  set appIsReady(bool value) {
    _$appIsReadyAtom.reportWrite(value, super.appIsReady, () {
      super.appIsReady = value;
    });
  }

  late final _$initAsyncAction = AsyncAction('_AppStore.init', context: context);

  @override
  Future<void> init(String sysLocaleCode) {
    return _$initAsyncAction.run(() => super.init(sysLocaleCode));
  }

  @override
  String toString() {
    return '''
isReady: ${isReady},
appIsReady: ${appIsReady}
    ''';
  }
}
