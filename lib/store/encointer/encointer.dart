import 'dart:collection';
import 'dart:convert';
import 'dart:math';

import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/service/substrateApi/api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/store/assets/types/transferData.dart';
import 'package:encointer_wallet/store/encointer/types/bazaar.dart';
import 'package:encointer_wallet/store/encointer/types/ceremonies.dart';
import 'package:encointer_wallet/store/encointer/types/claimOfAttendance.dart';
import 'package:encointer_wallet/store/encointer/types/communities.dart';
import 'package:encointer_wallet/store/encointer/types/encointerBalanceData.dart';
import 'package:encointer_wallet/store/encointer/types/location.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:mobx/mobx.dart';

part 'encointer.g.dart';

class EncointerStore extends _EncointerStore with _$EncointerStore {
  EncointerStore(AppStore store) : super(store);
}

abstract class _EncointerStore with Store {
  _EncointerStore(this.rootStore);

  final AppStore rootStore;
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

  // Note: In synchronous code, every modification of an @observable is tracked by mobx and
  // fires a reaction. However, modifications in asynchronous code must be wrapped in
  // a `@action` block to fire a reaction.
  //
  // Note2: In case of Map/List: If the variable is declared as plain Map/List with `@observable` annotated, mobx
  // tracks variable assignment but not if individual items are changed. If this is wanted, the variable must be
  // declared as `ObservableList/-Map`.

  @observable
  CeremonyPhase currentPhase;

  @observable
  Map<CeremonyPhase, int> phaseDurations = new Map();

  @computed
  get currentPhaseDuration => phaseDurations[currentPhase];

  @observable
  int currentCeremonyIndex;

  @observable
  int meetupIndex;

  @observable
  Location meetupLocation;

  @observable
  int meetupTime;

  @observable
  List<String> meetupRegistry;

  @observable
  int participantIndex;

  @observable
  ObservableMap<CommunityIdentifier, BalanceEntry> balanceEntries = new ObservableMap();

  @observable
  List<CommunityIdentifier> communityIdentifiers;

  @observable
  List<String> bootstrappers;

  @observable
  List<CidName> communities;

  @observable
  CommunityIdentifier chosenCid;

  @observable
  CommunityMetadata communityMetadata;

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
  SplayTreeMap<int, CommunityReputation> reputations;

  @observable
  get ceremonyIndexForProofOfAttendance {
    if (reputations != null) {
      return reputations.entries.firstWhere((e) => e.value.reputation == Reputation.VerifiedUnlinked).key;
    }
  }

  @observable
  ObservableList<AccountBusinessTuple> businessRegistry;

  @observable
  ObservableList<Location> communityLocations = new ObservableList();

  @computed
  String get communityName => communityMetadata?.name;

  @computed
  String get communitySymbol => communityMetadata?.symbol;

  @computed
  String get communityIconsCid => communityMetadata?.assets;

  @computed
  BalanceEntry get communityBalanceEntry {
    return balanceEntries[chosenCid];
  }

  @computed
  double get communityBalance {
    return applyDemurrage(communityBalanceEntry);
  }

  @computed
  bool get isAssigned => meetupIndex != null && meetupIndex > 0;

