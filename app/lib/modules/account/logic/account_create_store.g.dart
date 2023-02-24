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

  late final _$passwordAtom =
      Atom(name: '_AccountCreate.password', context: context);

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

  late final _$keyAtom = Atom(name: '_AccountCreate.key', context: context);

  @override
  String? get key {
    _$keyAtom.reportRead();
    return super.key;
  }

  @override
  set key(String? value) {
    _$keyAtom.reportWrite(value, super.key, () {
      super.key = value;
    });
  }

  late final _$loadingAtom =
      Atom(name: '_AccountCreate.loading', context: context);

  @override
  bool? get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool? value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  late final _$_AccountCreateActionController =
      ActionController(name: '_AccountCreate', context: context);

  @override
  void setName(String value) {
    final _$actionInfo = _$_AccountCreateActionController.startAction(
        name: '_AccountCreate.setName');
    try {
      return super.setName(value);
    } finally {
      _$_AccountCreateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassword(String value) {
    final _$actionInfo = _$_AccountCreateActionController.startAction(
        name: '_AccountCreate.setPassword');
    try {
      return super.setPassword(value);
    } finally {
      _$_AccountCreateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setKey(String? valeu) {
    final _$actionInfo = _$_AccountCreateActionController.startAction(
        name: '_AccountCreate.setKey');
    try {
      return super.setKey(valeu);
    } finally {
      _$_AccountCreateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoading(bool valeu) {
    final _$actionInfo = _$_AccountCreateActionController.startAction(
        name: '_AccountCreate.setLoading');
    try {
      return super.setLoading(valeu);
    } finally {
      _$_AccountCreateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetNewAccount() {
    final _$actionInfo = _$_AccountCreateActionController.startAction(
        name: '_AccountCreate.resetNewAccount');
    try {
      return super.resetNewAccount();
    } finally {
      _$_AccountCreateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
name: ${name},
password: ${password},
key: ${key},
loading: ${loading}
    ''';
  }
}
