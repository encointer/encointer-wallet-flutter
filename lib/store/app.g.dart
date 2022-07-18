// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AppStore on _AppStore, Store {
  late final _$settingsAtom = Atom(name: '_AppStore.settings', context: context);

  @override
  SettingsStore? get settings {
    _$settingsAtom.reportRead();
    return super.settings;
  }

  @override
  set settings(SettingsStore? value) {
    _$settingsAtom.reportWrite(value, super.settings, () {
      super.settings = value;
    });
  }

  late final _$accountAtom = Atom(name: '_AppStore.account', context: context);

  @override
  AccountStore? get account {
    _$accountAtom.reportRead();
    return super.account;
  }

  @override
  set account(AccountStore? value) {
    _$accountAtom.reportWrite(value, super.account, () {
      super.account = value;
    });
  }

  late final _$assetsAtom = Atom(name: '_AppStore.assets', context: context);

  @override
  AssetsStore? get assets {
    _$assetsAtom.reportRead();
    return super.assets;
  }

  @override
  set assets(AssetsStore? value) {
    _$assetsAtom.reportWrite(value, super.assets, () {
      super.assets = value;
    });
  }

  late final _$chainAtom = Atom(name: '_AppStore.chain', context: context);

  @override
  ChainStore? get chain {
    _$chainAtom.reportRead();
    return super.chain;
  }

  @override
  set chain(ChainStore? value) {
    _$chainAtom.reportWrite(value, super.chain, () {
      super.chain = value;
    });
  }

  late final _$encointerAtom = Atom(name: '_AppStore.encointer', context: context);

  @override
  EncointerStore? get encointer {
    _$encointerAtom.reportRead();
    return super.encointer;
  }

  @override
  set encointer(EncointerStore? value) {
    _$encointerAtom.reportWrite(value, super.encointer, () {
      super.encointer = value;
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

  late final _$initAsyncAction = AsyncAction('_AppStore.init', context: context);

  @override
  Future<void> init(String sysLocaleCode) {
    return _$initAsyncAction.run(() => super.init(sysLocaleCode));
  }

  @override
  String toString() {
    return '''
settings: ${settings},
account: ${account},
assets: ${assets},
chain: ${chain},
encointer: ${encointer},
isReady: ${isReady}
    ''';
  }
}
