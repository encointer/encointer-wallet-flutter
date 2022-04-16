// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'encointer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EncointerStore _$EncointerStoreFromJson(Map<String, dynamic> json) {
  return EncointerStore(
    json['network'] as String,
  )
    ..currentPhase = _$enumDecodeNullable(_$CeremonyPhaseEnumMap, json['currentPhase'])
    ..phaseDurations = (json['phaseDurations'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(_$enumDecodeNullable(_$CeremonyPhaseEnumMap, k), e as int),
    )
    ..currentCeremonyIndex = json['currentCeremonyIndex'] as int
    ..communityIdentifiers = (json['communityIdentifiers'] as List)
        ?.map((e) => e == null ? null : CommunityIdentifier.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..communities = (json['communities'] as List)
        ?.map((e) => e == null ? null : CidName.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..chosenCid =
        json['chosenCid'] == null ? null : CommunityIdentifier.fromJson(json['chosenCid'] as Map<String, dynamic>)
    ..txsTransfer = json['txsTransfer'] != null
        ? ObservableList<TransferData>.of((json['txsTransfer'] as List)
            .map((e) => e == null ? null : TransferData.fromJson(e as Map<String, dynamic>)))
        : null
    ..businessRegistry = json['businessRegistry'] != null
        ? ObservableList<AccountBusinessTuple>.of((json['businessRegistry'] as List)
            .map((e) => e == null ? null : AccountBusinessTuple.fromJson(e as Map<String, dynamic>)))
        : null
    ..communityStores = json['communityStores'] != null
        ? ObservableMap<String, CommunityStore>.of((json['communityStores'] as Map<String, dynamic>).map(
            (k, e) => MapEntry(k, e == null ? null : CommunityStore.fromJson(e as Map<String, dynamic>)),
          ))
        : null
    ..accountStores = json['accountStores'] != null
        ? ObservableMap<String, EncointerAccountStore>.of((json['accountStores'] as Map<String, dynamic>).map(
            (k, e) => MapEntry(k, e == null ? null : EncointerAccountStore.fromJson(e as Map<String, dynamic>)),
          ))
        : null;
}

Map<String, dynamic> _$EncointerStoreToJson(EncointerStore instance) => <String, dynamic>{
      'network': instance.network,
      'currentPhase': _$CeremonyPhaseEnumMap[instance.currentPhase],
      'phaseDurations': instance.phaseDurations?.map((k, e) => MapEntry(_$CeremonyPhaseEnumMap[k], e)),
      'currentCeremonyIndex': instance.currentCeremonyIndex,
      'communityIdentifiers': instance.communityIdentifiers?.map((e) => e?.toJson())?.toList(),
      'communities': instance.communities?.map((e) => e?.toJson())?.toList(),
      'chosenCid': instance.chosenCid?.toJson(),
      'txsTransfer': instance.txsTransfer?.map((e) => e?.toJson())?.toList(),
      'businessRegistry': instance.businessRegistry?.map((e) => e?.toJson())?.toList(),
      'communityStores': instance.communityStores?.map((k, e) => MapEntry(k, e?.toJson())),
      'accountStores': instance.accountStores?.map((k, e) => MapEntry(k, e?.toJson())),
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries.singleWhere((e) => e.value == source, orElse: () => null)?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$CeremonyPhaseEnumMap = {
  CeremonyPhase.REGISTERING: 'REGISTERING',
  CeremonyPhase.ASSIGNING: 'ASSIGNING',
  CeremonyPhase.ATTESTING: 'ATTESTING',
};

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EncointerStore on _EncointerStore, Store {
  Computed<dynamic> _$currentPhaseDurationComputed;

  @override
  dynamic get currentPhaseDuration => (_$currentPhaseDurationComputed ??=
          Computed<dynamic>(() => super.currentPhaseDuration, name: '_EncointerStore.currentPhaseDuration'))
      .value;
  Computed<BalanceEntry> _$communityBalanceEntryComputed;

  @override
  BalanceEntry get communityBalanceEntry => (_$communityBalanceEntryComputed ??=
          Computed<BalanceEntry>(() => super.communityBalanceEntry, name: '_EncointerStore.communityBalanceEntry'))
      .value;
  Computed<double> _$communityBalanceComputed;

  @override
  double get communityBalance => (_$communityBalanceComputed ??=
          Computed<double>(() => super.communityBalance, name: '_EncointerStore.communityBalance'))
      .value;
  Computed<dynamic> _$communitiesContainsChosenCidComputed;

  @override
  dynamic get communitiesContainsChosenCid =>
      (_$communitiesContainsChosenCidComputed ??= Computed<dynamic>(() => super.communitiesContainsChosenCid,
              name: '_EncointerStore.communitiesContainsChosenCid'))
          .value;
  Computed<dynamic> _$communityComputed;

  @override
  dynamic get community =>
      (_$communityComputed ??= Computed<dynamic>(() => super.community, name: '_EncointerStore.community')).value;
  Computed<dynamic> _$communityAccountComputed;

  @override
  dynamic get communityAccount => (_$communityAccountComputed ??=
          Computed<dynamic>(() => super.communityAccount, name: '_EncointerStore.communityAccount'))
      .value;
  Computed<dynamic> _$accountComputed;

  @override
  dynamic get account =>
      (_$accountComputed ??= Computed<dynamic>(() => super.account, name: '_EncointerStore.account')).value;
  Computed<bool> _$showStartCeremonyButtonComputed;

  @override
  bool get showStartCeremonyButton => (_$showStartCeremonyButtonComputed ??=
          Computed<bool>(() => super.showStartCeremonyButton, name: '_EncointerStore.showStartCeremonyButton'))
      .value;
  Computed<bool> _$showTwoBoxesComputed;

  @override
  bool get showTwoBoxes =>
      (_$showTwoBoxesComputed ??= Computed<bool>(() => super.showTwoBoxes, name: '_EncointerStore.showTwoBoxes')).value;

  final _$currentPhaseAtom = Atom(name: '_EncointerStore.currentPhase');

  @override
  CeremonyPhase get currentPhase {
    _$currentPhaseAtom.reportRead();
    return super.currentPhase;
  }

  @override
  set currentPhase(CeremonyPhase value) {
    _$currentPhaseAtom.reportWrite(value, super.currentPhase, () {
      super.currentPhase = value;
    });
  }

  final _$phaseDurationsAtom = Atom(name: '_EncointerStore.phaseDurations');

  @override
  Map<CeremonyPhase, int> get phaseDurations {
    _$phaseDurationsAtom.reportRead();
    return super.phaseDurations;
  }

  @override
  set phaseDurations(Map<CeremonyPhase, int> value) {
    _$phaseDurationsAtom.reportWrite(value, super.phaseDurations, () {
      super.phaseDurations = value;
    });
  }

  final _$currentCeremonyIndexAtom = Atom(name: '_EncointerStore.currentCeremonyIndex');

  @override
  int get currentCeremonyIndex {
    _$currentCeremonyIndexAtom.reportRead();
    return super.currentCeremonyIndex;
  }

  @override
  set currentCeremonyIndex(int value) {
    _$currentCeremonyIndexAtom.reportWrite(value, super.currentCeremonyIndex, () {
      super.currentCeremonyIndex = value;
    });
  }

  final _$communityIdentifiersAtom = Atom(name: '_EncointerStore.communityIdentifiers');

  @override
  List<CommunityIdentifier> get communityIdentifiers {
    _$communityIdentifiersAtom.reportRead();
    return super.communityIdentifiers;
  }

  @override
  set communityIdentifiers(List<CommunityIdentifier> value) {
    _$communityIdentifiersAtom.reportWrite(value, super.communityIdentifiers, () {
      super.communityIdentifiers = value;
    });
  }

  final _$communitiesAtom = Atom(name: '_EncointerStore.communities');

  @override
  List<CidName> get communities {
    _$communitiesAtom.reportRead();
    return super.communities;
  }

  @override
  set communities(List<CidName> value) {
    _$communitiesAtom.reportWrite(value, super.communities, () {
      super.communities = value;
    });
  }

  final _$chosenCidAtom = Atom(name: '_EncointerStore.chosenCid');

  @override
  CommunityIdentifier get chosenCid {
    _$chosenCidAtom.reportRead();
    return super.chosenCid;
  }

  @override
  set chosenCid(CommunityIdentifier value) {
    _$chosenCidAtom.reportWrite(value, super.chosenCid, () {
      super.chosenCid = value;
    });
  }

  final _$txsTransferAtom = Atom(name: '_EncointerStore.txsTransfer');

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

  final _$businessRegistryAtom = Atom(name: '_EncointerStore.businessRegistry');

  @override
  ObservableList<AccountBusinessTuple> get businessRegistry {
    _$businessRegistryAtom.reportRead();
    return super.businessRegistry;
  }

  @override
  set businessRegistry(ObservableList<AccountBusinessTuple> value) {
    _$businessRegistryAtom.reportWrite(value, super.businessRegistry, () {
      super.businessRegistry = value;
    });
  }

  final _$communityStoresAtom = Atom(name: '_EncointerStore.communityStores');

  @override
  ObservableMap<String, CommunityStore> get communityStores {
    _$communityStoresAtom.reportRead();
    return super.communityStores;
  }

  @override
  set communityStores(ObservableMap<String, CommunityStore> value) {
    _$communityStoresAtom.reportWrite(value, super.communityStores, () {
      super.communityStores = value;
    });
  }

  final _$accountStoresAtom = Atom(name: '_EncointerStore.accountStores');

  @override
  ObservableMap<String, EncointerAccountStore> get accountStores {
    _$accountStoresAtom.reportRead();
    return super.accountStores;
  }

  @override
  set accountStores(ObservableMap<String, EncointerAccountStore> value) {
    _$accountStoresAtom.reportWrite(value, super.accountStores, () {
      super.accountStores = value;
    });
  }

  final _$setTransferTxsAsyncAction = AsyncAction('_EncointerStore.setTransferTxs');

  @override
  Future<void> setTransferTxs(List<dynamic> list, {bool reset = false, dynamic needCache = true}) {
    return _$setTransferTxsAsyncAction.run(() => super.setTransferTxs(list, reset: reset, needCache: needCache));
  }

  final _$_cacheTxsAsyncAction = AsyncAction('_EncointerStore._cacheTxs');

  @override
  Future<void> _cacheTxs(List<dynamic> list, String cacheKey) {
    return _$_cacheTxsAsyncAction.run(() => super._cacheTxs(list, cacheKey));
  }

  final _$_EncointerStoreActionController = ActionController(name: '_EncointerStore');

  @override
  void initCommunityStore(CommunityIdentifier cid, String address) {
    final _$actionInfo = _$_EncointerStoreActionController.startAction(name: '_EncointerStore.initCommunityStore');
    try {
      return super.initCommunityStore(cid, address);
    } finally {
      _$_EncointerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void initEncointerAccountStore(String address) {
    final _$actionInfo =
        _$_EncointerStoreActionController.startAction(name: '_EncointerStore.initEncointerAccountStore');
    try {
      return super.initEncointerAccountStore(address);
    } finally {
      _$_EncointerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCurrentPhase(CeremonyPhase phase) {
    final _$actionInfo = _$_EncointerStoreActionController.startAction(name: '_EncointerStore.setCurrentPhase');
    try {
      return super.setCurrentPhase(phase);
    } finally {
      _$_EncointerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCurrentCeremonyIndex(dynamic index) {
    final _$actionInfo = _$_EncointerStoreActionController.startAction(name: '_EncointerStore.setCurrentCeremonyIndex');
    try {
      return super.setCurrentCeremonyIndex(index);
    } finally {
      _$_EncointerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateState() {
    final _$actionInfo = _$_EncointerStoreActionController.startAction(name: '_EncointerStore.updateState');
    try {
      return super.updateState();
    } finally {
      _$_EncointerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void purgeCeremonySpecificState() {
    final _$actionInfo =
        _$_EncointerStoreActionController.startAction(name: '_EncointerStore.purgeCeremonySpecificState');
    try {
      return super.purgeCeremonySpecificState();
    } finally {
      _$_EncointerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCommunityIdentifiers(List<CommunityIdentifier> cids) {
    final _$actionInfo = _$_EncointerStoreActionController.startAction(name: '_EncointerStore.setCommunityIdentifiers');
    try {
      return super.setCommunityIdentifiers(cids);
    } finally {
      _$_EncointerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCommunities(List<CidName> c) {
    final _$actionInfo = _$_EncointerStoreActionController.startAction(name: '_EncointerStore.setCommunities');
    try {
      return super.setCommunities(c);
    } finally {
      _$_EncointerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setChosenCid([CommunityIdentifier cid]) {
    final _$actionInfo = _$_EncointerStoreActionController.startAction(name: '_EncointerStore.setChosenCid');
    try {
      return super.setChosenCid(cid);
    } finally {
      _$_EncointerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setbusinessRegistry(List<AccountBusinessTuple> accBusinesses) {
    final _$actionInfo = _$_EncointerStoreActionController.startAction(name: '_EncointerStore.setbusinessRegistry');
    try {
      return super.setbusinessRegistry(accBusinesses);
    } finally {
      _$_EncointerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentPhase: ${currentPhase},
phaseDurations: ${phaseDurations},
currentCeremonyIndex: ${currentCeremonyIndex},
communityIdentifiers: ${communityIdentifiers},
communities: ${communities},
chosenCid: ${chosenCid},
txsTransfer: ${txsTransfer},
businessRegistry: ${businessRegistry},
communityStores: ${communityStores},
accountStores: ${accountStores},
currentPhaseDuration: ${currentPhaseDuration},
communityBalanceEntry: ${communityBalanceEntry},
communityBalance: ${communityBalance},
communitiesContainsChosenCid: ${communitiesContainsChosenCid},
community: ${community},
communityAccount: ${communityAccount},
account: ${account},
showStartCeremonyButton: ${showStartCeremonyButton},
showTwoBoxes: ${showTwoBoxes}
    ''';
  }
}
