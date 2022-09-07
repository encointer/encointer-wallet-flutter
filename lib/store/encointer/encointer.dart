import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';

import 'package:encointer_wallet/models/communities/cid_name.dart';
import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/models/encointer_balance_data/balance_entry.dart';
import 'package:encointer_wallet/models/index.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/store/encointer/sub_stores/bazaar_store/bazaar_store.dart';
import 'package:encointer_wallet/store/encointer/sub_stores/community_store/community_account_store/community_account_store.dart';
import 'package:encointer_wallet/store/encointer/sub_stores/community_store/community_store.dart';
import 'package:encointer_wallet/store/encointer/sub_stores/encointer_account_store/encointer_account_store.dart';

part 'encointer.g.dart';

/// Mobx-Store containing all encointer specific data.
///
/// Data specific to a community and/or account are kept in sub-stores.
///
/// ### Structure:
///               EncointerStore
///              /    |       \
///   CommunitySt.  BazaarSt.  EncointerAccountSt.
///        |
///   CommunityAccountSt.
///
/// Where CommunityStores and BazaarStores exist per Community. The `EncointerAccountStore` contains data specific
/// to an account, but across all communities. Finally, the `CommunityAccountStore` contains data specific to and
/// account **and** community.
///
/// ### Caching and Serialization
/// The stores have been designed such that all data fields are serializable. This facilitates caching the entire
/// encointer store tree with one cache call.
///
/// ### Initialization
/// The non-data fields, e.g., `_cacheFn` and `_rootStore` can't be serialized, and can therefore not be mandatory
/// constructor parameters, implying they need to be initialized by other means. Such fields should be private fields
/// and shall **only** be settable by the `initStore` method. This prevents forgetting to set fields, which are added
/// later to the store.
@JsonSerializable(explicitToJson: true)
class EncointerStore extends _EncointerStore with _$EncointerStore {
  EncointerStore(String network) : super(network);

  factory EncointerStore.fromJson(Map<String, dynamic> json) => _$EncointerStoreFromJson(json);
  Map<String, dynamic> toJson() => _$EncointerStoreToJson(this);
}

abstract class _EncointerStore with Store {
  _EncointerStore(this.network);

  @JsonKey(ignore: true)
  late AppStore _rootStore;

  // Note: In synchronous code, every modification of an @observable is tracked by mobx and
  // fires a reaction. However, modifications in asynchronous code must be wrapped in
  // a `@action` block to fire a reaction.
  //
  // Note2: In case of Map/List: If the variable is declared as plain Map/List with `@observable` annotated, mobx
  // tracks variable assignment but not if individual items are changed. If this is wanted, the variable must be
  // declared as `ObservableList/-Map`.

  /// Caches the store to local storage.
  @JsonKey(ignore: true)
  Future<void> Function()? _cacheFn;

  /// The encointer network this store belongs to
  final String network;

  /// In order to prevent multiple simultaneous update calls.
  ///
  /// It does not need to be an observable, as we only read it actively.
  @JsonKey(ignore: true)
  Future<void>? _updateStateFuture;

  @observable
  CeremonyPhase currentPhase = CeremonyPhase.Registering;

  @observable
  int? nextPhaseTimestamp;

  @observable
  Map<CeremonyPhase, int> phaseDurations = Map();

  @computed
  get currentPhaseDuration => phaseDurations[currentPhase];

  @observable
  int? currentCeremonyIndex;

  @observable
  List<CommunityIdentifier> communityIdentifiers = [];

  @observable
  List<CidName>? communities;

  @observable
  CommunityIdentifier? chosenCid;

  /// Checks if the chosenCid is contained in the communities.
  ///
  /// This is only relevant for edge-cases, where the chain does no longer contain a community. E.g. a dev-chain was
  /// purged or a community as been marked as inactive and was removed.
  @computed
  get communitiesContainsChosenCid {
    return chosenCid != null && communities!.isNotEmpty && communities!.where((cn) => cn.cid == chosenCid).isNotEmpty;
  }

  // -- sub-stores

  /// Bazaar sub-stores.
  ///
  /// Map: CommunityIdentifier.toFmtString() -> `BazaarStore`.
  @observable
  ObservableMap<String, BazaarStore>? bazaarStores = ObservableMap();

  /// Community sub-stores.
  ///
  /// Map: CommunityIdentifier.toFmtString() -> `CommunityStore`.
  ObservableMap<String, CommunityStore>? communityStores = ObservableMap();

  /// EncointerAccount sub-stores.
  ///
  /// Map: Address SS58 -> `CommunityStore`.
  @observable
  ObservableMap<String?, EncointerAccountStore>? accountStores = ObservableMap();

  /// The `BazaarStore` for the currently chosen community.
  @computed
  BazaarStore? get bazaar {
    return chosenCid != null ? bazaarStores![chosenCid!.toFmtString()] : null;
  }

