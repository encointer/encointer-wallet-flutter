// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_create_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AccountCreate on _AccountCreate, Store {
  late final _$nameAtom = Atom(name: '_AccountCreate.name', context: context);

  @override
  String? get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String? value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  late final _$accountKeyAtom = Atom(name: '_AccountCreate.accountKey', context: context);

  @override
  String? get accountKey {
    _$accountKeyAtom.reportRead();
    return super.accountKey;
  }

  @override
  set accountKey(String? value) {
    _$accountKeyAtom.reportWrite(value, super.accountKey, () {
      super.accountKey = value;
    });
  }

  late final _$keyTypeAtom = Atom(name: '_AccountCreate.keyType', context: context);

  @override
  KeyType get keyType {
    _$keyTypeAtom.reportRead();
    return super.keyType;
  }

  @override
  set keyType(KeyType value) {
    _$keyTypeAtom.reportWrite(value, super.keyType, () {
      super.keyType = value;
    });
  }

  late final _$loadingAtom = Atom(name: '_AccountCreate.loading', context: context);

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

  late final _$generateAccountAsyncAction = AsyncAction('_AccountCreate.generateAccount', context: context);

  @override
  Future<void> generateAccount(
      {required BuildContext context, required AppStore appStore, required Api webApi, required String password}) {
    return _$generateAccountAsyncAction
        .run(() => super.generateAccount(context: context, appStore: appStore, webApi: webApi, password: password));
  }

  late final _$genarateAddAccountAsyncAction = AsyncAction('_AccountCreate.genarateAddAccount', context: context);

  @override
  Future<void> genarateAddAccount(
      {required BuildContext context, required AppStore appStore, required Api webApi, required String name}) {
    return _$genarateAddAccountAsyncAction
        .run(() => super.genarateAddAccount(context: context, appStore: appStore, webApi: webApi, name: name));
  }

  late final _$importAccountAsyncAction = AsyncAction('_AccountCreate.importAccount', context: context);

  @override
  Future<void> importAccount(
      {required BuildContext context, required String name, required String key, required AppStore appStore}) {
    return _$importAccountAsyncAction
        .run(() => super.importAccount(context: context, name: name, key: key, appStore: appStore));
  }

  late final _$_AccountCreateActionController = ActionController(name: '_AccountCreate', context: context);

  @override
  void setName(String value) {
    final _$actionInfo = _$_AccountCreateActionController.startAction(name: '_AccountCreate.setName');
    try {
      return super.setName(value);
    } finally {
      _$_AccountCreateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoading(bool valeu) {
    final _$actionInfo = _$_AccountCreateActionController.startAction(name: '_AccountCreate.setLoading');
    try {
      return super.setLoading(valeu);
    } finally {
      _$_AccountCreateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetName() {
    final _$actionInfo = _$_AccountCreateActionController.startAction(name: '_AccountCreate.resetName');
    try {
      return super.resetName();
    } finally {
      _$_AccountCreateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setKey(String value) {
    final _$actionInfo = _$_AccountCreateActionController.startAction(name: '_AccountCreate.setKey');
    try {
      return super.setKey(value);
    } finally {
      _$_AccountCreateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setKeyType(KeyType value) {
    final _$actionInfo = _$_AccountCreateActionController.startAction(name: '_AccountCreate.setKeyType');
    try {
      return super.setKeyType(value);
    } finally {
      _$_AccountCreateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String? validateAccount(Translations dic, String key) {
    final _$actionInfo = _$_AccountCreateActionController.startAction(name: '_AccountCreate.validateAccount');
    try {
      return super.validateAccount(dic, key);
    } finally {
      _$_AccountCreateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
name: ${name},
accountKey: ${accountKey},
keyType: ${keyType},
loading: ${loading}
    ''';
  }
}
