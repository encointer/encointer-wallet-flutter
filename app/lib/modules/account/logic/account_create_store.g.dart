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
  String toString() {
    return '''
name: ${name},
loading: ${loading}
    ''';
  }
}
