import 'dart:math';

import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/store/encointer/types/communities.dart';
import 'package:encointer_wallet/store/encointer/types/encointerBalanceData.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';

import '../../models/index.dart';
import 'sub_stores/bazaar_store/bazaarStore.dart';
import 'sub_stores/community_store/communityStore.dart';
import 'sub_stores/community_store/community_account_store/communityAccountStore.dart';
import 'sub_stores/encointer_account_store/encointerAccountStore.dart';

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
  AppStore _rootStore;

  // Note: In synchronous code, every modification of an @observable is tracked by mobx and
  // fires a reaction. However, modifications in asynchronous code must be wrapped in
  // a `@action` block to fire a reaction.
  //
  // Note2: In case of Map/List: If the variable is declared as plain Map/List with `@observable` annotated, mobx
  // tracks variable assignment but not if individual items are changed. If this is wanted, the variable must be
  // declared as `ObservableList/-Map`.

  /// Caches the store to local storage.
  @JsonKey(ignore: true)
  Future<void> Function() _cacheFn;

  /// The encointer network this store belongs to
  final String network;

  @observable
  CeremonyPhase currentPhase;

  @observable
  Map<CeremonyPhase, int> phaseDurations = new Map();

  @computed
  get currentPhaseDuration => phaseDurations[currentPhase];

  @observable
  int currentCeremonyIndex;

  @observable
  List<CommunityIdentifier> communityIdentifiers;

  @observable
  List<CidName> communities;

  @observable
  CommunityIdentifier chosenCid;

  /// Checks if the chosenCid is contained in the communities.
  ///
  /// This is only relevant for edge-cases, where the chain does no longer contain a community. E.g. a dev-chain was
  /// purged or a community as been marked as inactive and was removed.
  @computed
  get communitiesContainsChosenCid {
    return chosenCid != null && communities.isNotEmpty && communities.where((cn) => cn.cid == chosenCid).isNotEmpty;
  }

  // -- sub-stores

  /// Bazaar sub-stores.
  ///
  /// Map: CommunityIdentifier.toFmtString() -> `BazaarStore`.
  @observable
  ObservableMap<String, BazaarStore> bazaarStores = new ObservableMap();

  /// Community sub-stores.
  ///
  /// Map: CommunityIdentifier.toFmtString() -> `CommunityStore`.
  ObservableMap<String, CommunityStore> communityStores = new ObservableMap();

  /// EncointerAccount sub-stores.
  ///
  /// Map: Address SS58 -> `CommunityStore`.
  @observable
  ObservableMap<String, EncointerAccountStore> accountStores = new ObservableMap();

  /// The `BazaarStore` for the currently chosen community.
  @computed
  BazaarStore get bazaar {
    return chosenCid != null ? bazaarStores[chosenCid.toFmtString()] : null;
  }

  /// The `CommunityStore` for the currently chosen community.
  @computed
  CommunityStore get community {
    return chosenCid != null ? communityStores[chosenCid.toFmtString()] : null;
  }

  /// The `CommunityAccountStore` for the currently chosen community and account.
  @computed
  CommunityAccountStore get communityAccount {
    return community != null ? community.communityAccountStores[_rootStore.account.currentAddress] : null;
  }

  /// The `EncointerAccountStore` for the currently chosen account.
  @computed
  EncointerAccountStore get account {
    return accountStores[_rootStore.account.currentAddress];
  }

  // -- computed values derived from sub-stores

  @computed
  BalanceEntry get communityBalanceEntry {
    if (chosenCid != null) {
      bool containsBalance = account?.balanceEntries?.containsKey(chosenCid.toFmtString()) ?? false;
      return containsBalance ? account.balanceEntries[chosenCid.toFmtString()] : null;
    } else {
      return null;
    }
  }

  @computed
  double get communityBalance {
    return applyDemurrage(communityBalanceEntry);
  }

  double applyDemurrage(BalanceEntry entry) {
    double res;
    if (_rootStore.chain.latestHeaderNumber != null && entry != null && community.demurrage != null) {
      int elapsed = _rootStore.chain.latestHeaderNumber - entry.lastUpdate;
      double exponent = -community.demurrage * elapsed;
      res = entry.principal * pow(e, exponent);
    }
    return res;
  }

  // -- Setters for this store

  @action
  void setCommunityIdentifiers(List<CommunityIdentifier> cids) {
    _log("set communityIdentifiers to $cids");
    communityIdentifiers = cids;
    writeToCache();

    if (!communitiesContainsChosenCid) {
      // inconsistency found, reset state
      setChosenCid();
    }
  }

  @action
  void setCommunities(List<CidName> c) {
    _log("set communities to $c");
    communities = c;
    writeToCache();
  }

  @action
  void setChosenCid([CommunityIdentifier cid]) {
    if (chosenCid != cid) {
      chosenCid = cid;
      writeToCache();

      if (cid != null) {
        initCommunityStore(cid, _rootStore.account.currentAddress);
        initBazaarStore(cid);
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
    _log("set currentPhase to $phase");
    if (currentPhase != phase) {
      currentPhase = phase;
      writeToCache();
    }
    // update depending values without awaiting
    webApi.encointer.getCurrentCeremonyIndex();
  }

  @action
  void setCurrentCeremonyIndex(index) {
    print("store: set currentCeremonyIndex to $index");
    if (currentCeremonyIndex != index && currentPhase == CeremonyPhase.REGISTERING) {
      purgeCeremonySpecificState();
    }

    currentCeremonyIndex = index;
    writeToCache();

    // update depending values without awaiting
    updateState();
  }

  // -- other helpers

  @action
  void updateState() {
    switch (currentPhase) {
      case CeremonyPhase.REGISTERING:
        webApi.encointer.getMeetupTime();
        if (chosenCid != null) {
          webApi.encointer.getAggregatedAccountData(chosenCid, _rootStore.account.currentAddress);
        }
        webApi.encointer.getReputations();
        break;
      case CeremonyPhase.ASSIGNING:
        if (chosenCid != null) {
          webApi.encointer.getAggregatedAccountData(chosenCid, _rootStore.account.currentAddress);
        }
        break;
      case CeremonyPhase.ATTESTING:
        if (chosenCid != null) {
          webApi.encointer.getAggregatedAccountData(chosenCid, _rootStore.account.currentAddress);
        }
        break;
    }
  }

  @action
  void purgeCeremonySpecificState() {
    communityStores.forEach((cid, store) => store.purgeCeremonySpecificState());
    accountStores.forEach((cid, store) => store.purgeCeremonySpecificState());
  }

  /// Calculates the remaining time until the next meetup starts. As Gesell and Cantillon currently implement timewarp
  /// we cannot use the time received by the blockchain. Hence, we need to calculate it differently.
  int getTimeToMeetup() {
    var now = DateTime.now();
    if (10 <= now.minute && now.minute < 20) {
      return ((19 - now.minute) * 60 + 60 - now.second);
    } else if (40 <= now.minute && now.minute < 50) {
      return ((49 - now.minute) * 60 + 60 - now.second);
    } else {
      _log("Warning: Invalid time to meetup");
      return 0;
    }
  }

  /// Initialize the store and the sub-stores.
  ///
  /// Should always be called after creating a store to ensure full functionality.
  Future<void> initStore(AppStore root, Function cacheFn) {
    this._rootStore = root;
    this._cacheFn = cacheFn;

    // These are merely safety guards, and should never be needed. A null reference error occurred here only because
    // a store was added in the development process after it has been written to cache. Hence, deserialization
    // initialized it with null.
    if (accountStores == null) {
      accountStores = new ObservableMap();
    }

    if (bazaarStores == null) {
      bazaarStores = new ObservableMap();
    }

    if (communityStores == null) {
      communityStores = new ObservableMap();
    }

    accountStores.forEach((cid, store) => store.initStore(cacheFn));
    bazaarStores.forEach((cid, store) => store.initStore(cacheFn));
    communityStores.forEach((cid, store) => store.initStore(cacheFn, applyDemurrage));

    // Only needed when migrating from older app versions.
    return initEncointerAccountStore(_rootStore.account.currentAddress);
  }

  Future<void> writeToCache() {
    if (_cacheFn != null) {
      return _cacheFn();
    } else {
      return null;
    }
  }

  // -- init functions for sub-stores

  @action
  Future<void> initCommunityStore(CommunityIdentifier cid, String address) async {
    var cidFmt = cid.toFmtString();
    if (!communityStores.containsKey(cidFmt)) {
      _log("Adding new communityStore for cid: ${cid.toFmtString()}");

      var communityStore = CommunityStore(network, cid);
      communityStore.initStore(_cacheFn, applyDemurrage);
      await communityStore.initCommunityAccountStore(address);

      communityStores[cidFmt] = communityStore;
      return writeToCache();
    } else {
      _log("Don't add already existing communityAccountStore for cid: ${cid.toFmtString()}");
      return null;
    }
  }

  @action
  Future<void> initEncointerAccountStore(String address) {
    if (!accountStores.containsKey(address)) {
      _log("Adding new encointerAccountStore for: $address");

      var encointerAccountStore = EncointerAccountStore(network, address);
      encointerAccountStore.initStore(_cacheFn);

      accountStores[address] = encointerAccountStore;
      return writeToCache();
    } else {
      _log("Don't add already existing encointerAccountStore for address: $address");
      return null;
    }
  }

  @action
  Future<void> initBazaarStore(CommunityIdentifier cid) {
    var cidFmt = cid.toFmtString();
    if (!bazaarStores.containsKey(cidFmt)) {
      _log("Adding new bazaarStore for cid: ${cid.toFmtString()}");

      var bazaarStore = BazaarStore(network, cid);
      bazaarStore.initStore(_cacheFn);

      bazaarStores[cidFmt] = bazaarStore;
      return writeToCache();
    } else {
      _log("Don't add already existing bazaarStore for cid: ${cid.toFmtString()}");
      return null;
    }
  }

  // ----- Computed values for ceremony box

  bool get showRegisterButton {
    bool registered = communityAccount?.isRegistered ?? false;
    return (currentPhase == CeremonyPhase.REGISTERING && !registered);
  }

  @computed
  bool get showStartCeremonyButton {
    bool registered = communityAccount?.isRegistered ?? false;
    return (currentPhase == CeremonyPhase.ATTESTING && registered);
  }

  @computed
  bool get showTwoBoxes {
    return !showRegisterButton && !showStartCeremonyButton;
  }
}

_log(String msg) {
  print("[EncointerStore] $msg");
}