  /// The `CommunityStore` for the currently chosen community.
  @computed
  CommunityStore? get community {
    return chosenCid != null ? communityStores![chosenCid!.toFmtString()] : null;
  }

  /// The `CommunityAccountStore` for the currently chosen community and account.
  @computed
  CommunityAccountStore? get communityAccount {
    return community != null ? community!.communityAccountStores![_rootStore.account.currentAddress] : null;
  }

  /// The `EncointerAccountStore` for the currently chosen account.
  @computed
  EncointerAccountStore? get account {
    return accountStores![_rootStore.account.currentAddress];
  }

  // -- computed values derived from sub-stores

  @computed
  BalanceEntry? get communityBalanceEntry {
    if (chosenCid != null) {
      bool containsBalance = account?.balanceEntries.containsKey(chosenCid!.toFmtString()) ?? false;
      return containsBalance ? account!.balanceEntries[chosenCid!.toFmtString()] : null;
    } else {
      return null;
    }
  }

  @computed
  double? get communityBalance {
    return applyDemurrage(communityBalanceEntry);
  }

  double? applyDemurrage(BalanceEntry? entry) {
    if (_rootStore.chain.latestHeaderNumber != null &&
        entry != null &&
        community != null &&
        community!.demurrage != null) {
      return entry.applyDemurrage(_rootStore.chain.latestHeaderNumber, community!.demurrage!);
    }
    return null;
  }

  CommunityIdentifier? getTxPaymentAsset(CommunityIdentifier? preferredCid) {
    if (preferredCid != null && communityBalance != null && communityBalance! > 0.013) {
      return preferredCid;
    }

    try {
      final fallbackCidFmt = account!.balanceEntries.entries.firstWhere((e) => applyDemurrage(e.value)! > 0.013).key;
      return CommunityIdentifier.fromFmtString(fallbackCidFmt);
    } catch (e, s) {
      Log.e(
        '${account!.address} does not have sufficient funds in any community. Returning null to pay tx in native token',
        'EncointerStore',
        s,
      );

      return null;
    }
  }

  // -- Setters for this store

  @action
  void setPhaseDurations(Map<CeremonyPhase, int> phaseDurations) {
    Log.d('set phase duration to $phaseDurations', 'EncointerStore');

    this.phaseDurations = phaseDurations;
    writeToCache();
  }

  @action
  void setCommunityIdentifiers(List<CommunityIdentifier> cids) {
    Log.d('set communityIdentifiers to $cids', 'EncointerStore');

    communityIdentifiers = cids;
    writeToCache();

    if (communities != null && !communitiesContainsChosenCid) {
      // inconsistency found, reset state
      setChosenCid();
    }
  }

  @action
  void setCommunities(List<CidName> c) {
    Log.d('set communities to $c', 'EncointerStore');

    communities = c;
    writeToCache();
  }

  @action
  void setChosenCid([CommunityIdentifier? cid]) {
    if (chosenCid != cid) {
      chosenCid = cid;
      writeToCache();

      if (cid != null) {
        _rootStore.localStorage.setObject(chosenCidCacheKey(network), cid.toJson());
        initCommunityStore(cid, _rootStore.account.currentAddress);
        initBazaarStore(cid);
      } else {
        _rootStore.localStorage.removeKey(chosenCidCacheKey(network));
      }
    }

    if (_rootStore.settings.endpointIsNoTee) {
      webApi.encointer.subscribeBusinessRegistry();
    }

    // update depending values without awaiting
    if (!_rootStore.settings.loading) {
      webApi.encointer.getCommunityData();
    }
  }

  @action
  void setCurrentPhase(CeremonyPhase phase) {
    Log.d('set currentPhase to $phase', 'EncointerStore');

    if (currentPhase != phase) {
      currentPhase = phase;
      writeToCache();
    }
    // update depending values without awaiting
    webApi.encointer.getCurrentCeremonyIndex();
  }

  @action
  void setNextPhaseTimestamp(int timestamp) {
    Log.d('set nextPhaseTimestamp to $timestamp', 'EncointerStore');

    if (nextPhaseTimestamp != timestamp) {
      nextPhaseTimestamp = timestamp;
      writeToCache();
    }
  }

  @action
  void setCurrentCeremonyIndex(index) {
    Log.d('store: set currentCeremonyIndex to $index', 'EncointerStore');

    if (currentCeremonyIndex != index) {
      purgeCeremonySpecificState();
    }

    currentCeremonyIndex = index;
    writeToCache();

    // update depending values without awaiting
    updateState();
  }

