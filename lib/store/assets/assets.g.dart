// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assets.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AssetsStore on _AssetsStore, Store {
  Computed<ObservableList<TransferData>>? _$txsViewComputed;

  @override
  ObservableList<TransferData> get txsView =>
      (_$txsViewComputed ??= Computed<ObservableList<TransferData>>(() => super.txsView, name: '_AssetsStore.txsView'))
          .value;

  late final _$cacheTxsTimestampAtom = Atom(name: '_AssetsStore.cacheTxsTimestamp', context: context);

  @override
  int? get cacheTxsTimestamp {
    _$cacheTxsTimestampAtom.reportRead();
    return super.cacheTxsTimestamp;
  }

  @override
  set cacheTxsTimestamp(int? value) {
    _$cacheTxsTimestampAtom.reportWrite(value, super.cacheTxsTimestamp, () {
      super.cacheTxsTimestamp = value;
    });
  }

  late final _$isTxsLoadingAtom = Atom(name: '_AssetsStore.isTxsLoading', context: context);

  @override
  bool get isTxsLoading {
    _$isTxsLoadingAtom.reportRead();
    return super.isTxsLoading;
  }

  @override
  set isTxsLoading(bool value) {
    _$isTxsLoadingAtom.reportWrite(value, super.isTxsLoading, () {
      super.isTxsLoading = value;
    });
  }

  late final _$submittingAtom = Atom(name: '_AssetsStore.submitting', context: context);

  @override
  bool get submitting {
    _$submittingAtom.reportRead();
    return super.submitting;
  }

  @override
  set submitting(bool value) {
    _$submittingAtom.reportWrite(value, super.submitting, () {
      super.submitting = value;
    });
  }

  late final _$balancesAtom = Atom(name: '_AssetsStore.balances', context: context);

  @override
  ObservableMap<String?, BalancesInfo> get balances {
    _$balancesAtom.reportRead();
    return super.balances;
  }

  @override
  set balances(ObservableMap<String?, BalancesInfo> value) {
    _$balancesAtom.reportWrite(value, super.balances, () {
      super.balances = value;
    });
  }

  late final _$tokenBalancesAtom = Atom(name: '_AssetsStore.tokenBalances', context: context);

  @override
  Map<String, String> get tokenBalances {
    _$tokenBalancesAtom.reportRead();
    return super.tokenBalances;
  }

  @override
  set tokenBalances(Map<String, String> value) {
    _$tokenBalancesAtom.reportWrite(value, super.tokenBalances, () {
      super.tokenBalances = value;
    });
  }

  late final _$txsCountAtom = Atom(name: '_AssetsStore.txsCount', context: context);

  @override
  int? get txsCount {
    _$txsCountAtom.reportRead();
    return super.txsCount;
  }

  @override
  set txsCount(int? value) {
    _$txsCountAtom.reportWrite(value, super.txsCount, () {
      super.txsCount = value;
    });
  }

  late final _$txsAtom = Atom(name: '_AssetsStore.txs', context: context);

  @override
  ObservableList<TransferData> get txs {
    _$txsAtom.reportRead();
    return super.txs;
  }

  @override
  set txs(ObservableList<TransferData> value) {
    _$txsAtom.reportWrite(value, super.txs, () {
      super.txs = value;
    });
  }

  late final _$txsFilterAtom = Atom(name: '_AssetsStore.txsFilter', context: context);

  @override
  int get txsFilter {
    _$txsFilterAtom.reportRead();
    return super.txsFilter;
  }

  @override
  set txsFilter(int value) {
    _$txsFilterAtom.reportWrite(value, super.txsFilter, () {
      super.txsFilter = value;
    });
  }

  late final _$blockMapAtom = Atom(name: '_AssetsStore.blockMap', context: context);

  @override
  ObservableMap<int?, BlockData> get blockMap {
    _$blockMapAtom.reportRead();
    return super.blockMap;
  }

  @override
  set blockMap(ObservableMap<int?, BlockData> value) {
    _$blockMapAtom.reportWrite(value, super.blockMap, () {
      super.blockMap = value;
    });
  }

  late final _$announcementsAtom = Atom(name: '_AssetsStore.announcements', context: context);

  @override
  List<dynamic>? get announcements {
    _$announcementsAtom.reportRead();
    return super.announcements;
  }

  @override
  set announcements(List<dynamic>? value) {
    _$announcementsAtom.reportWrite(value, super.announcements, () {
      super.announcements = value;
    });
  }

  late final _$marketPricesAtom = Atom(name: '_AssetsStore.marketPrices', context: context);

  @override
  ObservableMap<String, double> get marketPrices {
    _$marketPricesAtom.reportRead();
    return super.marketPrices;
  }

  @override
  set marketPrices(ObservableMap<String, double> value) {
    _$marketPricesAtom.reportWrite(value, super.marketPrices, () {
      super.marketPrices = value;
    });
  }

  late final _$setAccountBalancesAsyncAction = AsyncAction('_AssetsStore.setAccountBalances', context: context);

  @override
  Future<void> setAccountBalances(String? pubKey, Map<String, dynamic> data, {bool? needCache, bool? fromCache}) {
    return _$setAccountBalancesAsyncAction
        .run(() => super.setAccountBalances(pubKey, data, needCache: needCache, fromCache: fromCache));
  }

  late final _$setAccountTokenBalancesAsyncAction =
      AsyncAction('_AssetsStore.setAccountTokenBalances', context: context);

  @override
  Future<void> setAccountTokenBalances(String pubKey, Map<dynamic, dynamic>? amt, {bool needCache = true}) {
    return _$setAccountTokenBalancesAsyncAction
        .run(() => super.setAccountTokenBalances(pubKey, amt, needCache: needCache));
  }

  late final _$clearTxsAsyncAction = AsyncAction('_AssetsStore.clearTxs', context: context);

  @override
  Future<void> clearTxs() {
    return _$clearTxsAsyncAction.run(() => super.clearTxs());
  }

  late final _$addTxsAsyncAction = AsyncAction('_AssetsStore.addTxs', context: context);

  @override
  Future<void> addTxs(Map<dynamic, dynamic> res, String address, {bool shouldCache = false}) {
    return _$addTxsAsyncAction.run(() => super.addTxs(res, address, shouldCache: shouldCache));
  }

  late final _$loadAccountCacheAsyncAction = AsyncAction('_AssetsStore.loadAccountCache', context: context);

  @override
  Future<void> loadAccountCache() {
    return _$loadAccountCacheAsyncAction.run(() => super.loadAccountCache());
  }

  late final _$loadCacheAsyncAction = AsyncAction('_AssetsStore.loadCache', context: context);

  @override
  Future<void> loadCache() {
    return _$loadCacheAsyncAction.run(() => super.loadCache());
  }

  late final _$_AssetsStoreActionController = ActionController(name: '_AssetsStore', context: context);

  @override
  void setTxsLoading(bool isLoading) {
    final _$actionInfo = _$_AssetsStoreActionController.startAction(name: '_AssetsStore.setTxsLoading');
    try {
      return super.setTxsLoading(isLoading);
    } finally {
      _$_AssetsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTxsFilter(int filter) {
    final _$actionInfo = _$_AssetsStoreActionController.startAction(name: '_AssetsStore.setTxsFilter');
    try {
      return super.setTxsFilter(filter);
    } finally {
      _$_AssetsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSubmitting(bool isSubmitting) {
    final _$actionInfo = _$_AssetsStoreActionController.startAction(name: '_AssetsStore.setSubmitting');
    try {
      return super.setSubmitting(isSubmitting);
    } finally {
      _$_AssetsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAnnouncements(List<dynamic> data) {
    final _$actionInfo = _$_AssetsStoreActionController.startAction(name: '_AssetsStore.setAnnouncements');
    try {
      return super.setAnnouncements(data);
    } finally {
      _$_AssetsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMarketPrices(String token, String price) {
    final _$actionInfo = _$_AssetsStoreActionController.startAction(name: '_AssetsStore.setMarketPrices');
    try {
      return super.setMarketPrices(token, price);
    } finally {
      _$_AssetsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
cacheTxsTimestamp: ${cacheTxsTimestamp},
isTxsLoading: ${isTxsLoading},
submitting: ${submitting},
balances: ${balances},
tokenBalances: ${tokenBalances},
txsCount: ${txsCount},
txs: ${txs},
txsFilter: ${txsFilter},
blockMap: ${blockMap},
announcements: ${announcements},
marketPrices: ${marketPrices},
txsView: ${txsView}
    ''';
  }
}
