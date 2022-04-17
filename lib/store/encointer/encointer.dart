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
import 'sub_stores/encointer_account_store/encointerAccountStore.dart';

part 'encointer.g.dart';

final String cacheTxsTransferKey = 'transfer_txs';
final String encointerCommunityKey = 'wallet_encointer_community';
final String encointerCommunityMetadataKey = 'wallet_encointer_community_metadata';
final String encointerCommunitiesKey = 'wallet_encointer_communities';
final String encointerBootstrappersKey = 'wallet_encointer_bootstrappers';
final String encointerCommunityLocationsKey = 'wallet_encointer_community_locations';
final String encointerCommunityReputationsKey = 'wallet_encointer_community_reputations';

// offline meetup cache.
final String encointerCurrentCeremonyIndexKey = 'wallet_encointer_current_ceremony_index';
final String encointerCurrentPhaseKey = 'wallet_encointer_current_phase';
final String encointerMeetupIndexKey = 'wallet_encointer_meetup_index';
final String encointerMeetupLocationKey = 'wallet_encointer_meetup_location';
final String encointerMeetupRegistryKey = 'wallet_encointer_meetup_registry';
final String encointerParticipantsClaimsKey = 'wallet_encointer_participants_claims';
final String encointerMeetupTimeKey = 'wallet_encointer_meetup_time';

/// Mobx-Store containing all encointer specific data.
///
/// Data specific to a community and/or account are kept in sub-stores.
@JsonSerializable(explicitToJson: true)
class EncointerStore extends _EncointerStore with _$EncointerStore {
  EncointerStore(String network, {AppStore store}) : super(network, rootStore: store);

  factory EncointerStore.fromJson(Map<String, dynamic> json) => _$EncointerStoreFromJson(json);
  Map<String, dynamic> toJson() => _$EncointerStoreToJson(this);
}

abstract class _EncointerStore with Store {
  _EncointerStore(this.network, {this.rootStore});

  @JsonKey(ignore: true)
  AppStore rootStore;

  // Note: In synchronous code, every modification of an @observable is tracked by mobx and
  // fires a reaction. However, modifications in asynchronous code must be wrapped in
  // a `@action` block to fire a reaction.
  //
  // Note2: In case of Map/List: If the variable is declared as plain Map/List with `@observable` annotated, mobx
  // tracks variable assignment but not if individual items are changed. If this is wanted, the variable must be
  // declared as `ObservableList/-Map`.

  @JsonKey(ignore: true)
  Future<void> Function() cacheFn;

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
  get bazaar {
    return chosenCid != null ? bazaarStores[chosenCid.toFmtString()] : null;
  }

  /// The `CommunityStore` for the currently chosen community.
  @computed
  get community {
    return chosenCid != null ? communityStores[chosenCid.toFmtString()] : null;
  }

  /// The `CommunityAccountStore` for the currently chosen community and account.
  @computed
  get communityAccount {
    return community != null ? community.communityAccountStores[rootStore.account.currentAddress] : null;
  }

  /// The `EncointerAccountStore` for the currently chosen account.
  @computed
  get account {
    return accountStores[rootStore.account.currentAddress];
  }

  // -- computed values derived from sub-stores

  @computed
  BalanceEntry get communityBalanceEntry {
    return chosenCid != null ? account.balanceEntries[chosenCid.toFmtString()] : null;
  }

  @computed
  double get communityBalance {
    return applyDemurrage(communityBalanceEntry);
  }

  double applyDemurrage(BalanceEntry entry) {
    double res;
    if (rootStore.chain.latestHeaderNumber != null && entry != null && community.demurrage != null) {
      int elapsed = rootStore.chain.latestHeaderNumber - entry.lastUpdate;
      double exponent = -community.demurrage * elapsed;
      res = entry.principal * pow(e, exponent);
    }
    return res;
  }

  // -- Setters for this store

  @action
  void setCommunityIdentifiers(List<CommunityIdentifier> cids) {
    print("store: set communityIdentifiers to $cids");
    communityIdentifiers = cids;

    if (!communitiesContainsChosenCid) {
      // inconsistency found, reset state
      setChosenCid();
    }
  }

  @action
  void setCommunities(List<CidName> c) {
    print("store: set communities to $c");
    communities = c;
  }

  @action
  void setChosenCid([CommunityIdentifier cid]) {
    if (chosenCid != cid) {
      chosenCid = cid;

      if (cid != null) {
        initCommunityStore(cid, rootStore.account.currentAddress);
        initBazaarStore(cid);
      }
    }

    if (rootStore.settings.endpointIsNoTee) {
      webApi.encointer.subscribeBusinessRegistry();
    }

    // update depending values without awaiting
    if (!rootStore.settings.loading) {
      webApi.encointer.getCommunityData();
    }
  }

  @action
  void setCurrentPhase(CeremonyPhase phase) {
    print("store: set currentPhase to $phase");
    if (currentPhase != phase) {
      currentPhase = phase;
      cacheFn();
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
          webApi.encointer.getAggregatedAccountData(chosenCid, rootStore.account.currentAddress);
        }
        webApi.encointer.getReputations();
        break;
      case CeremonyPhase.ASSIGNING:
        if (chosenCid != null) {
          webApi.encointer.getAggregatedAccountData(chosenCid, rootStore.account.currentAddress);
        }
        break;
      case CeremonyPhase.ATTESTING:
        if (chosenCid != null) {
          webApi.encointer.getAggregatedAccountData(chosenCid, rootStore.account.currentAddress);
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
      print("Warning: Invalid time to meetup");
      return 0;
    }
  }

  void setCacheFn(Function cacheFn) {
    this.cacheFn = cacheFn;

    communityStores.updateAll((_, store) {
      store.setCacheFn(cacheFn);
      return store;
    });
  }

  // -- init functions for sub-stores

  @action
  void initCommunityStore(CommunityIdentifier cid, String address) {
    var cidFmt = cid.toFmtString();
    if (!communityStores.containsKey(cidFmt)) {
      _log("Adding new communityStore for cid: ${cid.toFmtString()}");

      var communityStore = CommunityStore(network, cid);
      communityStore.cacheFn = cacheFn;
      communityStore.initCommunityAccountStore(address);

      communityStores[cidFmt] = communityStore;
    } else {
      _log("Don't add already existing communityAccountStore for cid: ${cid.toFmtString()}");
    }
  }

  @action
  void initEncointerAccountStore(String address) {
    if (!accountStores.containsKey(address)) {
      _log("Adding new encointerAccountStore for address: $address");

      var encointerAccountStore = EncointerAccountStore(network, address);
      encointerAccountStore.cacheFn = cacheFn;

      accountStores[address] = encointerAccountStore;
    } else {
      _log("Don't add already existing encointerAccountStore for address: $address");
    }
  }

  @action
  void initBazaarStore(CommunityIdentifier cid) {
    var cidFmt = cid.toFmtString();
    if (!bazaarStores.containsKey(cidFmt)) {
      _log("Adding new bazaarStore for cid: ${cid.toFmtString()}");

      var bazaarStore = BazaarStore(network, cid);
      bazaarStore.cacheFn = cacheFn;

      bazaarStores[cidFmt] = bazaarStore;
    } else {
      _log("Don't add already existing bazaarStore for cid: ${cid.toFmtString()}");
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
  print("[EncointerStore $msg");
}