  /// Checks if the chosenCid is contained in the communities.
  ///
  /// This is only relevant for edge-cases, where the chain does no longer contain a community. E.g. a dev-chain was
  /// purged or a community as been marked as inactive and was removed.
  @computed
  get communitiesContainsChosenCid {
    return chosenCid != null && communities.isNotEmpty && communities.where((cn) => cn.cid == chosenCid).isNotEmpty;
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
      // jsonEncode fails if we don't call toString for an enum
      cacheObject(encointerCurrentPhaseKey, phase.toString());
      currentPhase = phase;
    }
    // update depending values without awaiting
    webApi.encointer.getCurrentCeremonyIndex();
  }

  @action
  void setCurrentCeremonyIndex(index) {
    print("store: set currentCeremonyIndex to $index");
    if (currentCeremonyIndex != index && currentPhase == CeremonyPhase.Registering) {
      resetState();
    }

    currentCeremonyIndex = index;
    cacheObject(encointerCurrentCeremonyIndexKey, index);
    // update depending values without awaiting
    updateState();
  }

  @action
  void updateState() {
    switch (currentPhase) {
      case CeremonyPhase.Registering:
        webApi.encointer.getMeetupTime();
        break;
      case CeremonyPhase.Assigning:
        webApi.encointer.getMeetupIndex();
        break;
      case CeremonyPhase.Attesting:
        webApi.encointer.getMeetupIndex();
        break;
    }
    webApi.encointer.getParticipantIndex();
  }

  @action
  resetState() {
    purgeParticipantsClaims();
    setParticipantIndex();
    setMeetupIndex();
    setMeetupLocation();
    setMeetupTime();
    setMeetupRegistry();
  }

  @action
  void setMeetupIndex([int index]) {
    print("store: set meetupIndex to $index");
    if (meetupIndex != index) {
      cacheObject(encointerMeetupIndexKey, index);
      meetupIndex = index;
    }

    if (index != null) {
      // update depending values
      webApi.encointer.getMeetupLocation().then((_) => webApi.encointer.getMeetupTime());
      webApi.encointer.getMeetupRegistry();
    }
  }

  @action
  void setMeetupLocation([Location location]) {
    print("store: set meetupLocation to $location");
    if (meetupLocation != location) {
      cacheObject(encointerMeetupLocationKey, location);
      meetupLocation = location;
    }

    if (location != null) {
      // update depending values
      webApi.encointer.getMeetupTime();
    }
  }

  @action
  void setMeetupTime([int time]) {
    print("store: set meetupTime to $time");
    if (meetupTime != time) {
      cacheObject(encointerMeetupTimeKey, time);
      meetupTime = time;
    }
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
  void setMeetupRegistry([List<String> reg]) {
    print("store: set meetupRegistry to $reg");
    cacheObject(encointerMeetupRegistryKey, reg);
    meetupRegistry = reg;
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
    cacheObject(encointerBootstrappersKey, bs);
  }

  @action
  void setCommunityMetadata([CommunityMetadata meta]) {
    print("store: set communityMetadata to $meta");
    communityMetadata = meta;
    cacheObject(encointerCommunityMetadataKey, meta);
  }

  @action
  void setCommunities(List<CidName> c) {
    print("store: set communities to $c");
    communities = c;
    cacheObject(encointerCommunitiesKey, c);
  }

  @action
  void setCommunityLocations([List<Location> locations]) {
    print("store: set communityLocations to ${locations.toString()}");
    communityLocations = ObservableList.of(locations);
    cacheObject(encointerCommunityLocationsKey, locations);

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
      cacheObject(encointerCommunityKey, cid);
      setCommunityMetadata();
      resetState();

      // update depending values without awaiting
      if (!rootStore.settings.loading) {
        webApi.encointer.getCommunityData();
      }
    }

    if (rootStore.settings.endpointIsGesell) {
      webApi.encointer.subscribeBusinessRegistry();
    }
  }

  @action
  void purgeParticipantsClaims() {
    participantsClaims.clear();
    cacheParticipantsClaims(participantsClaims);
  }

  bool containsClaim(ClaimOfAttendance claim) {
    return participantsClaims[claim.claimantPublic] != null;
  }

  @action
  void addParticipantClaim(ClaimOfAttendance claim) {
    participantsClaims[claim.claimantPublic] = claim;
    cacheParticipantsClaims(participantsClaims);
  }

  @action
  void setReputations(Map<int, CommunityReputation> reps) {
    reputations = SplayTreeMap.of(reps);
    cacheMap<int, CommunityReputation>(encointerCommunityReputationsKey, reps);
  }

  @action
  void addBalanceEntry(CommunityIdentifier cid, BalanceEntry balanceEntry) {
    print("balanceEntry $balanceEntry added to cid $cid added");
    balanceEntries[cid] = balanceEntry;
  }

  @action
  void setParticipantIndex([int pIndex]) {
    participantIndex = pIndex;
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
  Future<void> loadCache() async {
    var cachedCid = await loadObject(encointerCommunityKey);
    if (cachedCid != null) {
      chosenCid = CommunityIdentifier.fromJson(cachedCid);
      print("found cached choice of cid. will recover it: " + chosenCid.toFmtString());
    }
    var cachedCommunityMetadata = await loadObject(encointerCommunityMetadataKey);
    if (cachedCommunityMetadata != null) {
      communityMetadata = CommunityMetadata.fromJson(cachedCommunityMetadata);
      print("found cached community metadata. will recover it: " + cachedCommunityMetadata.toString());
    }
    List<dynamic> cachedCommunitiesInternalList = await loadObject(encointerCommunitiesKey);
    if (cachedCommunitiesInternalList != null) {
      List<CidName> cachedCommunities = cachedCommunitiesInternalList.map((s) => CidName.fromJson(s)).toList();
      print("found cached communities. will recover it: " + cachedCommunities.toString());
      communities = cachedCommunities;
    }

    List<dynamic> _cachedBootstrapperList = await loadObject(encointerBootstrappersKey);
    if (_cachedBootstrapperList != null) {
      bootstrappers = List<String>.from(_cachedBootstrapperList);
      print("found cached bootstrappers. will recover it: $bootstrappers");
    }

    List<dynamic> cachedLocations = await loadObject(encointerCommunityLocationsKey);
    if (cachedLocations != null) {
      List<Location> locations = cachedLocations.map((s) => Location.fromJson(s)).toList();
      print("found cached locations. will recover it: " + locations.toString());
      communityLocations = ObservableList.of(locations);
    }

    var cachedReputations = await loadMap(encointerCommunityReputationsKey);
    if (cachedReputations != null) {
      // for some weird reason `cachedReputation.cast<int, CommunityReputation> did not throw an exception, but it did not
      // cast successfully.
      Map<int, CommunityReputation> r =
          Map.of(cachedReputations.map((k, v) => MapEntry(int.parse(k), CommunityReputation.fromJson(v))));
      print("found cached reputations. will recover it: " + cachedReputations.toString());
      reputations = SplayTreeMap.of(r);
    }

    // get meetup related data
    var data = await loadMap(encointerParticipantsClaimsKey);
    if (data != null) {
      print("found cached participants' claims. will recover them: $data");
      participantsClaims = ObservableMap.of(data.cast<String, ClaimOfAttendance>());
    }
    currentPhase = await loadCurrentPhase();
    currentCeremonyIndex = await loadObject(encointerCurrentCeremonyIndexKey);
    meetupIndex = await loadObject(encointerMeetupIndexKey);

    var loc = await loadObject(encointerMeetupLocationKey);
    if (loc != null) {
      meetupLocation = Location.fromJson(loc);
    }

    var reg = await loadObject(encointerMeetupRegistryKey);
    if (reg != null) {
      meetupRegistry = List<String>.from(reg);
    }

    meetupTime = await loadObject(encointerMeetupTimeKey);
  }

  @action
  void setbusinessRegistry(List<AccountBusinessTuple> accBusinesses) {
    businessRegistry = ObservableList.of(accBusinesses);
  }

  Future<void> reloadbusinessRegistry() async {
    await webApi.encointer.getBusinesses();
  }

  Future<void> cacheParticipantsClaims(Map<String, ClaimOfAttendance> claims) {
    return cacheMap<String, ClaimOfAttendance>(encointerParticipantsClaimsKey, claims);
  }

  /// Cache a map in the local storage.
  ///
  /// We use this because `jsonEncode` fails for maps with key types other than String
  ///
  Future<void> cacheMap<Key, Value>(String cacheKey, Map<Key, Value> map) {
    var encoded = jsonEncode(Map.of(map.map((k, v) => MapEntry(k.toString(), v))));
    print("[store.encointer]: caching map. cacheKey: $cacheKey, map: $encoded");
    return cacheObject(cacheKey, encoded);
  }

  /// Load a map in the local storage.
  ///
  Future<Map<dynamic, dynamic>> loadMap<Key, Value>(String cacheKey) async {
    print("[store.encointer]: loading map. cacheKey: $cacheKey");

    var data = await loadObject(cacheKey);

    if (data != null) {
      print("found cache: $cacheKey': data: $data");
      return jsonDecode(data);
    }
    return null;
  }

  Future<void> cacheObject(String key, value) {
    return rootStore.cacheObject(key, value);
  }

  Future<Object> loadObject(String key) {
    return rootStore.loadObject(key);
  }

  Future<CeremonyPhase> loadCurrentPhase() async {
    Object obj = await rootStore.loadObject(encointerCurrentPhaseKey);
    return ceremonyPhaseFromString(obj);
  }

  @computed
  bool get isRegistered {
    return participantIndex != null && participantIndex != 0;
  }

  @computed
  bool get showRegisterButton {
    return (currentPhase == CeremonyPhase.Registering && !isRegistered);
  }

  @computed
  bool get showStartCeremonyButton {
    return (currentPhase == CeremonyPhase.Attesting && isRegistered);
  }

  @computed
  bool get showTwoBoxes {
    return !showRegisterButton && !showStartCeremonyButton;
  }

  @computed
  int get numberOfParticipantsAtUpcomingCeremony {
    return meetupRegistry.length;
  }
}
