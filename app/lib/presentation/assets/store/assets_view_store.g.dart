// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assets_view_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AssetsViewStore on _AssetsViewStoreBase, Store {
  Computed<AppStore>? _$appStoreComputed;

  @override
  AppStore get appStore =>
      (_$appStoreComputed ??= Computed<AppStore>(() => super.appStore, name: '_AssetsViewStoreBase.appStore')).value;

  late final _$refreshEncointerStateAsyncAction =
      AsyncAction('_AssetsViewStoreBase.refreshEncointerState', context: context);

  @override
  Future<void> refreshEncointerState() {
    return _$refreshEncointerStateAsyncAction.run(() => super.refreshEncointerState());
  }

  late final _$reconnectAsyncAction = AsyncAction('_AssetsViewStoreBase.reconnect', context: context);

  @override
  Future<void> reconnect({required BuildContext context}) {
    return _$reconnectAsyncAction.run(() => super.reconnect(context: context));
  }

  late final _$switchAccountAsyncAction = AsyncAction('_AssetsViewStoreBase.switchAccount', context: context);

  @override
  Future<void> switchAccount(AccountData account) {
    return _$switchAccountAsyncAction.run(() => super.switchAccount(account));
  }

  late final _$showPasswordDialogAsyncAction = AsyncAction('_AssetsViewStoreBase.showPasswordDialog', context: context);

  @override
  Future<void> showPasswordDialog(BuildContext context) {
    return _$showPasswordDialogAsyncAction.run(() => super.showPasswordDialog(context));
  }

  late final _$_showPasswordNotEnteredDialogAsyncAction =
      AsyncAction('_AssetsViewStoreBase._showPasswordNotEnteredDialog', context: context);

  @override
  Future<void> _showPasswordNotEnteredDialog(BuildContext context) {
    return _$_showPasswordNotEnteredDialogAsyncAction.run(() => super._showPasswordNotEnteredDialog(context));
  }

  late final _$_AssetsViewStoreBaseActionController = ActionController(name: '_AssetsViewStoreBase', context: context);

  @override
  void dispose() {
    final _$actionInfo = _$_AssetsViewStoreBaseActionController.startAction(name: '_AssetsViewStoreBase.dispose');
    try {
      return super.dispose();
    } finally {
      _$_AssetsViewStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void refreshBalanceAndNotify(BuildContext context) {
    final _$actionInfo =
        _$_AssetsViewStoreBaseActionController.startAction(name: '_AssetsViewStoreBase.refreshBalanceAndNotify');
    try {
      return super.refreshBalanceAndNotify(context);
    } finally {
      _$_AssetsViewStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
appStore: ${appStore}
    ''';
  }
}