  @action
  void setAggregatedAccountData(CommunityIdentifier cid, String address, AggregatedAccountData accountData) {
    var encointerAccountStore = communityStores![cid.toFmtString()]!.communityAccountStores![address];

    if (encointerAccountStore == null) {
      Log.d('setAggregatedAccountData: encointerAccountStore was null', 'EncointerStore');
      return;
    }

    accountData.personal?.meetup != null
        ? encointerAccountStore.setMeetup(accountData.personal!.meetup)
        : encointerAccountStore.purgeMeetup();

    accountData.personal?.participantType != null
        ? encointerAccountStore.setParticipantType(accountData.personal!.participantType)
        : encointerAccountStore.purgeParticipantType();
  }

  // -- other helpers

  /// Update all the encointer state.
  ///
  /// Will await a previous update future if an update has already been triggered.
  @action
  Future<void> updateState() async {
    if (_updateStateFuture != null) {
      Log.d('[updateState] already updating state, awaiting the previously set future.', 'EncointerStore');

      await _updateStateFuture!;
      return;
    }

    _updateStateFuture = Future.wait([
      webApi.encointer.getCommunityMetadata(),
      webApi.encointer.getAllMeetupLocations(),
      webApi.encointer.getDemurrage(),
      webApi.encointer.getBootstrappers(),
      webApi.encointer.getReputations(),
      webApi.encointer.getMeetupTime(),
      webApi.encointer.getMeetupTimeOverride(),
      updateAggregatedAccountData(),
    ])
        .timeout(const Duration(seconds: 15))
        // ignore: invalid_return_type_for_catch_error
        .catchError((e, s) => Log.e('Error executing update state: $e', 'EncointerStore', s))
        .whenComplete(() {
      Log.d('[updateState] finished', 'EncointerStore');

      _updateStateFuture = null;
    });

    await _updateStateFuture!;
  }

  Future<void> updateAggregatedAccountData() async {
    try {
      var data = await webApi.encointer.getAggregatedAccountData(chosenCid!, _rootStore.account.currentAddress);
      setAggregatedAccountData(chosenCid!, _rootStore.account.currentAddress, data);
    } catch (e, s) {
      Log.e('$e', 'EncointerStore', s);
    }
  }

  @action
  void purgeCeremonySpecificState() {
    communityStores!.forEach((cid, store) => store.purgeCeremonySpecificState());
    accountStores!.forEach((cid, store) => store.purgeCeremonySpecificState());
  }

  /// Initialize the store and the sub-stores.
  ///
  /// Should always be called after creating a store to ensure full functionality.
  void initStore(AppStore root, Future<void> Function() cacheFn) {
    _rootStore = root;
    _cacheFn = cacheFn;

    // These are merely safety guards, and should never be needed. A null reference error occurred here only because
    // a store was added in the development process after it has been written to cache. Hence, deserialization
    // initialized it with null.
    if (accountStores == null) {
      accountStores = ObservableMap();
    }

    if (bazaarStores == null) {
      bazaarStores = ObservableMap();
    }

    if (communityStores == null) {
      communityStores = ObservableMap();
    }

    accountStores!.forEach((cid, store) => store.initStore(cacheFn));
    bazaarStores!.forEach((cid, store) => store.initStore(cacheFn));
    communityStores!.forEach((cid, store) => store.initStore(cacheFn, applyDemurrage));

    loadChosenCid(network);
  }

  Future<void> writeToCache() {
    if (_cacheFn != null) {
      return _cacheFn!();
    } else {
      return Future.value(null);
    }
  }

  // -- init functions for sub-stores

  /// Init community sub-stores for all cids and the given address.
  ///
  /// Todo: Integrate used when #582 is tackled.
  Future<void> initCommunityStores(List<CommunityIdentifier> cids, String address, {shouldCache = true}) {
    List<Future<void>> futures = [];

    cids.forEach((cid) {
      futures.add(initCommunityStore(cid, address, shouldCache: shouldCache));
    });

    return Future.wait(futures);
  }

  @action
  Future<void> initCommunityStore(CommunityIdentifier cid, String address, {shouldCache = true}) async {
    var cidFmt = cid.toFmtString();
    if (!communityStores!.containsKey(cidFmt)) {
      Log.d('Adding new communityStore for cid: ${cid.toFmtString()}', 'EncointerStore');

      var communityStore = CommunityStore(network, cid);
      communityStore.initStore(_cacheFn, applyDemurrage);
      await communityStore.initCommunityAccountStore(address);

      communityStores![cidFmt] = communityStore;
      return shouldCache ? writeToCache() : Future.value(null);
    } else {
      Log.d("Don't add already existing communityStore for cid: ${cid.toFmtString()}", 'EncointerStore');
      await communityStores![cidFmt]!.initCommunityAccountStore(address);
      return Future.value(null);
    }
  }

