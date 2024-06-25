// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_account_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$NewAccountStore on _NewAccountStoreBase, Store {
  late final _$nameAtom =
      Atom(name: '_NewAccountStoreBase.name', context: context);

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

  late final _$accountKeyAtom =
      Atom(name: '_NewAccountStoreBase.accountKey', context: context);

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

  late final _$_loadingAtom =
      Atom(name: '_NewAccountStoreBase._loading', context: context);

  bool get loading {
    _$_loadingAtom.reportRead();
    return super._loading;
  }

  @override
  bool get _loading => loading;

  @override
  set _loading(bool value) {
    _$_loadingAtom.reportWrite(value, super._loading, () {
      super._loading = value;
    });
  }

  late final _$generateAccountAsyncAction =
      AsyncAction('_NewAccountStoreBase.generateAccount', context: context);

  @override
  Future<NewAccountResult> generateAccount() {
    return _$generateAccountAsyncAction.run(() => super.generateAccount());
  }

  late final _$importAccountAsyncAction =
      AsyncAction('_NewAccountStoreBase.importAccount', context: context);

  @override
  Future<NewAccountResult> importAccount() {
    return _$importAccountAsyncAction.run(() => super.importAccount());
  }

  late final _$_generateAccountAsyncAction =
      AsyncAction('_NewAccountStoreBase._generateAccount', context: context);

  @override
  Future<NewAccountResult> _generateAccount() {
    return _$_generateAccountAsyncAction.run(() => super._generateAccount());
  }

  late final _$_importAccountAsyncAction =
      AsyncAction('_NewAccountStoreBase._importAccount', context: context);

  @override
  Future<NewAccountResult> _importAccount() {
    return _$_importAccountAsyncAction.run(() => super._importAccount());
  }

  late final _$saveAccountAsyncAction =
      AsyncAction('_NewAccountStoreBase.saveAccount', context: context);

  @override
  Future<NewAccountResult> saveAccount(KeyringAccount account) {
    return _$saveAccountAsyncAction.run(() => super.saveAccount(account));
  }

  late final _$_NewAccountStoreBaseActionController =
      ActionController(name: '_NewAccountStoreBase', context: context);

  @override
  void setName(String? value) {
    final _$actionInfo = _$_NewAccountStoreBaseActionController.startAction(
        name: '_NewAccountStoreBase.setName');
    try {
      return super.setName(value);
    } finally {
      _$_NewAccountStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setKey(String? value) {
    final _$actionInfo = _$_NewAccountStoreBaseActionController.startAction(
        name: '_NewAccountStoreBase.setKey');
    try {
      return super.setKey(value);
    } finally {
      _$_NewAccountStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
name: ${name},
accountKey: ${accountKey}
    ''';
  }
}
