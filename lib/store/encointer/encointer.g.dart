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
    ..balanceEntries = json['balanceEntries'] != null
        ? ObservableMap<String, BalanceEntry>.of((json['balanceEntries'] as Map<String, dynamic>).map(
            (k, e) => MapEntry(k, e == null ? null : BalanceEntry.fromJson(e as Map<String, dynamic>)),
          ))
        : null
    ..communityIdentifiers = (json['communityIdentifiers'] as List)
        ?.map((e) => e == null ? null : CommunityIdentifier.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..communities = (json['communities'] as List)
        ?.map((e) => e == null ? null : CidName.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..chosenCid =
        json['chosenCid'] == null ? null : CommunityIdentifier.fromJson(json['chosenCid'] as Map<String, dynamic>)
    ..demurrage = (json['demurrage'] as num)?.toDouble()
    ..participantsClaims = json['participantsClaims'] != null
        ? ObservableMap<String, ClaimOfAttendance>.of((json['participantsClaims'] as Map<String, dynamic>).map(
            (k, e) => MapEntry(k, e == null ? null : ClaimOfAttendance.fromJson(e as Map<String, dynamic>)),
          ))
        : null
    ..txsTransfer = json['txsTransfer'] != null
        ? ObservableList<TransferData>.of((json['txsTransfer'] as List)
            .map((e) => e == null ? null : TransferData.fromJson(e as Map<String, dynamic>)))
        : null
    ..reputations = (json['reputations'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(int.parse(k), e == null ? null : CommunityReputation.fromJson(e as Map<String, dynamic>)),
    )
    ..businessRegistry = json['businessRegistry'] != null
        ? ObservableList<AccountBusinessTuple>.of((json['businessRegistry'] as List)
            .map((e) => e == null ? null : AccountBusinessTuple.fromJson(e as Map<String, dynamic>)))
        : null
    ..communityLocations = json['communityLocations'] != null
        ? ObservableList<Location>.of((json['communityLocations'] as List)
            .map((e) => e == null ? null : Location.fromJson(e as Map<String, dynamic>)))
        : null
    ..communityStores = json['communityStores'] != null
        ? ObservableMap<String, CommunityStore>.of((json['communityStores'] as Map<String, dynamic>).map(
            (k, e) => MapEntry(k, e == null ? null : CommunityStore.fromJson(e as Map<String, dynamic>)),
          ))
        : null;
}

Map<String, dynamic> _$EncointerStoreToJson(EncointerStore instance) => <String, dynamic>{
      'network': instance.network,
      'currentPhase': _$CeremonyPhaseEnumMap[instance.currentPhase],
      'phaseDurations': instance.phaseDurations?.map((k, e) => MapEntry(_$CeremonyPhaseEnumMap[k], e)),
      'currentCeremonyIndex': instance.currentCeremonyIndex,
      'balanceEntries': instance.balanceEntries?.map((k, e) => MapEntry(k, e?.toJson())),
      'communityIdentifiers': instance.communityIdentifiers?.map((e) => e?.toJson())?.toList(),
      'communities': instance.communities?.map((e) => e?.toJson())?.toList(),
      'chosenCid': instance.chosenCid?.toJson(),
      'demurrage': instance.demurrage,
      'participantsClaims': instance.participantsClaims?.map((k, e) => MapEntry(k, e?.toJson())),
      'txsTransfer': instance.txsTransfer?.map((e) => e?.toJson())?.toList(),
      'reputations': instance.reputations?.map((k, e) => MapEntry(k.toString(), e?.toJson())),
      'businessRegistry': instance.businessRegistry?.map((e) => e?.toJson())?.toList(),
      'communityLocations': instance.communityLocations?.map((e) => e?.toJson())?.toList(),
      'communityStores': instance.communityStores?.map((k, e) => MapEntry(k, e?.toJson())),
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
  Computed<dynamic> _$scannedClaimsCountComputed;

  @override
  dynamic get scannedClaimsCount => (_$scannedClaimsCountComputed ??=
          Computed<dynamic>(() => super.scannedClaimsCount, name: '_EncointerStore.scannedClaimsCount'))
      .value;
  Computed<dynamic> _$ceremonyIndexForProofOfAttendanceComputed;

  @override
  dynamic get ceremonyIndexForProofOfAttendance =>
      (_$ceremonyIndexForProofOfAttendanceComputed ??= Computed<dynamic>(() => super.ceremonyIndexForProofOfAttendance,
              name: '_EncointerStore.ceremonyIndexForProofOfAttendance'))
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

  final _$balanceEntriesAtom = Atom(name: '_EncointerStore.balanceEntries');

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

  final _$demurrageAtom = Atom(name: '_EncointerStore.demurrage');

  @override
  double get demurrage {
    _$demurrageAtom.reportRead();
    return super.demurrage;
  }

  @override
  set demurrage(double value) {
    _$demurrageAtom.reportWrite(value, super.demurrage, () {
      super.demurrage = value;
    });
  }

  final _$participantsClaimsAtom = Atom(name: '_EncointerStore.participantsClaims');

  @override
  ObservableMap<String, ClaimOfAttendance> get participantsClaims {
    _$participantsClaimsAtom.reportRead();
    return super.participantsClaims;
  }

  @override
  set participantsClaims(ObservableMap<String, ClaimOfAttendance> value) {
    _$participantsClaimsAtom.reportWrite(value, super.participantsClaims, () {
      super.participantsClaims = value;
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

  final _$reputationsAtom = Atom(name: '_EncointerStore.reputations');

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

  final _$communityLocationsAtom = Atom(name: '_EncointerStore.communityLocations');

  @override
  ObservableList<Location> get communityLocations {
    _$communityLocationsAtom.reportRead();
    return super.communityLocations;
  }

  @override
  set communityLocations(ObservableList<Location> value) {
    _$communityLocationsAtom.reportWrite(value, super.communityLocations, () {
      super.communityLocations = value;
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
  dynamic resetState() {
    final _$actionInfo = _$_EncointerStoreActionController.startAction(name: '_EncointerStore.resetState');
    try {
      return super.resetState();
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
  void setCommunityLocations([List<Location> locations]) {
    final _$actionInfo = _$_EncointerStoreActionController.startAction(name: '_EncointerStore.setCommunityLocations');
    try {
      return super.setCommunityLocations(locations);
    } finally {
      _$_EncointerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDemurrage(double d) {
    final _$actionInfo = _$_EncointerStoreActionController.startAction(name: '_EncointerStore.setDemurrage');
    try {
      return super.setDemurrage(d);
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
  void purgeParticipantsClaims() {
    final _$actionInfo = _$_EncointerStoreActionController.startAction(name: '_EncointerStore.purgeParticipantsClaims');
    try {
      return super.purgeParticipantsClaims();
    } finally {
      _$_EncointerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addParticipantClaim(ClaimOfAttendance claim) {
    final _$actionInfo = _$_EncointerStoreActionController.startAction(name: '_EncointerStore.addParticipantClaim');
    try {
      return super.addParticipantClaim(claim);
    } finally {
      _$_EncointerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setReputations(Map<int, CommunityReputation> reps) {
    final _$actionInfo = _$_EncointerStoreActionController.startAction(name: '_EncointerStore.setReputations');
    try {
      return super.setReputations(reps);
    } finally {
      _$_EncointerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void purgeReputations() {
    final _$actionInfo = _$_EncointerStoreActionController.startAction(name: '_EncointerStore.purgeReputations');
    try {
      return super.purgeReputations();
    } finally {
      _$_EncointerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addBalanceEntry(CommunityIdentifier cid, BalanceEntry balanceEntry) {
    final _$actionInfo = _$_EncointerStoreActionController.startAction(name: '_EncointerStore.addBalanceEntry');
    try {
      return super.addBalanceEntry(cid, balanceEntry);
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
balanceEntries: ${balanceEntries},
communityIdentifiers: ${communityIdentifiers},
communities: ${communities},
chosenCid: ${chosenCid},
demurrage: ${demurrage},
participantsClaims: ${participantsClaims},
txsTransfer: ${txsTransfer},
reputations: ${reputations},
businessRegistry: ${businessRegistry},
communityLocations: ${communityLocations},
communityStores: ${communityStores},
currentPhaseDuration: ${currentPhaseDuration},
scannedClaimsCount: ${scannedClaimsCount},
ceremonyIndexForProofOfAttendance: ${ceremonyIndexForProofOfAttendance},
communityBalanceEntry: ${communityBalanceEntry},
communityBalance: ${communityBalance},
communitiesContainsChosenCid: ${communitiesContainsChosenCid},
community: ${community},
communityAccount: ${communityAccount},
showStartCeremonyButton: ${showStartCeremonyButton},
showTwoBoxes: ${showTwoBoxes}
    ''';
  }
}
