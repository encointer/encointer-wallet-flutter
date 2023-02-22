// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'encointer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EncointerStore _$EncointerStoreFromJson(Map<String, dynamic> json) =>
    EncointerStore(
      json['network'] as String,
    )
      ..currentPhase = $enumDecode(_$CeremonyPhaseEnumMap, json['currentPhase'])
      ..nextPhaseTimestamp = json['nextPhaseTimestamp'] as int?
      ..phaseDurations = (json['phaseDurations'] as Map<String, dynamic>).map(
        (k, e) => MapEntry($enumDecode(_$CeremonyPhaseEnumMap, k), e as int),
      )
      ..currentCeremonyIndex = json['currentCeremonyIndex'] as int?
      ..communityIdentifiers = (json['communityIdentifiers'] as List<dynamic>)
          .map((e) => CommunityIdentifier.fromJson(e as Map<String, dynamic>))
          .toList()
      ..communities = (json['communities'] as List<dynamic>?)
          ?.map((e) => CidName.fromJson(e as Map<String, dynamic>))
          .toList()
      ..chosenCid = json['chosenCid'] == null
          ? null
          : CommunityIdentifier.fromJson(
              json['chosenCid'] as Map<String, dynamic>)
      ..bazaarStores = json['bazaarStores'] != null
          ? ObservableMap<String, BazaarStore>.of(
              (json['bazaarStores'] as Map<String, dynamic>).map(
              (k, e) =>
                  MapEntry(k, BazaarStore.fromJson(e as Map<String, dynamic>)),
            ))
          : null
      ..communityStores = json['communityStores'] != null
          ? ObservableMap<String, CommunityStore>.of(
              (json['communityStores'] as Map<String, dynamic>).map(
              (k, e) => MapEntry(
                  k, CommunityStore.fromJson(e as Map<String, dynamic>)),
            ))
          : null
      ..accountStores = json['accountStores'] != null
          ? ObservableMap<String?, EncointerAccountStore>.of(
              (json['accountStores'] as Map<String, dynamic>).map(
              (k, e) => MapEntry(
                  k, EncointerAccountStore.fromJson(e as Map<String, dynamic>)),
            ))
          : null;

Map<String, dynamic> _$EncointerStoreToJson(EncointerStore instance) =>
    <String, dynamic>{
      'network': instance.network,
      'currentPhase': _$CeremonyPhaseEnumMap[instance.currentPhase]!,
      'nextPhaseTimestamp': instance.nextPhaseTimestamp,
      'phaseDurations': instance.phaseDurations
          .map((k, e) => MapEntry(_$CeremonyPhaseEnumMap[k]!, e)),
      'currentCeremonyIndex': instance.currentCeremonyIndex,
      'communityIdentifiers':
          instance.communityIdentifiers.map((e) => e.toJson()).toList(),
      'communities': instance.communities?.map((e) => e.toJson()).toList(),
      'chosenCid': instance.chosenCid?.toJson(),
      'bazaarStores':
          instance.bazaarStores?.map((k, e) => MapEntry(k, e.toJson())),
      'communityStores':
          instance.communityStores?.map((k, e) => MapEntry(k, e.toJson())),
      'accountStores':
          instance.accountStores?.map((k, e) => MapEntry(k, e.toJson())),
    };

