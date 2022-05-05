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
    ..nextPhaseTimestamp = json['nextPhaseTimestamp'] as int
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
    ..bazaarStores = json['bazaarStores'] != null
        ? ObservableMap<String, BazaarStore>.of((json['bazaarStores'] as Map<String, dynamic>).map(
            (k, e) => MapEntry(k, e == null ? null : BazaarStore.fromJson(e as Map<String, dynamic>)),
          ))
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
      'nextPhaseTimestamp': instance.nextPhaseTimestamp,
      'phaseDurations': instance.phaseDurations?.map((k, e) => MapEntry(_$CeremonyPhaseEnumMap[k], e)),
      'currentCeremonyIndex': instance.currentCeremonyIndex,
      'communityIdentifiers': instance.communityIdentifiers?.map((e) => e?.toJson())?.toList(),
      'communities': instance.communities?.map((e) => e?.toJson())?.toList(),
      'chosenCid': instance.chosenCid?.toJson(),
      'bazaarStores': instance.bazaarStores?.map((k, e) => MapEntry(k, e?.toJson())),
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
  CeremonyPhase.Registering: 'Registering',
  CeremonyPhase.Assigning: 'Assigning',
  CeremonyPhase.Attesting: 'Attesting',
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
  Computed<dynamic> _$communitiesContainsChosenCidComputed;

  @override
  dynamic get communitiesContainsChosenCid =>
      (_$communitiesContainsChosenCidComputed ??= Computed<dynamic>(() => super.communitiesContainsChosenCid,
              name: '_EncointerStore.communitiesContainsChosenCid'))
          .value;
  Computed<BazaarStore> _$bazaarComputed;

  @override
  BazaarStore get bazaar =>
      (_$bazaarComputed ??= Computed<BazaarStore>(() => super.bazaar, name: '_EncointerStore.bazaar')).value;
  Computed<CommunityStore> _$communityComputed;

  @override
  CommunityStore get community =>
      (_$communityComputed ??= Computed<CommunityStore>(() => super.community, name: '_EncointerStore.community'))
          .value;
  Computed<CommunityAccountStore> _$communityAccountComputed;

  @override
  CommunityAccountStore get communityAccount => (_$communityAccountComputed ??=
          Computed<CommunityAccountStore>(() => super.communityAccount, name: '_EncointerStore.communityAccount'))
      .value;
  Computed<EncointerAccountStore> _$accountComputed;

  @override
  EncointerAccountStore get account =>
      (_$accountComputed ??= Computed<EncointerAccountStore>(() => super.account, name: '_EncointerStore.account'))
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
  Computed<int> _$assigningPhaseStartComputed;

  @override
  int get assigningPhaseStart => (_$assigningPhaseStartComputed ??=
          Computed<int>(() => super.assigningPhaseStart, name: '_EncointerStore.assigningPhaseStart'))
      .value;
  Computed<int> _$attestingPhaseStartComputed;

  @override
  int get attestingPhaseStart => (_$attestingPhaseStartComputed ??=
          Computed<int>(() => super.attestingPhaseStart, name: '_EncointerStore.attestingPhaseStart'))
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

  final _$nextPhaseTimestampAtom = Atom(name: '_EncointerStore.nextPhaseTimestamp');

  @override
  int get nextPhaseTimestamp {
    _$nextPhaseTimestampAtom.reportRead();
    return super.nextPhaseTimestamp;
  }

  @override
  set nextPhaseTimestamp(int value) {
    _$nextPhaseTimestampAtom.reportWrite(value, super.nextPhaseTimestamp, () {
      super.nextPhaseTimestamp = value;
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

  final _$bazaarStoresAtom = Atom(name: '_EncointerStore.bazaarStores');

  @override
  ObservableMap<String, BazaarStore> get bazaarStores {
    _$bazaarStoresAtom.reportRead();
    return super.bazaarStores;
  }

  @override
  set bazaarStores(ObservableMap<String, BazaarStore> value) {
    _$bazaarStoresAtom.reportWrite(value, super.bazaarStores, () {
      super.bazaarStores = value;
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

  final _$initCommunityStoreAsyncAction = AsyncAction('_EncointerStore.initCommunityStore');

  @override
  Future<void> initCommunityStore(CommunityIdentifier cid, String address, {dynamic shouldCache = true}) {
    return _$initCommunityStoreAsyncAction.run(() => super.initCommunityStore(cid, address, shouldCache: shouldCache));
  }

  final _$_EncointerStoreActionController = ActionController(name: '_EncointerStore');

  @override
  void setPhaseDurations(Map<CeremonyPhase, int> phaseDurations) {
    final _$actionInfo = _$_EncointerStoreActionController.startAction(name: '_EncointerStore.setPhaseDurations');
    try {
      return super.setPhaseDurations(phaseDurations);
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
  void setCurrentPhase(CeremonyPhase phase) {
    final _$actionInfo = _$_EncointerStoreActionController.startAction(name: '_EncointerStore.setCurrentPhase');
    try {
      return super.setCurrentPhase(phase);
    } finally {
      _$_EncointerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNextPhaseTimestamp(int timestamp) {
    final _$actionInfo = _$_EncointerStoreActionController.startAction(name: '_EncointerStore.setNextPhaseTimestamp');
    try {
      return super.setNextPhaseTimestamp(timestamp);
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
  Future<void> initEncointerAccountStore(String address, {dynamic shouldCache = true}) {
    final _$actionInfo =
        _$_EncointerStoreActionController.startAction(name: '_EncointerStore.initEncointerAccountStore');
    try {
      return super.initEncointerAccountStore(address, shouldCache: shouldCache);
    } finally {
      _$_EncointerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<void> initBazaarStore(CommunityIdentifier cid, {dynamic shouldCache = true}) {
    final _$actionInfo = _$_EncointerStoreActionController.startAction(name: '_EncointerStore.initBazaarStore');
    try {
      return super.initBazaarStore(cid, shouldCache: shouldCache);
    } finally {
      _$_EncointerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentPhase: ${currentPhase},
nextPhaseTimestamp: ${nextPhaseTimestamp},
phaseDurations: ${phaseDurations},
currentCeremonyIndex: ${currentCeremonyIndex},
communityIdentifiers: ${communityIdentifiers},
communities: ${communities},
chosenCid: ${chosenCid},
bazaarStores: ${bazaarStores},
accountStores: ${accountStores},
currentPhaseDuration: ${currentPhaseDuration},
communitiesContainsChosenCid: ${communitiesContainsChosenCid},
bazaar: ${bazaar},
community: ${community},
communityAccount: ${communityAccount},
account: ${account},
communityBalanceEntry: ${communityBalanceEntry},
communityBalance: ${communityBalance},
assigningPhaseStart: ${assigningPhaseStart},
attestingPhaseStart: ${attestingPhaseStart},
showStartCeremonyButton: ${showStartCeremonyButton},
showTwoBoxes: ${showTwoBoxes}
    ''';
  }
}