  @action
  Future<void> initEncointerAccountStore(String address, {shouldCache = true}) {
    if (!accountStores!.containsKey(address)) {
      Log.d('Adding new encointerAccountStore for: $address', 'EncointerStore');

      var encointerAccountStore = EncointerAccountStore(network, address);
      encointerAccountStore.initStore(_cacheFn);

      accountStores![address] = encointerAccountStore;
      return shouldCache ? writeToCache() : Future.value(null);
    } else {
      Log.d("Don't add already existing encointerAccountStore for address: $address", 'EncointerStore');
      return Future.value(null);
    }
  }

  @action
  Future<void> initBazaarStore(CommunityIdentifier cid, {shouldCache = true}) {
    var cidFmt = cid.toFmtString();
    if (!bazaarStores!.containsKey(cidFmt)) {
      Log.d('Adding new bazaarStore for cid: ${cid.toFmtString()}', 'EncointerStore');
      var bazaarStore = BazaarStore(network, cid);
      bazaarStore.initStore(_cacheFn);

      bazaarStores![cidFmt] = bazaarStore;
      return shouldCache ? writeToCache() : Future.value(null);
    } else {
      Log.d("Don't add already existing bazaarStore for cid: ${cid.toFmtString()}", 'EncointerStore');
      return Future.value(null);
    }
  }

  /// Initializes stores that have not been initialized before.
  ///
  /// This should be called upon changing the current account mainly, or after loading the store from cache.
  Future<void> initializeUninitializedStores(String address) {
    var futures = [initEncointerAccountStore(address, shouldCache: false)];

    if (chosenCid != null) {
      futures.addAll([
        initBazaarStore(chosenCid!, shouldCache: false),
        initCommunityStore(chosenCid!, address, shouldCache: false)
      ]);
    }

    return Future.wait(futures);
  }

  /// Load tracked communities from cache
  ///
  /// This is done separately to initialize a new encointer-store with all tracked communities
  /// if it recreated due to incompatibility with an old cache version.
  ///
  /// Todo: not yet integrated, need to cache this first, and properly think through. Solve in #582.
  Future<void> loadPreviouslyTrackedCommunitiesFromCache(String network) async {
    List<Map<String, dynamic>> maybeCids = await _rootStore.localStorage.getList(trackedCidsCacheKey(network));
    Log.d('Initializing previously tracked communities: $maybeCids', 'EncointerStore');
    if (maybeCids.isNotEmpty) {
      List<CommunityIdentifier> cids = maybeCids.map((cid) => CommunityIdentifier.fromJson(cid)).toList();
      communityIdentifiers = cids;
    }
  }

  Future<void> loadChosenCid(String network) async {
    Map<String, dynamic>? maybeChosenCid = await _rootStore.localStorage.getMap(chosenCidCacheKey(network));
    Log.d('Setting previously tracked chosenCid: $maybeChosenCid', 'EncointerStore');
    if (maybeChosenCid != null) {
      // Do not use the setter here. We don't want to trigger reactions here.
      chosenCid = CommunityIdentifier.fromJson(maybeChosenCid);
    }
  }

  // ----- Computed values for ceremony box

  @computed
  int? get assigningPhaseStart {
    if (nextPhaseTimestamp == null || phaseDurations.isEmpty) {
      return null;
    }
    switch (currentPhase) {
      case CeremonyPhase.Registering:
        return nextPhaseTimestamp;
      case CeremonyPhase.Assigning:
        return nextPhaseTimestamp! - phaseDurations[CeremonyPhase.Assigning]!;
      case CeremonyPhase.Attesting:
        return nextPhaseTimestamp! -
            phaseDurations[CeremonyPhase.Attesting]! -
            phaseDurations[CeremonyPhase.Assigning]!;
      default:
        return null;
    }
  }

  @computed
  int? get attestingPhaseStart {
    if (assigningPhaseStart == null) {
      return null;
    }
    return assigningPhaseStart! + phaseDurations[CeremonyPhase.Assigning]!;
  }

  bool get showRegisterButton {
    bool registered = communityAccount?.isRegistered ?? false;
    return (currentPhase == CeremonyPhase.Registering && !registered);
  }

  @computed
  bool get showStartCeremonyButton {
    bool assigned = communityAccount?.isAssigned ?? false;
    return (currentPhase == CeremonyPhase.Attesting && assigned);
  }

  @computed
  bool get showSubmitClaimsButton {
    bool assigned = communityAccount?.isAssigned ?? false;
    bool? hasClaims = (communityAccount?.scannedClaimsCount ?? 0) > 0;
    return (currentPhase == CeremonyPhase.Attesting && assigned && hasClaims!);
  }

  @computed
  bool get showMeetupInfo {
    return !showRegisterButton && !showStartCeremonyButton || (currentPhase == CeremonyPhase.Attesting);
  }
}

String chosenCidCacheKey(String? network) {
  return '$network-chosen-cid';
}

String trackedCidsCacheKey(String network) {
  return '$network-tracked-cids';
}
