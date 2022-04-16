import 'dart:collection';
import 'dart:math';

import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/store/assets/types/transferData.dart';
import 'package:encointer_wallet/store/encointer/types/bazaar.dart';
import 'package:encointer_wallet/store/encointer/types/claimOfAttendance.dart';
import 'package:encointer_wallet/store/encointer/types/communities.dart';
import 'package:encointer_wallet/store/encointer/types/encointerBalanceData.dart';
import 'package:encointer_wallet/store/encointer/types/location.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';

import '../../models/index.dart';
import 'sub_stores/communityStore/communityStore.dart';

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

  /// balanceEntries for respective community: cid.toFmtString() -> BalanceEntry
  @observable
  ObservableMap<String, BalanceEntry> balanceEntries = new ObservableMap();

  @observable
  List<CommunityIdentifier> communityIdentifiers;

  @observable
  List<CidName> communities;

  @observable
  CommunityIdentifier chosenCid;

  @observable
  double demurrage;

  // claimantPublic -> ClaimOfAttendance
  @observable
  ObservableMap<String, ClaimOfAttendance> participantsClaims = new ObservableMap();

  @computed
  get scannedClaimsCount => participantsClaims.length;

  @observable
  ObservableList<TransferData> txsTransfer = ObservableList<TransferData>();

  // splay tree set does automatically order the keys.
  @observable
  Map<int, CommunityReputation> reputations;

  @computed
  get ceremonyIndexForProofOfAttendance {
    if (reputations != null && reputations.isNotEmpty) {
      try {
        return reputations.entries.firstWhere((e) => e.value.reputation == Reputation.VerifiedUnlinked).key;
      } catch (_e) {
        print("Has reputation, but none that has not been linked yet");
        return 0;
      }
    }
  }

  @observable
  ObservableList<AccountBusinessTuple> businessRegistry;

  @observable
  ObservableList<Location> communityLocations = new ObservableList();

  @computed
  BalanceEntry get communityBalanceEntry {
    return chosenCid != null ? balanceEntries[chosenCid.toFmtString()] : null;
  }

  @computed
  double get communityBalance {
    return applyDemurrage(communityBalanceEntry);
  }

  /// Checks if the chosenCid is contained in the communities.
  ///
  /// This is only relevant for edge-cases, where the chain does no longer contain a community. E.g. a dev-chain was
  /// purged or a community as been marked as inactive and was removed.
  @computed
  get communitiesContainsChosenCid {
    return chosenCid != null && communities.isNotEmpty && communities.where((cn) => cn.cid == chosenCid).isNotEmpty;
  }

  @observable
  ObservableMap<String, CommunityStore> communityStores = new ObservableMap();

  @computed
  get community {
    return chosenCid != null ? communityStores[chosenCid.toFmtString()] : null;
  }

  @computed
  get communityAccount {
    return community != null ? community.communityAccountStores[rootStore.account.currentAddress] : null;
  }

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

  double applyDemurrage(BalanceEntry entry) {
    double res;
    if (rootStore.chain.latestHeaderNumber != null && entry != null && demurrage != null) {
      int elapsed = rootStore.chain.latestHeaderNumber - entry.lastUpdate;
      double exponent = -demurrage * elapsed;
      res = entry.principal * pow(e, exponent);
    }
    return res;
  }

  @action
  void setCurrentPhase(CeremonyPhase phase) {
    print("store: set currentPhase to $phase");
    if (currentPhase != phase) {
      currentPhase = phase;
    }
    // update depending values without awaiting
    webApi.encointer.getCurrentCeremonyIndex();
  }

  @action
  void setCurrentCeremonyIndex(index) {
    print("store: set currentCeremonyIndex to $index");
    if (currentCeremonyIndex != index && currentPhase == CeremonyPhase.REGISTERING) {
      resetState();
    }

    currentCeremonyIndex = index;
    // update depending values without awaiting
    updateState();
  }

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
  resetState() {
    purgeParticipantsClaims();
    purgeReputations();
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
  void setBootstrappers(List<String> bs) {
    print("store: set communityIdentifiers to $bs");
    bootstrappers = bs;
  }

  @action
  void setCommunities(List<CidName> c) {
    print("store: set communities to $c");
    communities = c;
  }

  @action
  void setCommunityLocations([List<Location> locations]) {
    print("store: set communityLocations to ${locations.toString()}");
    communityLocations = ObservableList.of(locations);

    // There is no race-condition with the `getMeetupTime` call in `setMeetupLocation` because `getMeetupTime` uses
    // internally the `meetupLocation`. Hence, the worst case scenario is a redundant rpc call.
    webApi.encointer.getMeetupTime();
  }

  @action
  void setDemurrage(double d) {
    demurrage = d;
  }

  @action
  void setChosenCid([CommunityIdentifier cid]) {
    if (chosenCid != cid) {
      chosenCid = cid;
      resetState();

      if (cid != null) {
        initCommunityStore(cid, rootStore.account.currentAddress);
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
  void purgeParticipantsClaims() {
    participantsClaims.clear();
  }

  bool containsClaim(ClaimOfAttendance claim) {
    return participantsClaims[claim.claimantPublic] != null;
  }

  @action
  void addParticipantClaim(ClaimOfAttendance claim) {
    participantsClaims[claim.claimantPublic] = claim;
  }

  @action
  void setReputations(Map<int, CommunityReputation> reps) {
    reputations = SplayTreeMap.of(reps);
  }

  @action
  void purgeReputations() {
    if (reputations != null) {
      reputations.clear();
    }
  }

  @action
  void addBalanceEntry(CommunityIdentifier cid, BalanceEntry balanceEntry) {
    print("balanceEntry $balanceEntry added to cid $cid added");
    balanceEntries[cid.toFmtString()] = balanceEntry;
  }

  @action
  Future<void> setTransferTxs(List list, {bool reset = false, needCache = true}) async {
    List transfers = list.map((i) {
      bool isCommunityCurrency = i['params'].length == 3;
      return {
        "block_timestamp": i['time'],
        "hash": i['hash'],
        "success": true,
        "from": rootStore.account.currentAddress,
        "to": i['params'][0],
        "token": isCommunityCurrency
            ? CommunityIdentifier.fromJson(i['params'][1]).toFmtString()
            : rootStore.settings.networkState.tokenSymbol,
        "amount": isCommunityCurrency ? Fmt.numberFormat(i['params'][2]) : Fmt.balance(i['params'][1], ert_decimals),
      };
    }).toList();
    if (reset) {
      txsTransfer = ObservableList.of(transfers.map((i) => TransferData.fromJson(Map<String, dynamic>.from(i))));
    } else {
      txsTransfer.addAll(transfers.map((i) => TransferData.fromJson(Map<String, dynamic>.from(i))));
    }

    if (needCache && txsTransfer.length > 0) {
      _cacheTxs(transfers, cacheTxsTransferKey);
    }
  }

  @action
  Future<void> _cacheTxs(List list, String cacheKey) async {
    String pubKey = rootStore.account.currentAccount.pubKey;
    List cached = await rootStore.localStorage.getAccountCache(pubKey, cacheKey);
    if (cached != null) {
      cached.addAll(list);
    } else {
      cached = list;
    }
    rootStore.localStorage.setAccountCache(pubKey, cacheKey, cached);
  }

  @action
  void setbusinessRegistry(List<AccountBusinessTuple> accBusinesses) {
    businessRegistry = ObservableList.of(accBusinesses);
  }

  void setCacheFn(Function cacheFn) {
    this.cacheFn = cacheFn;

    communityStores.updateAll((_, store) {
      store.setCacheFn(cacheFn);
      return store;
    });
  }

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
