// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'encointerAccountStore.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EncointerAccountStore _$EncointerAccountStoreFromJson(Map<String, dynamic> json) => EncointerAccountStore(
      json['network'] as String,
      json['address'] as String,
    )
      ..balanceEntries = ObservableMap<String, BalanceEntry>.of((json['balanceEntries'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, BalanceEntry.fromJson(e as Map<String, dynamic>)),
      ))
      ..reputations = (json['reputations'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(int.parse(k), CommunityReputation.fromJson(e as Map<String, dynamic>)),
      )
      ..txsTransfer = ObservableList<TransferData>.of(
          (json['txsTransfer'] as List).map((e) => TransferData.fromJson(e as Map<String, dynamic>)));

Map<String, dynamic> _$EncointerAccountStoreToJson(EncointerAccountStore instance) => <String, dynamic>{
      'network': instance.network,
      'address': instance.address,
      'balanceEntries': instance.balanceEntries.map((k, e) => MapEntry(k, e.toJson())),
      'reputations': instance.reputations.map((k, e) => MapEntry(k.toString(), e.toJson())),
      'txsTransfer': instance.txsTransfer.map((e) => e.toJson()).toList(),
    };

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$EncointerAccountStore on _EncointerAccountStore, Store {
  Computed<dynamic>? _$ceremonyIndexForProofOfAttendanceComputed;

  @override
  dynamic get ceremonyIndexForProofOfAttendance =>
      (_$ceremonyIndexForProofOfAttendanceComputed ??= Computed<dynamic>(() => super.ceremonyIndexForProofOfAttendance,
              name: '_EncointerAccountStore.ceremonyIndexForProofOfAttendance'))
          .value;

  late final _$balanceEntriesAtom = Atom(name: '_EncointerAccountStore.balanceEntries', context: context);

  @override
  ObservableMap<String, BalanceEntry> get balanceEntries {
    _$balanceEntriesAtom.reportRead();
    return super.balanceEntries;
  }

  @override
  set balanceEntries(ObservableMap<String, BalanceEntry> value) {
    _$balanceEntriesAtom.reportWrite(value, super.balanceEntries, () {
      super.balanceEntries = value;
    });
  }

  late final _$reputationsAtom = Atom(name: '_EncointerAccountStore.reputations', context: context);

  @override
  Map<int, CommunityReputation> get reputations {
    _$reputationsAtom.reportRead();
    return super.reputations;
  }

  @override
  set reputations(Map<int, CommunityReputation> value) {
    _$reputationsAtom.reportWrite(value, super.reputations, () {
      super.reputations = value;
    });
  }

  late final _$txsTransferAtom = Atom(name: '_EncointerAccountStore.txsTransfer', context: context);

  @override
  ObservableList<TransferData> get txsTransfer {
    _$txsTransferAtom.reportRead();
    return super.txsTransfer;
  }

  @override
  set txsTransfer(ObservableList<TransferData> value) {
    _$txsTransferAtom.reportWrite(value, super.txsTransfer, () {
      super.txsTransfer = value;
    });
  }

  late final _$setTransferTxsAsyncAction = AsyncAction('_EncointerAccountStore.setTransferTxs', context: context);

  @override
  Future<void> setTransferTxs(List<dynamic> list, String address, {bool reset = false, dynamic needCache = true}) {
    return _$setTransferTxsAsyncAction
        .run(() => super.setTransferTxs(list, address, reset: reset, needCache: needCache));
  }

  late final _$_EncointerAccountStoreActionController =
      ActionController(name: '_EncointerAccountStore', context: context);

  @override
  void addBalanceEntry(CommunityIdentifier cid, BalanceEntry balanceEntry) {
    final _$actionInfo =
        _$_EncointerAccountStoreActionController.startAction(name: '_EncointerAccountStore.addBalanceEntry');
    try {
      return super.addBalanceEntry(cid, balanceEntry);
    } finally {
      _$_EncointerAccountStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setReputations(Map<int, CommunityReputation> reps) {
    final _$actionInfo =
        _$_EncointerAccountStoreActionController.startAction(name: '_EncointerAccountStore.setReputations');
    try {
      return super.setReputations(reps);
    } finally {
      _$_EncointerAccountStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void purgeReputations() {
    final _$actionInfo =
        _$_EncointerAccountStoreActionController.startAction(name: '_EncointerAccountStore.purgeReputations');
    try {
      return super.purgeReputations();
    } finally {
      _$_EncointerAccountStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void purgeCeremonySpecificState() {
    final _$actionInfo =
        _$_EncointerAccountStoreActionController.startAction(name: '_EncointerAccountStore.purgeCeremonySpecificState');
    try {
      return super.purgeCeremonySpecificState();
    } finally {
      _$_EncointerAccountStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
balanceEntries: ${balanceEntries},
reputations: ${reputations},
txsTransfer: ${txsTransfer},
ceremonyIndexForProofOfAttendance: ${ceremonyIndexForProofOfAttendance}
    ''';
  }
}
