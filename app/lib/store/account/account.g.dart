// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AccountStore on _AccountStore, Store {
  Computed<AccountData>? _$currentAccountComputed;

  @override
  AccountData get currentAccount => (_$currentAccountComputed ??=
          Computed<AccountData>(() => super.currentAccount, name: '_AccountStore.currentAccount'))
      .value;
  Computed<List<AccountData>>? _$optionalAccountsComputed;

  @override
  List<AccountData> get optionalAccounts => (_$optionalAccountsComputed ??=
          Computed<List<AccountData>>(() => super.optionalAccounts, name: '_AccountStore.optionalAccounts'))
      .value;
  Computed<List<AccountData>>? _$accountListAllComputed;

  @override
  List<AccountData> get accountListAll => (_$accountListAllComputed ??=
          Computed<List<AccountData>>(() => super.accountListAll, name: '_AccountStore.accountListAll'))
      .value;
  Computed<bool>? _$isFirstAccountComputed;

  @override
  bool get isFirstAccount =>
      (_$isFirstAccountComputed ??= Computed<bool>(() => super.isFirstAccount, name: '_AccountStore.isFirstAccount'))
          .value;
  Computed<String>? _$currentAddressComputed;

  @override
  String get currentAddress =>
      (_$currentAddressComputed ??= Computed<String>(() => super.currentAddress, name: '_AccountStore.currentAddress'))
          .value;

  late final _$loadingAtom = Atom(name: '_AccountStore.loading', context: context);

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

  late final _$txStatusAtom = Atom(name: '_AccountStore.txStatus', context: context);

  @override
  TxStatus? get txStatus {
    _$txStatusAtom.reportRead();
    return super.txStatus;
  }

  @override
  set txStatus(TxStatus? value) {
    _$txStatusAtom.reportWrite(value, super.txStatus, () {
      super.txStatus = value;
    });
  }

  late final _$currentAccountPubKeyAtom = Atom(name: '_AccountStore.currentAccountPubKey', context: context);

  @override
  String? get currentAccountPubKey {
    _$currentAccountPubKeyAtom.reportRead();
    return super.currentAccountPubKey;
  }

  @override
  set currentAccountPubKey(String? value) {
    _$currentAccountPubKeyAtom.reportWrite(value, super.currentAccountPubKey, () {
      super.currentAccountPubKey = value;
    });
  }

  late final _$accountListAtom = Atom(name: '_AccountStore.accountList', context: context);

  @override
  ObservableList<AccountData> get accountList {
    _$accountListAtom.reportRead();
    return super.accountList;
  }

  @override
  set accountList(ObservableList<AccountData> value) {
    _$accountListAtom.reportWrite(value, super.accountList, () {
      super.accountList = value;
    });
  }

  late final _$queuedTxsAtom = Atom(name: '_AccountStore.queuedTxs', context: context);

  @override
  List<Map<String, dynamic>> get queuedTxs {
    _$queuedTxsAtom.reportRead();
    return super.queuedTxs;
  }

  @override
  set queuedTxs(List<Map<String, dynamic>> value) {
    _$queuedTxsAtom.reportWrite(value, super.queuedTxs, () {
      super.queuedTxs = value;
    });
  }

  late final _$setCurrentAccountAsyncAction = AsyncAction('_AccountStore.setCurrentAccount', context: context);

  @override
  Future<void> setCurrentAccount(String? pubKey) {
    return _$setCurrentAccountAsyncAction.run(() => super.setCurrentAccount(pubKey));
  }

  late final _$updateAccountNameAsyncAction = AsyncAction('_AccountStore.updateAccountName', context: context);

  @override
  Future<void> updateAccountName(AccountData account, String newName) {
    return _$updateAccountNameAsyncAction.run(() => super.updateAccountName(account, newName));
  }

  late final _$updateAccountAsyncAction = AsyncAction('_AccountStore.updateAccount', context: context);

  @override
  Future<void> updateAccount(Map<String, dynamic> acc) {
    return _$updateAccountAsyncAction.run(() => super.updateAccount(acc));
  }

  late final _$addAccountAsyncAction = AsyncAction('_AccountStore.addAccount', context: context);

  @override
  Future<void> addAccount(Map<String, dynamic> acc, String password, {String? name}) {
    return _$addAccountAsyncAction.run(() => super.addAccount(acc, password, name: name));
  }

  late final _$removeAccountAsyncAction = AsyncAction('_AccountStore.removeAccount', context: context);

  @override
  Future<void> removeAccount(AccountData acc) {
    return _$removeAccountAsyncAction.run(() => super.removeAccount(acc));
  }

  late final _$loadAccountAsyncAction = AsyncAction('_AccountStore.loadAccount', context: context);

  @override
  Future<void> loadAccount() {
    return _$loadAccountAsyncAction.run(() => super.loadAccount());
  }

  late final _$encryptSeedAsyncAction = AsyncAction('_AccountStore.encryptSeed', context: context);

  @override
  Future<void> encryptSeed(String? pubKey, String seed, String seedType, String password) {
    return _$encryptSeedAsyncAction.run(() => super.encryptSeed(pubKey, seed, seedType, password));
  }

  late final _$decryptSeedAsyncAction = AsyncAction('_AccountStore.decryptSeed', context: context);

  @override
  Future<String?> decryptSeed(String pubKey, String seedType, String password) {
    return _$decryptSeedAsyncAction.run(() => super.decryptSeed(pubKey, seedType, password));
  }

  late final _$checkSeedExistAsyncAction = AsyncAction('_AccountStore.checkSeedExist', context: context);

  @override
  Future<bool> checkSeedExist(String seedType, String? pubKey) {
    return _$checkSeedExistAsyncAction.run(() => super.checkSeedExist(seedType, pubKey));
  }

  late final _$updateSeedAsyncAction = AsyncAction('_AccountStore.updateSeed', context: context);

  @override
  Future<void> updateSeed(String? pubKey, String passwordOld, String passwordNew) {
    return _$updateSeedAsyncAction.run(() => super.updateSeed(pubKey, passwordOld, passwordNew));
  }

  late final _$deleteSeedAsyncAction = AsyncAction('_AccountStore.deleteSeed', context: context);

  @override
  Future<void> deleteSeed(String seedType, String? pubKey) {
    return _$deleteSeedAsyncAction.run(() => super.deleteSeed(seedType, pubKey));
  }

  late final _$_AccountStoreActionController = ActionController(name: '_AccountStore', context: context);

  @override
  void setTxStatus([TxStatus? status]) {
    final _$actionInfo = _$_AccountStoreActionController.startAction(name: '_AccountStore.setTxStatus');
    try {
      return super.setTxStatus(status);
    } finally {
      _$_AccountStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearTxStatus() {
    final _$actionInfo = _$_AccountStoreActionController.startAction(name: '_AccountStore.clearTxStatus');
    try {
      return super.clearTxStatus();
    } finally {
      _$_AccountStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void queueTx(Map<String, dynamic> tx) {
    final _$actionInfo = _$_AccountStoreActionController.startAction(name: '_AccountStore.queueTx');
    try {
      return super.queueTx(tx);
    } finally {
      _$_AccountStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loading: ${loading},
txStatus: ${txStatus},
currentAccountPubKey: ${currentAccountPubKey},
accountList: ${accountList},
queuedTxs: ${queuedTxs},
currentAccount: ${currentAccount},
optionalAccounts: ${optionalAccounts},
accountListAll: ${accountListAll},
isFirstAccount: ${isFirstAccount},
currentAddress: ${currentAddress}
    ''';
  }
}
