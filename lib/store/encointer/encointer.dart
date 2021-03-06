import 'dart:convert';
import 'dart:math';

import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/service/substrateApi/api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/store/assets/types/transferData.dart';
import 'package:encointer_wallet/store/encointer/types/claimOfAttendance.dart';
import 'package:encointer_wallet/store/encointer/types/encointerBalanceData.dart';
import 'package:encointer_wallet/store/encointer/types/encointerTypes.dart';
import 'package:encointer_wallet/store/encointer/types/location.dart';
import 'package:encointer_wallet/store/encointer/types/communities.dart';
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
  int myMeetupRegistryIndex;

  @observable
  int participantIndex;

  @observable
  int participantCount;

  @observable
  Map<String, BalanceEntry> balanceEntries = new ObservableMap();

  @observable
  List<String> communityIdentifiers;

  @observable
  List<CidName> communities;

  @observable
  String chosenCid;

  @observable
  CommunityMetadata communityMetadata;

  @observable
  double demurrage;

  @observable
  ObservableMap<String, ClaimOfAttendance> participantsClaims = new ObservableMap();

  @computed
  get scannedClaimsCount => participantsClaims.length;

  @observable
  ObservableList<TransferData> txsTransfer = ObservableList<TransferData>();

  @observable
  ObservableList<String> shopRegistry;

  @computed
  String get communityName => communityMetadata?.name;

  @computed
  String get communitySymbol => communityMetadata?.symbol;

  @computed
  String get communityIconsCid => communityMetadata?.icons;

  @computed
  BalanceEntry get communityBalanceEntry {
    return balanceEntries[chosenCid];
  }

  @computed
  double get communityBalance {
    double res;
    if (rootStore.chain.latestHeaderNumber != null &&
        communityBalanceEntry != null &&
        demurrage != null
    ) {
      int elapsed = rootStore.chain.latestHeaderNumber - communityBalanceEntry.lastUpdate;
      double exponent = -demurrage * elapsed;
      res = communityBalanceEntry.principal * pow(e, exponent);
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
    if (currentCeremonyIndex != index && currentPhase == CeremonyPhase.REGISTERING) {
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
      case CeremonyPhase.REGISTERING:
        break;
      case CeremonyPhase.ASSIGNING:
        webApi.encointer.getMeetupIndex();
        break;
      case CeremonyPhase.ATTESTING:
        webApi.encointer.getMeetupIndex();
        break;
    }
    webApi.encointer.getParticipantIndex();
  }

  @action
  resetState() {
    purgeParticipantsClaims();
    setMeetupIndex();
    setMeetupLocation();
    setMeetupTime();
    setMeetupRegistry();
    setMyMeetupRegistryIndex();
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
      webApi.encointer.getMeetupLocation();
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
  void setMyMeetupRegistryIndex([int index]) {
    myMeetupRegistryIndex = index;
  }

  @action
  void setCommunityIdentifiers(List<String> cids) {
    communityIdentifiers = cids;
  }

  @action
  void setCommunityMetadata(CommunityMetadata meta) {
    communityMetadata = meta;
    cacheObject(encointerCommunityMetadataKey, meta);
  }

  @action
  void setCommunities(List<CidName> c) {
    communities = c;
  }

  @action
  void setDemurrage(double d) {
    demurrage = d;
  }

  @action
  void setChosenCid(String cid) {
    if (chosenCid != cid) {
      chosenCid = cid;
      cacheObject(encointerCommunityKey, cid);
    }

    if (rootStore.settings.endpointIsGesell) {
      webApi.encointer.subscribeShopRegistry();
    }
    // update depending values without awaiting
    if (!rootStore.settings.loading) {
      webApi.encointer.getMeetupIndex();
      webApi.encointer.getParticipantIndex();
      webApi.encointer.getParticipantCount();
      webApi.encointer.getEncointerBalance();
      webApi.encointer.getCommunityMetadata();
      webApi.encointer.getDemurrage();
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
  void addBalanceEntry(String cid, BalanceEntry balanceEntry) {
    balanceEntries[cid] = balanceEntry;
  }

  @action
  void setParticipantIndex(int pIndex) {
    participantIndex = pIndex;
  }

  @action
  void setParticipantCount(int pCount) {
    participantCount = pCount;
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
        "token": isCommunityCurrency ? i['params'][1] : rootStore.settings.networkState.tokenSymbol,
        "amount": isCommunityCurrency ? Fmt.doubleFormat(i['params'][2]) : Fmt.balance(i['params'][1], ert_decimals),
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
    var data = await loadObject(encointerCommunityKey);
    if (data != null) {
      print("found cached choice of cid. will recover it: " + data.toString());
      setChosenCid(data);
    }
    // get meetup related data
    data = await loadObject(encointerParticipantsClaimsKey);
    if (data != null) {
      print("found cached participants' claims. will recover them: $data");
      participantsClaims = ObservableMap.of(jsonDecode(data).cast<String, ClaimOfAttendance>());
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
  void setShopRegistry(List<String> shops) {
    shopRegistry = ObservableList.of(shops);
  }

  Future<void> reloadShopRegistry() async {
    await webApi.encointer.getShopRegistry();
  }

  Future<void> cacheParticipantsClaims(Map<String, ClaimOfAttendance> claims) {
    print("jsonEncode claims: ${jsonEncode(claims)}");
    return cacheObject(encointerParticipantsClaimsKey, jsonEncode(claims));
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
}