const _$CeremonyPhaseEnumMap = {
  CeremonyPhase.Registering: 'Registering',
  CeremonyPhase.Assigning: 'Assigning',
  CeremonyPhase.Attesting: 'Attesting',
};

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$EncointerStore on _EncointerStore, Store {
  Computed<int?>? _$currentPhaseDurationComputed;

  @override
  int? get currentPhaseDuration => (_$currentPhaseDurationComputed ??=
          Computed<int?>(() => super.currentPhaseDuration,
              name: '_EncointerStore.currentPhaseDuration'))
      .value;
  Computed<bool>? _$communitiesContainsChosenCidComputed;

  @override
  bool get communitiesContainsChosenCid =>
      (_$communitiesContainsChosenCidComputed ??= Computed<bool>(
              () => super.communitiesContainsChosenCid,
              name: '_EncointerStore.communitiesContainsChosenCid'))
          .value;
  Computed<BazaarStore?>? _$bazaarComputed;

  @override
  BazaarStore? get bazaar =>
      (_$bazaarComputed ??= Computed<BazaarStore?>(() => super.bazaar,
              name: '_EncointerStore.bazaar'))
          .value;
  Computed<CommunityStore?>? _$communityComputed;

  @override
  CommunityStore? get community =>
      (_$communityComputed ??= Computed<CommunityStore?>(() => super.community,
              name: '_EncointerStore.community'))
          .value;
  Computed<CommunityAccountStore?>? _$communityAccountComputed;

  @override
  CommunityAccountStore? get communityAccount => (_$communityAccountComputed ??=
          Computed<CommunityAccountStore?>(() => super.communityAccount,
              name: '_EncointerStore.communityAccount'))
      .value;
  Computed<EncointerAccountStore?>? _$accountComputed;

  @override
  EncointerAccountStore? get account => (_$accountComputed ??=
          Computed<EncointerAccountStore?>(() => super.account,
              name: '_EncointerStore.account'))
      .value;
  Computed<BalanceEntry?>? _$communityBalanceEntryComputed;

  @override
  BalanceEntry? get communityBalanceEntry =>
      (_$communityBalanceEntryComputed ??= Computed<BalanceEntry?>(
              () => super.communityBalanceEntry,
              name: '_EncointerStore.communityBalanceEntry'))
          .value;
  Computed<double?>? _$communityBalanceComputed;

  @override
  double? get communityBalance => (_$communityBalanceComputed ??=
          Computed<double?>(() => super.communityBalance,
              name: '_EncointerStore.communityBalance'))
      .value;
  Computed<int?>? _$assigningPhaseStartComputed;

  @override
  int? get assigningPhaseStart => (_$assigningPhaseStartComputed ??=
          Computed<int?>(() => super.assigningPhaseStart,
              name: '_EncointerStore.assigningPhaseStart'))
      .value;
  Computed<int?>? _$attestingPhaseStartComputed;

  @override
  int? get attestingPhaseStart => (_$attestingPhaseStartComputed ??=
          Computed<int?>(() => super.attestingPhaseStart,
              name: '_EncointerStore.attestingPhaseStart'))
      .value;
  Computed<int?>? _$nextRegisteringPhaseStartComputed;

  @override
  int? get nextRegisteringPhaseStart => (_$nextRegisteringPhaseStartComputed ??=
          Computed<int?>(() => super.nextRegisteringPhaseStart,
              name: '_EncointerStore.nextRegisteringPhaseStart'))
      .value;
  Computed<int?>? _$ceremonyCycleDurationComputed;

  @override
  int? get ceremonyCycleDuration => (_$ceremonyCycleDurationComputed ??=
          Computed<int?>(() => super.ceremonyCycleDuration,
              name: '_EncointerStore.ceremonyCycleDuration'))
      .value;
  Computed<bool>? _$showStartCeremonyButtonComputed;

  @override
  bool get showStartCeremonyButton => (_$showStartCeremonyButtonComputed ??=
          Computed<bool>(() => super.showStartCeremonyButton,
              name: '_EncointerStore.showStartCeremonyButton'))
      .value;
  Computed<bool>? _$showSubmitClaimsButtonComputed;

  @override
  bool get showSubmitClaimsButton => (_$showSubmitClaimsButtonComputed ??=
          Computed<bool>(() => super.showSubmitClaimsButton,
              name: '_EncointerStore.showSubmitClaimsButton'))
      .value;
  Computed<bool>? _$showMeetupInfoComputed;

  @override
  bool get showMeetupInfo =>
      (_$showMeetupInfoComputed ??= Computed<bool>(() => super.showMeetupInfo,
              name: '_EncointerStore.showMeetupInfo'))
          .value;

  late final _$currentPhaseAtom =
      Atom(name: '_EncointerStore.currentPhase', context: context);

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

  late final _$nextPhaseTimestampAtom =
      Atom(name: '_EncointerStore.nextPhaseTimestamp', context: context);

  @override
  int? get nextPhaseTimestamp {
    _$nextPhaseTimestampAtom.reportRead();
    return super.nextPhaseTimestamp;
  }

  @override
  set nextPhaseTimestamp(int? value) {
    _$nextPhaseTimestampAtom.reportWrite(value, super.nextPhaseTimestamp, () {
      super.nextPhaseTimestamp = value;
    });
  }

  late final _$phaseDurationsAtom =
      Atom(name: '_EncointerStore.phaseDurations', context: context);

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

  late final _$currentCeremonyIndexAtom =
      Atom(name: '_EncointerStore.currentCeremonyIndex', context: context);

  @override
  int? get currentCeremonyIndex {
    _$currentCeremonyIndexAtom.reportRead();
    return super.currentCeremonyIndex;
  }

  @override
  set currentCeremonyIndex(int? value) {
    _$currentCeremonyIndexAtom.reportWrite(value, super.currentCeremonyIndex,
        () {
      super.currentCeremonyIndex = value;
    });
  }

  late final _$communityIdentifiersAtom =
      Atom(name: '_EncointerStore.communityIdentifiers', context: context);

  @override
  List<CommunityIdentifier> get communityIdentifiers {
    _$communityIdentifiersAtom.reportRead();
    return super.communityIdentifiers;
  }

  @override
  set communityIdentifiers(List<CommunityIdentifier> value) {
    _$communityIdentifiersAtom.reportWrite(value, super.communityIdentifiers,
        () {
      super.communityIdentifiers = value;
    });
  }

  late final _$communitiesAtom =
      Atom(name: '_EncointerStore.communities', context: context);

  @override
  List<CidName>? get communities {
    _$communitiesAtom.reportRead();
    return super.communities;
  }

  @override
  set communities(List<CidName>? value) {
    _$communitiesAtom.reportWrite(value, super.communities, () {
      super.communities = value;
    });
  }

  late final _$chosenCidAtom =
      Atom(name: '_EncointerStore.chosenCid', context: context);

  @override
  CommunityIdentifier? get chosenCid {
    _$chosenCidAtom.reportRead();
    return super.chosenCid;
  }

  @override
  set chosenCid(CommunityIdentifier? value) {
    _$chosenCidAtom.reportWrite(value, super.chosenCid, () {
      super.chosenCid = value;
    });
  }

  late final _$bazaarStoresAtom =
      Atom(name: '_EncointerStore.bazaarStores', context: context);

  @override
  ObservableMap<String, BazaarStore>? get bazaarStores {
    _$bazaarStoresAtom.reportRead();
    return super.bazaarStores;
  }

  @override
  set bazaarStores(ObservableMap<String, BazaarStore>? value) {
    _$bazaarStoresAtom.reportWrite(value, super.bazaarStores, () {
      super.bazaarStores = value;
    });
  }

  late final _$accountStoresAtom =
      Atom(name: '_EncointerStore.accountStores', context: context);

  @override
  ObservableMap<String?, EncointerAccountStore>? get accountStores {
    _$accountStoresAtom.reportRead();
    return super.accountStores;
  }

  @override
  set accountStores(ObservableMap<String?, EncointerAccountStore>? value) {
    _$accountStoresAtom.reportWrite(value, super.accountStores, () {
      super.accountStores = value;
    });
  }

  late final _$setCommunityIdentifiersAsyncAction =
      AsyncAction('_EncointerStore.setCommunityIdentifiers', context: context);

  @override
  Future<void> setCommunityIdentifiers(List<CommunityIdentifier> cids) {
    return _$setCommunityIdentifiersAsyncAction
        .run(() => super.setCommunityIdentifiers(cids));
  }

  late final _$setChosenCidAsyncAction =
      AsyncAction('_EncointerStore.setChosenCid', context: context);

  @override
  Future<void> setChosenCid([CommunityIdentifier? cid]) {
    return _$setChosenCidAsyncAction.run(() => super.setChosenCid(cid));
  }

  late final _$setCurrentCeremonyIndexAsyncAction =
      AsyncAction('_EncointerStore.setCurrentCeremonyIndex', context: context);

  @override
  Future<void> setCurrentCeremonyIndex(int? index) {
    return _$setCurrentCeremonyIndexAsyncAction
        .run(() => super.setCurrentCeremonyIndex(index));
  }

  late final _$updateStateAsyncAction =
      AsyncAction('_EncointerStore.updateState', context: context);

  @override
  Future<void> updateState() {
    return _$updateStateAsyncAction.run(() => super.updateState());
  }

  late final _$initCommunityStoreAsyncAction =
      AsyncAction('_EncointerStore.initCommunityStore', context: context);

  @override
  Future<void> initCommunityStore(CommunityIdentifier cid, String address,
      {bool shouldCache = true}) {
    return _$initCommunityStoreAsyncAction.run(
        () => super.initCommunityStore(cid, address, shouldCache: shouldCache));
  }

  late final _$_EncointerStoreActionController =
      ActionController(name: '_EncointerStore', context: context);

  @override
  void setPhaseDurations(Map<CeremonyPhase, int> phaseDurations) {
    final _$actionInfo = _$_EncointerStoreActionController.startAction(
        name: '_EncointerStore.setPhaseDurations');
    try {
      return super.setPhaseDurations(phaseDurations);
    } finally {
      _$_EncointerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCommunities(List<CidName> c) {
    final _$actionInfo = _$_EncointerStoreActionController.startAction(
        name: '_EncointerStore.setCommunities');
    try {
      return super.setCommunities(c);
    } finally {
      _$_EncointerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCurrentPhase(CeremonyPhase phase) {
    final _$actionInfo = _$_EncointerStoreActionController.startAction(
        name: '_EncointerStore.setCurrentPhase');
    try {
      return super.setCurrentPhase(phase);
    } finally {
      _$_EncointerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNextPhaseTimestamp(int timestamp) {
    final _$actionInfo = _$_EncointerStoreActionController.startAction(
        name: '_EncointerStore.setNextPhaseTimestamp');
    try {
      return super.setNextPhaseTimestamp(timestamp);
    } finally {
      _$_EncointerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAggregatedAccountData(CommunityIdentifier cid, String address,
      AggregatedAccountData accountData) {
    final _$actionInfo = _$_EncointerStoreActionController.startAction(
        name: '_EncointerStore.setAggregatedAccountData');
    try {
      return super.setAggregatedAccountData(cid, address, accountData);
    } finally {
      _$_EncointerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void purgeCeremonySpecificState() {
    final _$actionInfo = _$_EncointerStoreActionController.startAction(
        name: '_EncointerStore.purgeCeremonySpecificState');
    try {
      return super.purgeCeremonySpecificState();
    } finally {
      _$_EncointerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<void> initEncointerAccountStore(String address,
      {bool shouldCache = true}) {
    final _$actionInfo = _$_EncointerStoreActionController.startAction(
        name: '_EncointerStore.initEncointerAccountStore');
    try {
      return super.initEncointerAccountStore(address, shouldCache: shouldCache);
    } finally {
      _$_EncointerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<void> initBazaarStore(CommunityIdentifier cid,
      {bool shouldCache = true}) {
    final _$actionInfo = _$_EncointerStoreActionController.startAction(
        name: '_EncointerStore.initBazaarStore');
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
nextRegisteringPhaseStart: ${nextRegisteringPhaseStart},
ceremonyCycleDuration: ${ceremonyCycleDuration},
showStartCeremonyButton: ${showStartCeremonyButton},
showSubmitClaimsButton: ${showSubmitClaimsButton},
showMeetupInfo: ${showMeetupInfo}
    ''';
  }
}
