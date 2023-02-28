// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_account_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$NewAccountStore on _NewAccountStoreBase, Store {
  late final _$nameAtom = Atom(name: '_NewAccountStoreBase.name', context: context);

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

  late final _$passwordAtom = Atom(name: '_NewAccountStoreBase.password', context: context);

  @override
  String? get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String? value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  late final _$accountKeyAtom = Atom(name: '_NewAccountStoreBase.accountKey', context: context);

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

  late final _$keyTypeAtom = Atom(name: '_NewAccountStoreBase.keyType', context: context);

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

  late final _$loadingAtom = Atom(name: '_NewAccountStoreBase.loading', context: context);

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

  late final _$cacheAccAtom = Atom(name: '_NewAccountStoreBase.cacheAcc', context: context);

  @override
  Map<String, dynamic>? get cacheAcc {
    _$cacheAccAtom.reportRead();
    return super.cacheAcc;
  }

  @override
  set cacheAcc(Map<String, dynamic>? value) {
    _$cacheAccAtom.reportWrite(value, super.cacheAcc, () {
      super.cacheAcc = value;
    });
  }

  late final _$generateAccountAsyncAction = AsyncAction('_NewAccountStoreBase.generateAccount', context: context);

  @override
  Future<AddAccountResponse> generateAccount(AppStore appStore, Api webApi) {
    return _$generateAccountAsyncAction.run(() => super.generateAccount(appStore, webApi));
  }

  late final _$importAccountAsyncAction = AsyncAction('_NewAccountStoreBase.importAccount', context: context);

  @override
  Future<AddAccountResponse> importAccount(AppStore appStore, Api webApi) {
    return _$importAccountAsyncAction.run(() => super.importAccount(appStore, webApi));
  }

  late final _$_generateAccountAsyncAction = AsyncAction('_NewAccountStoreBase._generateAccount', context: context);

  @override
  Future<AddAccountResponse> _generateAccount(AppStore appStore, Api webApi, String pin) {
    return _$_generateAccountAsyncAction.run(() => super._generateAccount(appStore, webApi, pin));
  }

  late final _$_importAccountAsyncAction = AsyncAction('_NewAccountStoreBase._importAccount', context: context);

  @override
  Future<AddAccountResponse> _importAccount(AppStore appStore, Api webApi, String pin) {
    return _$_importAccountAsyncAction.run(() => super._importAccount(appStore, webApi, pin));
  }

  late final _$saveAccountAsyncAction = AsyncAction('_NewAccountStoreBase.saveAccount', context: context);

  @override
  Future<AddAccountResponse> saveAccount(Api webApi, AppStore appStore, Map<String, dynamic> acc, String pin) {
    return _$saveAccountAsyncAction.run(() => super.saveAccount(webApi, appStore, acc, pin));
  }

  late final _$_NewAccountStoreBaseActionController = ActionController(name: '_NewAccountStoreBase', context: context);

  @override
  void setName(String? value) {
    final _$actionInfo = _$_NewAccountStoreBaseActionController.startAction(name: '_NewAccountStoreBase.setName');
    try {
      return super.setName(value);
    } finally {
      _$_NewAccountStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassword(String? value) {
    final _$actionInfo = _$_NewAccountStoreBaseActionController.startAction(name: '_NewAccountStoreBase.setPassword');
    try {
      return super.setPassword(value);
    } finally {
      _$_NewAccountStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoading(bool value) {
    final _$actionInfo = _$_NewAccountStoreBaseActionController.startAction(name: '_NewAccountStoreBase.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$_NewAccountStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setKey(String? value) {
    final _$actionInfo = _$_NewAccountStoreBaseActionController.startAction(name: '_NewAccountStoreBase.setKey');
    try {
      return super.setKey(value);
    } finally {
      _$_NewAccountStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setKeyType(KeyType value) {
    final _$actionInfo = _$_NewAccountStoreBaseActionController.startAction(name: '_NewAccountStoreBase.setKeyType');
    try {
      return super.setKeyType(value);
    } finally {
      _$_NewAccountStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCacheAcc(Map<String, dynamic> value) {
    final _$actionInfo = _$_NewAccountStoreBaseActionController.startAction(name: '_NewAccountStoreBase.setCacheAcc');
    try {
      return super.setCacheAcc(value);
    } finally {
      _$_NewAccountStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String? validateAccount(Translations dic, String key) {
    final _$actionInfo =
        _$_NewAccountStoreBaseActionController.startAction(name: '_NewAccountStoreBase.validateAccount');
    try {
      return super.validateAccount(dic, key);
    } finally {
      _$_NewAccountStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
name: ${name},
password: ${password},
accountKey: ${accountKey},
keyType: ${keyType},
loading: ${loading},
cacheAcc: ${cacheAcc}
    ''';
  }
}
