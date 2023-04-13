// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginStore on _LoginStoreBase, Store {
  late final _$isLoadingAtom = Atom(name: '_LoginStoreBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$_LoginStoreBaseActionController = ActionController(name: '_LoginStoreBase', context: context);

  @override
  void addPinCode(int value, int maxLength) {
    final _$actionInfo = _$_LoginStoreBaseActionController.startAction(name: '_LoginStoreBase.addPinCode');
    try {
      return super.addPinCode(value, maxLength);
    } finally {
      _$_LoginStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeLastDigit() {
    final _$actionInfo = _$_LoginStoreBaseActionController.startAction(name: '_LoginStoreBase.removeLastDigit');
    try {
      return super.removeLastDigit();
    } finally {
      _$_LoginStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading}
    ''';
  }
}
