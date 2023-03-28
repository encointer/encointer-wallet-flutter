// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'encointer_account_store.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EncointerAccountStore _$EncointerAccountStoreFromJson(
        Map<String, dynamic> json) =>
    EncointerAccountStore(
      json['network'] as String,
      json['address'] as String,
    )
      ..balanceEntries = ObservableMap<String, BalanceEntry>.of(
          (json['balanceEntries'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, BalanceEntry.fromJson(e as Map<String, dynamic>)),
      ))
      ..reputations = (json['reputations'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(int.parse(k),
            CommunityReputation.fromJson(e as Map<String, dynamic>)),
      )
      ..txsTransfer = ObservableList<TransferData>.of(
          (json['txsTransfer'] as List)
              .map((e) => TransferData.fromJson(e as Map<String, dynamic>)))
      ..numberOfNewbieTicketsForReputable =
          json['numberOfNewbieTicketsForReputable'] as int
      ..lastProofOfAttendance = json['lastProofOfAttendance'] == null
          ? null
          : ProofOfAttendance.fromJson(
              json['lastProofOfAttendance'] as Map<String, dynamic>);

Map<String, dynamic> _$EncointerAccountStoreToJson(
        EncointerAccountStore instance) =>
    <String, dynamic>{
      'network': instance.network,
      'address': instance.address,
      'balanceEntries':
          instance.balanceEntries.map((k, e) => MapEntry(k, e.toJson())),
      'reputations': instance.reputations
          .map((k, e) => MapEntry(k.toString(), e.toJson())),
      'txsTransfer': instance.txsTransfer.map((e) => e.toJson()).toList(),
      'numberOfNewbieTicketsForReputable':
          instance.numberOfNewbieTicketsForReputable,
      'lastProofOfAttendance': instance.lastProofOfAttendance?.toJson(),
    };

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$EncointerAccountStore on _EncointerAccountStore, Store {
  Computed<int?>? _$ceremonyIndexForNextProofOfAttendanceComputed;

  @override
  int? get ceremonyIndexForNextProofOfAttendance =>
      (_$ceremonyIndexForNextProofOfAttendanceComputed ??= Computed<int?>(
              () => super.ceremonyIndexForNextProofOfAttendance,
              name:
                  '_EncointerAccountStore.ceremonyIndexForNextProofOfAttendance'))
          .value;

  late final _$balanceEntriesAtom =
      Atom(name: '_EncointerAccountStore.balanceEntries', context: context);

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

  late final _$reputationsAtom =
      Atom(name: '_EncointerAccountStore.reputations', context: context);

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

  late final _$txsTransferAtom =
      Atom(name: '_EncointerAccountStore.txsTransfer', context: context);

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

  late final _$numberOfNewbieTicketsForReputableAtom = Atom(
      name: '_EncointerAccountStore.numberOfNewbieTicketsForReputable',
      context: context);

  @override
  int get numberOfNewbieTicketsForReputable {
    _$numberOfNewbieTicketsForReputableAtom.reportRead();
    return super.numberOfNewbieTicketsForReputable;
  }

  @override
  set numberOfNewbieTicketsForReputable(int value) {
    _$numberOfNewbieTicketsForReputableAtom
        .reportWrite(value, super.numberOfNewbieTicketsForReputable, () {
      super.numberOfNewbieTicketsForReputable = value;
    });
  }

  late final _$lastProofOfAttendanceAtom = Atom(
      name: '_EncointerAccountStore.lastProofOfAttendance', context: context);

  @override
  ProofOfAttendance? get lastProofOfAttendance {
    _$lastProofOfAttendanceAtom.reportRead();
    return super.lastProofOfAttendance;
  }

  @override
  set lastProofOfAttendance(ProofOfAttendance? value) {
    _$lastProofOfAttendanceAtom.reportWrite(value, super.lastProofOfAttendance,
        () {
      super.lastProofOfAttendance = value;
    });
  }

  late final _$setReputationsAsyncAction =
      AsyncAction('_EncointerAccountStore.setReputations', context: context);

  @override
  Future<void> setReputations(Map<int, CommunityReputation> reps) {
    return _$setReputationsAsyncAction.run(() => super.setReputations(reps));
  }

  late final _$setTransferTxsAsyncAction =
      AsyncAction('_EncointerAccountStore.setTransferTxs', context: context);

  @override
  Future<void> setTransferTxs(List<dynamic> list, String address,
      {bool reset = false, bool needCache = true}) {
    return _$setTransferTxsAsyncAction.run(() => super
        .setTransferTxs(list, address, reset: reset, needCache: needCache));
  }

  late final _$getNumberOfNewbieTicketsForReputableAsyncAction = AsyncAction(
      '_EncointerAccountStore.getNumberOfNewbieTicketsForReputable',
      context: context);

  @override
  Future<void> getNumberOfNewbieTicketsForReputable() {
    return _$getNumberOfNewbieTicketsForReputableAsyncAction
        .run(() => super.getNumberOfNewbieTicketsForReputable());
  }

  late final _$_EncointerAccountStoreActionController =
      ActionController(name: '_EncointerAccountStore', context: context);

  @override
  void addBalanceEntry(CommunityIdentifier cid, BalanceEntry balanceEntry) {
    final _$actionInfo = _$_EncointerAccountStoreActionController.startAction(
        name: '_EncointerAccountStore.addBalanceEntry');
    try {
      return super.addBalanceEntry(cid, balanceEntry);
    } finally {
      _$_EncointerAccountStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void purgeReputations() {
    final _$actionInfo = _$_EncointerAccountStoreActionController.startAction(
        name: '_EncointerAccountStore.purgeReputations');
    try {
      return super.purgeReputations();
    } finally {
      _$_EncointerAccountStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void purgeCeremonySpecificState() {
    final _$actionInfo = _$_EncointerAccountStoreActionController.startAction(
        name: '_EncointerAccountStore.purgeCeremonySpecificState');
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
numberOfNewbieTicketsForReputable: ${numberOfNewbieTicketsForReputable},
lastProofOfAttendance: ${lastProofOfAttendance},
ceremonyIndexForNextProofOfAttendance: ${ceremonyIndexForNextProofOfAttendance}
    ''';
  }
}
