// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_update.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DataUpdateStore on _DataUpdateStore, Store {
  Computed<DateTime>? _$nowComputed;

  @override
  DateTime get now => (_$nowComputed ??= Computed<DateTime>(() => super.now, name: '_DataUpdateStore.now')).value;
  Computed<bool>? _$expiredComputed;

  @override
  bool get expired =>
      (_$expiredComputed ??= Computed<bool>(() => super.expired, name: '_DataUpdateStore.expired')).value;
  Computed<bool>? _$needsRefreshComputed;

  @override
  bool get needsRefresh =>
      (_$needsRefreshComputed ??= Computed<bool>(() => super.needsRefresh, name: '_DataUpdateStore.needsRefresh'))
          .value;

  late final _$lastUpdateAtom = Atom(name: '_DataUpdateStore.lastUpdate', context: context);

  @override
  DateTime get lastUpdate {
    _$lastUpdateAtom.reportRead();
    return super.lastUpdate;
  }

  @override
  set lastUpdate(DateTime value) {
    _$lastUpdateAtom.reportWrite(value, super.lastUpdate, () {
      super.lastUpdate = value;
    });
  }

  late final _$_timeAtom = Atom(name: '_DataUpdateStore._time', context: context);

  @override
  ObservableStream<DateTime> get _time {
    _$_timeAtom.reportRead();
    return super._time;
  }

  @override
  set _time(ObservableStream<DateTime> value) {
    _$_timeAtom.reportWrite(value, super._time, () {
      super._time = value;
    });
  }

  late final _$invalidatedAtom = Atom(name: '_DataUpdateStore.invalidated', context: context);

  @override
  bool get invalidated {
    _$invalidatedAtom.reportRead();
    return super.invalidated;
  }

  @override
  set invalidated(bool value) {
    _$invalidatedAtom.reportWrite(value, super.invalidated, () {
      super.invalidated = value;
    });
  }

  late final _$executeUpdateAsyncAction = AsyncAction('_DataUpdateStore.executeUpdate', context: context);

  @override
  Future<void> executeUpdate() {
    return _$executeUpdateAsyncAction.run(() => super.executeUpdate());
  }

  late final _$_DataUpdateStoreActionController = ActionController(name: '_DataUpdateStore', context: context);

  @override
  void setLastUpdate(DateTime dateTime) {
    final _$actionInfo = _$_DataUpdateStoreActionController.startAction(name: '_DataUpdateStore.setLastUpdate');
    try {
      return super.setLastUpdate(dateTime);
    } finally {
      _$_DataUpdateStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setInvalidated() {
    final _$actionInfo = _$_DataUpdateStoreActionController.startAction(name: '_DataUpdateStore.setInvalidated');
    try {
      return super.setInvalidated();
    } finally {
      _$_DataUpdateStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
lastUpdate: ${lastUpdate},
invalidated: ${invalidated},
now: ${now},
expired: ${expired},
needsRefresh: ${needsRefresh}
    ''';
  }
}
