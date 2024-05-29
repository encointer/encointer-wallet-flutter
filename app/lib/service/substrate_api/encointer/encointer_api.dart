import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:convert/convert.dart' show hex;

import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/mocks/mock_bazaar_data.dart';
import 'package:encointer_wallet/models/bazaar/account_business_tuple.dart';
import 'package:encointer_wallet/models/bazaar/business_identifier.dart';
import 'package:encointer_wallet/models/bazaar/offering_data.dart';
import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/models/communities/community_metadata.dart';
import 'package:encointer_wallet/models/encointer_balance_data/balance_entry.dart';
import 'package:encointer_wallet/models/index.dart';
import 'package:encointer_wallet/models/bazaar/businesses.dart';
import 'package:encointer_wallet/models/bazaar/ipfs_product.dart';
import 'package:encointer_wallet/models/bazaar/item_offered.dart';
import 'package:encointer_wallet/models/faucet/faucet.dart';
import 'package:encointer_wallet/service/encointer_feed/feed.dart' as feed;
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/substrate_api/core/dart_api.dart';
import 'package:encointer_wallet/service/substrate_api/encointer/encointer_dart_api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:ew_encointer_utils/ew_encointer_utils.dart' as ew_utils;
import 'package:ew_http/ew_http.dart';
import 'package:ew_keyring/ew_keyring.dart';
import 'package:ew_polkadart/encointer_types.dart' show ProofOfAttendance;
import 'package:ew_polkadart/ew_polkadart.dart'
    show
        BlockHash,
        ByteInput,
        EncointerKusama,
        Tally,
        Proposal,
        RuntimeVersion,
        SequenceCodec,
        StorageChangeSet,
        Tuple2,
        U128Codec;
import 'package:ew_polkadart/generated/encointer_kusama/types/sp_core/crypto/account_id32.dart';
import 'package:ew_primitives/ew_primitives.dart';
import 'package:ew_substrate_fixed/substrate_fixed.dart';

// disambiguate global imports of encointer types. We can remove this
// once we got rid of our manual type definitions.
import 'package:ew_polkadart/encointer_types.dart' as et;
import 'package:flutter/cupertino.dart';

/// Api to interface with the `js_encointer_service.js`
///
/// Note: If a call fails on the js side, the corresponding message completer will not be
/// freed. This means that the same call cannot be launched a second time as from the dart
/// side if allow multiple==false in evalJavascript, which is the default.
///
/// NOTE: In this case a `hot_restart` instead of `hot_reload` is needed in order to clear that cache.
///
/// NOTE: If the js-code was changed a rebuild of the application is needed to update the code.

class EncointerApi {
  EncointerApi(this.store, SubstrateDartApi dartApi, this.ewHttp, this.encointerKusama)
      : _dartApi = EncointerDartApi(dartApi);

  final EncointerDartApi _dartApi;
  final EwHttp ewHttp;
  final EncointerKusama encointerKusama;

  final AppStore store;

  StreamSubscription<StorageChangeSet>? _currentPhaseSubscription;
  StreamSubscription<StorageChangeSet>? _cidSubscription;

  /// Placeholder, we don't subscribe to the business registry yet.
  StreamSubscription<StorageChangeSet>? _businessRegistry;

  Future<void> startSubscriptions() async {
    Log.d('api: starting encointer subscriptions', 'EncointerApi');

    final futures = [
      getPhaseDurations(),
      subscribeCurrentPhase(),
      subscribeCommunityIdentifiers(),
    ];

    if (store.settings.endpointIsNoTee) {
      futures.add(subscribeBusinessRegistry());
    }
    await Future.wait(futures);
  }

  Future<void> stopSubscriptions() async {
    Log.d('api: stopping encointer subscriptions', 'EncointerApi');

    await _currentPhaseSubscription?.cancel();
    await _cidSubscription?.cancel();
    await _businessRegistry?.cancel();
  }

  void getCommunityData() {
    getBusinesses();
    getCommunityMetadata();
    getAllMeetupLocations();
    getDemurrage();
    getBootstrappers();
    getReputations();
    getMeetupTimeOverride();
    store.encointer.communityAccount?.getNumberOfNewbieTicketsForBootstrapper();
    store.encointer.account?.getNumberOfNewbieTicketsForReputable();
  }

  /// Queries the Scheduler pallet: encointerScheduler.currentPhase().
  Future<CeremonyPhase?> getCurrentPhase({BlockHash? at}) async {
    Log.d('api: getCurrentPhase', 'EncointerApi');
    final phase = await encointerKusama.query.encointerScheduler
        .currentPhase(at: at ?? store.chain.latestHash)
        .then(ceremonyPhaseTypeFromPolkadart);

    Log.d('api: Phase enum: $phase', 'EncointerApi');
    store.encointer.setCurrentPhase(phase);
    return phase;
  }

  /// Queries the Scheduler pallet: encointerScheduler.nextPhaseTimestamp().
  Future<int> getNextPhaseTimestamp({BlockHash? at}) async {
    Log.d('api: getNextPhaseTimestamp', 'EncointerApi');
    final timestampBigInt =
        await encointerKusama.query.encointerScheduler.nextPhaseTimestamp(at: at ?? store.chain.latestHash);
    final timestamp = timestampBigInt.toInt();

    Log.d('api: next phase timestamp: $timestamp', 'EncointerApi');
    store.encointer.setNextPhaseTimestamp(timestamp);
    return timestamp;
  }

  /// Queries the Scheduler pallet: encointerScheduler.currentPhase().
  ///
  /// This should be done only once at app-startup, as this is practically const.
  Future<void> getPhaseDurations({BlockHash? at}) async {
    final blockHash = at ?? store.chain.latestHash;
    final durations = await Future.wait([
      encointerKusama.query.encointerScheduler.phaseDurations(et.CeremonyPhaseType.registering, at: blockHash),
      encointerKusama.query.encointerScheduler.phaseDurations(et.CeremonyPhaseType.assigning, at: blockHash),
      encointerKusama.query.encointerScheduler.phaseDurations(et.CeremonyPhaseType.attesting, at: blockHash),
    ]);

    // Create map and cast to the old type before introducing polkadart
    // shall be changed later
    final phaseDurationMap = Map.of({
      CeremonyPhase.Registering: durations[0].toInt(),
      CeremonyPhase.Assigning: durations[1].toInt(),
      CeremonyPhase.Attesting: durations[2].toInt(),
    });

    store.encointer.setPhaseDurations(phaseDurationMap);
  }

  /// Queries the rpc 'encointer_getAggregatedAccountData' with the dart api.
  ///
  /// Todo: Be able to handle pubKey and any address and transform it to the
  /// address with prefix 42. Needs #1105.
  Future<AggregatedAccountData> getAggregatedAccountData(
    CommunityIdentifier cid,
    String pubKey, {
    BlockHash? at,
  }) async {
    final address = AddressUtils.pubKeyHexToAddress(pubKey);

    try {
      final accountData = await _dartApi.getAggregatedAccountData(cid, address, at: at ?? store.chain.latestHash);
      Log.d(
        '[EncointerApi]: AggregatedAccountData for ${cid.toFmtString()} and ${address.substring(0, 7)}...: $accountData'
        'EncointerApi',
      );
      return accountData;
    } catch (e) {
      throw Exception('[EncointerApi]: Error getting aggregated account data $e');
    }
  }

  Future<List<String>> pendingExtrinsics() async {
    try {
      final extrinsics = await _dartApi.pendingExtrinsics();
      return List.from(extrinsics);
    } catch (e) {
      throw Exception('[EncointerApi]: Error getting pending extrinsics: $e');
    }
  }

  Future<Map<CommunityIdentifier, BalanceEntry>> getAllBalances(String account, {BlockHash? at}) async {
    return _dartApi.getAllBalances(account, at: at ?? store.chain.latestHash);
  }

  /// Queries the Scheduler pallet: encointerScheduler.currentCeremonyIndex().
  Future<int?> getCurrentCeremonyIndex({BlockHash? at}) async {
    Log.d('api: getCurrentCeremonyIndex', 'EncointerApi');
    final cIndex =
        await encointerKusama.query.encointerScheduler.currentCeremonyIndex(at: at ?? store.chain.latestHash);
    Log.d('api: Current Ceremony index: $cIndex', 'EncointerApi');
    store.encointer.setCurrentCeremonyIndex(cIndex);
    return cIndex;
  }

  /// Queries the Communities pallet's RPC: api.rpc.communities.getLocations(cid)
  Future<void> getAllMeetupLocations({BlockHash? at}) async {
    Log.d('api: getAllMeetupLocations', 'EncointerApi');
    final cid = store.encointer.chosenCid;

    if (cid == null) return;

    final locations = await _dartApi.getLocations(cid, at: at ?? store.chain.latestHash);

    Log.d('api: getAllMeetupLocations: $locations ' 'EncointerApi');
    if (store.encointer.community != null) {
      store.encointer.community!.setMeetupLocations(locations);
    }
  }

  /// Queries the Communities pallet: encointerCommunities.communityMetadata(cid)
  Future<void> getCommunityMetadata({BlockHash? at}) async {
    Log.d('api: getCommunityMetadata', 'EncointerApi');
    final cid = store.encointer.chosenCid;
    if (cid == null) return;

    final meta = await encointerKusama.query.encointerCommunities
        .communityMetadata(
          et.CommunityIdentifier(geohash: cid.geohash, digest: cid.digest),
          at: at ?? store.chain.latestHash,
        )
        .then(CommunityMetadata.fromPolkadart); // convert to our own type

    Log.d('api: community metadata: $meta', 'EncointerApi');
    await store.encointer.community?.setCommunityMetadata(meta);
  }

  /// Queries the Communities and the Balances pallet:
  ///   encointerCommunities.demurragePerBloc(cid)
  ///   encointerBalances.defaultDemurragePerBlock
  ///
  /// Returns the community specific demurrage if defined,
  /// otherwise the default demurrage from the balances pallet
  /// is returned.
  Future<void> getDemurrage({BlockHash? at}) async {
    final cid = store.encointer.chosenCid;
    if (cid == null) return;

    var dem = await encointerKusama.query.encointerBalances
        .demurragePerBlock(
          et.CommunityIdentifier(geohash: cid.geohash, digest: cid.digest),
          at: at ?? store.chain.latestHash,
        )
        .then((value) => i64F64Parser.toDouble(value.bits));

    if (dem == 0) {
      Log.p('api: community demurrage is 0, defaulting to global default demurrage.', 'EncointerApi');
      dem = i64F64Parser.toDouble(encointerKusama.constant.encointerBalances.defaultDemurrage.bits);
    }

    Log.d('api: fetched demurrage: $dem', 'EncointerApi');
    if (store.encointer.community != null) {
      store.encointer.community!.setDemurrage(dem);
    }
  }

  /// Calls the custom rpc: api.rpc.communities.communitiesGetAll()
  Future<void> communitiesGetAll({BlockHash? at}) async {
    final cidNames = await _dartApi.getAllCommunities(at: at ?? store.chain.latestHash);

    Log.d('api: CidNames: ${cidNames.length} and $cidNames ', 'EncointerApi');
    store.encointer.setCommunities(cidNames);
  }

  /// Queries the Scheduler pallet
  Future<DateTime?> getMeetupTime({BlockHash? at}) async {
    Log.d('api: getMeetupTime', 'EncointerApi');

    // I we are not assigned to a meetup, we just get any location to get
    // an estimate of the chosen community's meetup times.
    final locationIndex = store.encointer.communityAccount?.meetup?.locationIndex;
    final mLocation = locationIndex != null && store.encointer.community?.meetupLocations != null
        ? store.encointer.community?.meetupLocations![locationIndex]
        : store.encointer.community?.meetupLocations?.first;

    final attestingStart = store.encointer.attestingPhaseStart;

    if (mLocation == null) {
      Log.p("No meetup locations found, can't get meetup time.", 'EncointerApi');
      return Future.value();
    }

    if (attestingStart == null) {
      Log.p("attestingStart == 0, can't get meetup time.", 'EncointerApi');
      return Future.value();
    }

    final offset = await encointerKusama.query.encointerCeremonies.meetupTimeOffset(at: at ?? store.chain.latestHash);

    final meetupTime = ew_utils.meetupTime(
      double.parse(mLocation.lon),
      attestingStart,
      offset,
      ew_utils.momentsPerDay,
    );

    Log.d('api: Next Meetup Time: $meetupTime', 'EncointerApi');
    store.encointer.community!.setMeetupTime(meetupTime);
    return DateTime.fromMillisecondsSinceEpoch(meetupTime);
  }

  Future<void> getMeetupTimeOverride({bool devMode = false}) async {
    Log.d('api: Check if there are meetup time overrides', 'EncointerApi');
    final cid = store.encointer.chosenCid;
    if (cid == null) return;

    try {
      final response = await ewHttp.getTypeList(
        '${getEncointerFeedLink(devMode: devMode)}/$encointerFeedOverridesPath',
        fromJson: MeetupOverrides.fromJson,
      );
      response.fold((l) => Log.e(l.toString()), (overrides) async {
        final meetupTimeOverride = await feed.getMeetupTimeOverride(
          network: store.encointer.network,
          cid: cid,
          phase: store.encointer.currentPhase,
          overrides: overrides,
        );
        if (store.encointer.community != null) {
          store.encointer.community!.setMeetupTimeOverride(meetupTimeOverride?.millisecondsSinceEpoch);
        }
      });
    } catch (e, s) {
      Log.e('api: exception: $e', 'EncointerApi', s);
    }
  }

  Future<bool?> hasPendingIssuance({BlockHash? at}) async {
    final cid = store.encointer.chosenCid;

    final cIndex = store.encointer.currentCeremonyIndex;
    final address = store.account.currentAddress;
    Log.d('api: Getting pendingIssuance for $address', 'EncointerApi');

    if (address.isEmpty || cid == null || cIndex == null || cIndex <= 1) {
      return false;
    }

    // -1 as we get the pending issuance for the last ceremony
    var issuanceCIndex = cIndex - 1;

    if (store.encointer.currentPhase == CeremonyPhase.Attesting) {
      // If we are in the attesting phase we want to payout the current meetup
      // aka early payout directly after the key-signing gathering.
      issuanceCIndex = cIndex;
    }

    final cc = Tuple2(et.CommunityIdentifier(geohash: cid.geohash, digest: cid.digest), issuanceCIndex);

    try {
      final participantMeetupIndex = await getMeetupIndex(
        cc,
        Address.decode(address),
        at: at ?? store.chain.latestHash,
      );

      if (participantMeetupIndex == 0) {
        Log.d('[hasPendingIssuance] participant was not assigned to a meetup');
        return false;
      }

      final meetupResult = await encointerKusama.query.encointerCeremonies.issuedRewards(
        cc,
        BigInt.from(participantMeetupIndex),
        at: at ?? store.chain.latestHash,
      );

      if (meetupResult == null) {
        return true;
      } else {
        Log.d('[hasPendingIssuance] meetupResult: ${jsonEncode(meetupResult)}');
        return false;
      }
    } catch (e) {
      Log.e('[hasPendingIssuance] exception in getting pending rewards: $e');
      return false;
    }
  }

  Future<int> getMeetupIndex(
    Tuple2<et.CommunityIdentifier, int> cc,
    Address address, {
    BlockHash? at,
  }) async {
    final blockHash = at ?? store.chain.latestHash;
    final [mCount, assignments, assignmentCount, registration] = await Future.wait([
      encointerKusama.query.encointerCeremonies.meetupCount(cc, at: blockHash),
      encointerKusama.query.encointerCeremonies.assignments(cc, at: blockHash),
      encointerKusama.query.encointerCeremonies.assignmentCounts(cc, at: blockHash),
      getParticipantRegistration(cc, address, at: blockHash),
    ]);

    if (mCount == 0) {
      Log.d('[hasPendingIssuance] No meetups in last cycle.');
      return 0;
    }

    if (registration == null) {
      Log.d('[hasPendingIssuance] No participant registration found for last cycle.');
      return 0;
    }

    final participantMeetupIndex = ew_utils.computeMeetupIndex(
      (registration as ParticipantRegistration).pIndex,
      registration.participantType,
      assignments! as et.Assignment,
      assignmentCount! as et.AssignmentCount,
      (mCount! as BigInt).toInt(),
    );

    return participantMeetupIndex;
  }

  Future<ParticipantRegistration?> getParticipantRegistration(
    Tuple2<et.CommunityIdentifier, int> cc,
    Address address, {
    BlockHash? at,
  }) async {
    final blockHash = at ?? store.chain.latestHash;

    final pIndexes = await Future.wait([
      encointerKusama.query.encointerCeremonies.bootstrapperIndex(cc, address.pubkey, at: blockHash),
      encointerKusama.query.encointerCeremonies.reputableIndex(cc, address.pubkey, at: blockHash),
      encointerKusama.query.encointerCeremonies.endorseeIndex(cc, address.pubkey, at: blockHash),
      encointerKusama.query.encointerCeremonies.newbieIndex(cc, address.pubkey, at: blockHash),
    ]);

    if (pIndexes[0] != BigInt.zero) {
      return ParticipantRegistration(pIndexes[0].toInt(), et.ParticipantType.bootstrapper);
    } else if (pIndexes[1] != BigInt.zero) {
      return ParticipantRegistration(pIndexes[1].toInt(), et.ParticipantType.reputable);
    } else if (pIndexes[2] != BigInt.zero) {
      return ParticipantRegistration(pIndexes[2].toInt(), et.ParticipantType.endorsee);
    } else if (pIndexes[3] != BigInt.zero) {
      return ParticipantRegistration(pIndexes[3].toInt(), et.ParticipantType.newbie);
    }

    return null;
  }

  /// Queries the EncointerBalances pallet: encointer.encointerBalances.balance(cid, address).
  Future<BalanceEntry> getEncointerBalance(
    String address,
    CommunityIdentifier cid, {
    BlockHash? at,
  }) async {
    Log.d('Getting encointer balance for $address and ${cid.toFmtString()}', 'EncointerApi');

    final balanceEntry = await encointerKusama.query.encointerBalances.balance(
      et.CommunityIdentifier(
        geohash: cid.geohash,
        digest: cid.digest,
      ),
      AddressUtils.addressToPubKey(address).toList(),
      at: at ?? store.chain.latestHash,
    );

    Log.d('balanceEntryJson: $balanceEntry', 'EncointerApi');

    return BalanceEntry.fromPolkadart(balanceEntry);
  }

  Future<void> subscribeCurrentPhase() async {
    unawaited(getCurrentPhase());
    await _currentPhaseSubscription?.cancel();
    final currentPhaseKey = encointerKusama.query.encointerScheduler.currentPhaseKey();

    _currentPhaseSubscription =
        await encointerKusama.rpc.state.subscribeStorage([currentPhaseKey], (storageChangeSet) async {
      if (storageChangeSet.changes[0].value != null) {
        final phasePolkadart = et.CeremonyPhaseType.decode(ByteInput(storageChangeSet.changes[0].value!));
        Log.p('[subscribeCurrentPhase] Got new phase: $phasePolkadart');

        final cid = store.encointer.chosenCid;
        final pubKey = store.account.currentAccountPubKey;
        final phase = ceremonyPhaseTypeFromPolkadart(phasePolkadart);

        if (cid != null && pubKey != null && pubKey.isNotEmpty) {
          final address = store.account.currentAddress;
          final data = await pollAggregatedAccountDataUntilNextPhase(phase, cid, pubKey);
          store.encointer.setAggregatedAccountData(cid, address, data);
        }

        store.encointer.setCurrentPhase(phase);
        await getNextPhaseTimestamp();
      }
    });
  }

  /// Polls the aggregated account data until its ceremony phase field equals [nextPhase].
  ///
  /// This is needed because because the latestHash slightly lags behind, as it involves a
  /// network request based on the `bestHead` subscription.
  Future<AggregatedAccountData> pollAggregatedAccountDataUntilNextPhase(
    CeremonyPhase nextPhase,
    CommunityIdentifier cid,
    String pubKey,
  ) async {
    while (true) {
      final data = await getAggregatedAccountData(cid, pubKey, at: store.chain.latestHash);
      final phase = data.global.ceremonyPhase;

      if (nextPhase == phase) {
        Log.d('[EncointerApi] received account data valid for the new ceremony phase', 'EncointerApi');
        return data;
      } else {
        await Future.delayed(
          const Duration(seconds: 3),
          () => Log.d('[EncointerApi] polling account data until next phase is reached...', 'EncointerApi'),
        );
      }
    }
  }

  /// Subscribes to new community identifies.
  Future<void> subscribeCommunityIdentifiers() async {
    // contrary to the JS subscriptions, we don't get the current
    // value upon subscribing, only when it changes.
    unawaited(getCommunityIdentifiers().then(store.encointer.setCommunityIdentifiers).then((_) => communitiesGetAll()));

    await _cidSubscription?.cancel();
    final cidsPhaseKey = encointerKusama.query.encointerCommunities.communityIdentifiersKey();

    _cidSubscription = await encointerKusama.rpc.state.subscribeStorage([cidsPhaseKey], (storageChangeSet) async {
      if (storageChangeSet.changes[0].value != null) {
        final cidsPolkadart = const SequenceCodec(et.CommunityIdentifier.codec).decode(
          ByteInput(storageChangeSet.changes[0].value!),
        );
        Log.p('[subscribeCommunityIdentifiers] got cids: $cidsPolkadart');

        // transform them into our own cid
        final cids = cidsPolkadart.map(CommunityIdentifier.fromPolkadart).toList();

        await store.encointer.setCommunityIdentifiers(cids);
        await communitiesGetAll();
      }
    });
  }

  Future<void> subscribeBusinessRegistry() async {
    // todo: implement subscribing
  }

  /// Queries the EncointerCurrencies pallet: encointerCurrencies.communityIdentifiers().
  Future<List<CommunityIdentifier>> getCommunityIdentifiers({BlockHash? at}) async {
    // cids in polkadart type
    final cidsPolkadart =
        await encointerKusama.query.encointerCommunities.communityIdentifiers(at: at ?? store.chain.latestHash);

    // transform them into our own cid
    final cids = cidsPolkadart.map(CommunityIdentifier.fromPolkadart).toList();

    Log.d('[getCommunityIdentifiers]: $cids', 'EncointerApi');
    return cids;
  }

  /// Queries the EncointerCommunities pallet: encointerCommunities.bootstrappers(cid).
  Future<void> getBootstrappers({BlockHash? at}) async {
    final cid = store.encointer.chosenCid;

    if (cid == null) return;

    final bootstrappersBytes = await encointerKusama.query.encointerCommunities.bootstrappers(
      et.CommunityIdentifier(
        geohash: cid.geohash,
        digest: cid.digest,
      ),
      at: at ?? store.chain.latestHash,
    );

    final bootstrappers =
        bootstrappersBytes.map((p) => AddressUtils.pubKeyToAddress(p, prefix: store.settings.endpoint.ss58!)).toList();

    Log.d('api: bootstrappers $bootstrappers', 'EncointerApi');
    if (store.encointer.community != null) {
      await store.encointer.community!.setBootstrappers(bootstrappers);
    }
  }

  Future<void> getReputations({BlockHash? at}) async {
    final address = store.account.currentAddress;

    if (address.isEmpty) return;

    final runtimeVersion = await encointerKusama.rpc.state.getRuntimeVersion(at: at ?? store.chain.latestHash);

    if (hasNewReputationType(runtimeVersion)) {
      final reputations = await _dartApi.getReputations(address, at: at ?? store.chain.latestHash);
      Log.d('api: getReputationsV2: $reputations', 'EncointerApi');
      if (reputations.isNotEmpty) await store.encointer.account?.setReputations(reputations);
    } else {
      final reputationsV1 = await _dartApi.getReputationsV1(address, at: at ?? store.chain.latestHash);
      Log.d('api: getReputations: $reputationsV1', 'EncointerApi');
      final cIndex = store.encointer.currentCeremonyIndex ?? 0;
      final reputations = Map.fromEntries(reputationsV1.entries.map((e) => MapEntry(e.key, e.value.toV2(cIndex))));
      Log.d('api: getReputations (migrated to V2): $reputations', 'EncointerApi');

      if (reputations.isNotEmpty) await store.encointer.account?.setReputations(reputations);
    }
  }

  bool hasNewReputationType(RuntimeVersion version) {
    Log.p('Runtime version ${version.toJson()}');
    if (version.specName == 'encointer-parachain') {
      return version.specVersion >= 1002000;
    } else if (version.specName == 'encointer-node-notee') {
      return version.specVersion >= 31;
    } else {
      Log.p('unknown spec name found: ${version.specName}. Assuming that the runtime has new reputation type');
      return true;
    }
  }

  /// Gets a proof of attendance for the oldest attended ceremony, if available.
  ///
  /// returns null, if none available.
  ///
  /// Note: this returns the polkadart generated type.
  ProofOfAttendance? getProofOfAttendance() {
    final pubKey = store.account.currentAccountPubKey;
    final currentCeremonyIndex = store.encointer.currentCeremonyIndex;

    if (currentCeremonyIndex == null) return null;

    final cIndex = store.encointer.account?.ceremonyIndexForNextProofOfAttendance(currentCeremonyIndex);

    if (cIndex == null || cIndex == 0) {
      return null;
    }

    final cid = store.encointer.account?.verifiedReputations[cIndex]?.communityIdentifier;
    if (cid == null) return null;

    final proof = ProofOfAttendanceFactory.signed(
      proverPublic: hex.decode(pubKey!.replaceFirst('0x', '')),
      ceremonyIndex: cIndex,
      communityIdentifier: et.CommunityIdentifier(geohash: cid.geohash, digest: cid.digest),
      attendee: store.account.getKeyringAccount(pubKey).pair,
    );

    Log.d('Proof: ${proof.toJson()}', 'EncointerApi');
    return proof;
  }

  Future<int> getNumberOfNewbieTicketsForReputable({BlockHash? at}) async {
    final address = store.account.currentAddress;
    final reputations = store.encointer.account?.verifiedReputations ?? {};
    final cid = store.encointer.chosenCid;
    final cIndex = store.encointer.currentCeremonyIndex;

    if (cid == null) return 0;
    if (cIndex == null) return 0;
    if (reputations.isEmpty) return 0;

    try {
      final [burned, ticketsPerReputable] = await Future.wait([
        encointerKusama.query.encointerCeremonies.burnedReputableNewbieTickets(
          Tuple2(et.CommunityIdentifier(geohash: cid.geohash, digest: cid.digest), cIndex),
          AddressUtils.addressToPubKey(address).toList(),
          at: at ?? store.chain.latestHash,
        ),
        encointerKusama.query.encointerCeremonies.endorsementTicketsPerReputable(at: at ?? store.chain.latestHash)
      ]);
      Log.p('NewbieTickets: ticketPerReputable: $ticketsPerReputable, burned: $burned');
      return ticketsPerReputable - burned;
    } catch (e, s) {
      Log.e('EncointerApi', '$e', s);
    }

    return 0;
  }

  Future<int> getNumberOfNewbieTicketsForBootstrapper({BlockHash? at}) async {
    final address = store.account.currentAddress;
    final cid = store.encointer.chosenCid;
    if (cid == null) return 0;

    try {
      final [burned, ticketsPerBootstrapper] = await Future.wait([
        encointerKusama.query.encointerCeremonies.burnedBootstrapperNewbieTickets(
          et.CommunityIdentifier(geohash: cid.geohash, digest: cid.digest),
          AddressUtils.addressToPubKey(address).toList(),
          at: at ?? store.chain.latestHash,
        ),
        encointerKusama.query.encointerCeremonies.endorsementTicketsPerBootstrapper(at: at ?? store.chain.latestHash),
      ]);

      Log.p('NewbieTickets: ticketsPerBootstrapper: $ticketsPerBootstrapper, burned: $burned');

      // could be negative in case the `ticketsPerBootstrapper` has been decreased over time.
      return max(ticketsPerBootstrapper - burned, 0);
    } catch (e, s) {
      Log.e('Encointer Api', '$e', s);
    }

    return 0;
  }

  Future<Map<String, Faucet>> getAllFaucetsWithAccount({BlockHash? at}) async {
    try {
      final prefix = encointerKusama.query.encointerFaucet.faucetsMapPrefix();
      final keys = await encointerKusama.rpc.state.getKeysPaged(key: prefix, count: 50);

      // Keys including storage prefix.
      Log.d("[getAllFaucets] storageKeys: ${keys.map((key) => '0x${hex.encode(key)}')}");

      final faucetPubKeys = keys.map((key) => const AccountId32Codec().decode(ByteInput(key.sublist(32))));

      final faucets = await Future.wait(faucetPubKeys.map(
        (key) => encointerKusama.query.encointerFaucet
            .faucets(key, at: at ?? store.chain.latestHash)
            .then((faucet) => Faucet.fromPolkadart(faucet!)),
      ));

      final pubKeyHex = faucetPubKeys.map((accountId) => '0x${hex.encode(accountId)}');
      Log.d("[getAllFaucets] accounts: $pubKeyHex'");

      final f = Map.fromIterables(pubKeyHex, faucets);
      Log.d('[getAllFaucets] faucets: $f');
      return f;
    } catch (e, s) {
      Log.e('[getAllFaucets]', '$e', s);
      return Map.of({});
    }
  }

  Future<Map<BigInt, Proposal>> getProposalHistory({BigInt? mostRecent, BigInt? count, BlockHash? at}) async {
    try {
      final proposalIds = await getProposalIds(mostRecent: mostRecent, count: count, at: at);

      // Keys including storage prefix.
      Log.d("[getProposals] ProposalIds: $proposalIds')}");

      final proposals = await Future.wait(proposalIds.map(
        (key) => encointerKusama.query.encointerDemocracy
            .proposals(key, at: at ?? store.chain.latestHash)
            // We know that the proposal exists because we fetched the keys before.
            .then((maybeProposal) => maybeProposal!),
      ));

      final proposalMap = Map.fromIterables(proposalIds, proposals);
      Log.d('[getProposals] proposals: $proposalMap');
      return proposalMap;
    } catch (e, s) {
      Log.e('[getProposals]', '$e', s);
      return Map.of({});
    }
  }

  Future<Map<BigInt, Tally>> getTallies({BigInt? mostRecent, BigInt? count, BlockHash? at}) async {
    try {
      final proposalIds = await getProposalIds(mostRecent: mostRecent, count: count, at: at);

      // Keys including storage prefix.
      Log.d('[getProposals] ProposalIds: $proposalIds)}');

      final tallies = await Future.wait(proposalIds.map(
        (key) => encointerKusama.query.encointerDemocracy
            .tallies(key, at: at ?? store.chain.latestHash)
            // We know that the tally exists because we fetched the keys before.
            .then((maybeTally) => maybeTally!),
      ));

      final tallyMap = Map.fromIterables(proposalIds, tallies);
      Log.d('[getTallies] tallies: $tallyMap');
      return tallyMap;
    } catch (e, s) {
      Log.e('[getTallies]', '$e', s);
      return Map.of({});
    }
  }

  Future<List<BigInt>> getProposalIds({BigInt? mostRecent, BigInt? count, BlockHash? at}) async {
    final from = mostRecent ?? await encointerKusama.query.encointerDemocracy.proposalCount(at: at);
    final c = count ?? BigInt.one;
    final lowerBound = max(1, (from - c).toInt());

    final proposalIds = [for(var i=lowerBound; i< from.toInt(); i+=1) BigInt.from(i)];
    return proposalIds;
  }

  DemocracyParams democracyParams() {
    final minTurnout = encointerKusama.constant.encointerDemocracy.minTurnout;
    final confirmationPeriod = encointerKusama.constant.encointerDemocracy.confirmationPeriod;
    final proposalLifetime = encointerKusama.constant.encointerDemocracy.proposalLifetime;

    return DemocracyParams(
      minTurnout: minTurnout,
      confirmationPeriod: confirmationPeriod,
      proposalLifetime: proposalLifetime,
    );
  }

  Future<bool> hasCommittedFor(
    CommunityIdentifier cid,
    int cIndex,
    int purposeId,
    String address, {
    BlockHash? at,
  }) async {
    final cc = Tuple2(et.CommunityIdentifier(geohash: cid.geohash, digest: cid.digest), cIndex);
    final purposeAccountTuple = Tuple2(BigInt.from(purposeId), Address.decode(address).pubkey);

    try {
      // Commitment is an Option<H256>, so we need to see if the key exists, as None maps to null.
      final prefix = encointerKusama.query.encointerReputationCommitments.commitmentsMapPrefix(cc);
      final fullKey = encointerKusama.query.encointerReputationCommitments.commitmentsKey(cc, purposeAccountTuple);
      final fullKeyHex = '0x${hex.encode(fullKey)}';

      final keys =
          await encointerKusama.rpc.state.getKeysPaged(key: prefix, count: 50, at: at ?? store.chain.latestHash);
      final keysHex = keys.map((key) => '0x${hex.encode(key)}');

      // Need to use hexKeys here, to check for equality.
      final hasCommitted = keysHex.contains(fullKeyHex);

      Log.d('[hasCommittedFor] keys     = $keysHex');
      Log.d('[hasCommittedFor] fullKey  = $fullKeyHex');
      Log.d('[hasCommittedFor] hasCommitted = $hasCommitted');
      return hasCommitted;
    } catch (e, s) {
      Log.e('[hasCommittedFor] exception', '$e', s);
      return false;
    }
  }

  /// Get all the registered businesses for the current `chosenCid`
  Future<List<AccountBusinessTuple>> getBusinesses({BlockHash? at}) async {
    // set the store because the current bazaar data model reads the values from the store.
    store.encointer.bazaar?.setBusinessRegistry(allMockBusinesses);
    return allMockBusinesses;
  }

  Future<List<AccountBusinessTuple>> bazaarGetBusinesses(CommunityIdentifier cid, {BlockHash? at}) async {
    return _dartApi.bazaarGetBusinesses(cid, at: at ?? store.chain.latestHash);
  }

  Future<Either<Businesses, EwHttpException>> getBusinessesIpfs(String ipfsUrlHash) async {
    final url = '$infuraIpfsUrl/$ipfsUrlHash';
    return ewHttp.getType(url, fromJson: Businesses.fromJson);
  }

  ///TODO(Azamat): method not working, fix it
  Future<Either<Map<String, dynamic>, EwHttpException>> getBusinessesPhotos(String ipfsUrlHash) async {
    final url = '$infuraIpfsUrl/$ipfsUrlHash';
    final response = ewHttp.get<Map<String, dynamic>>(url);

    return response;
  }

  /// Get all the registered offerings for the current `chosenCid`
  Future<List<OfferingData>> getOfferings({BlockHash? at}) async {
    // Todo: @armin you'd probably extend the encointer store and also set the store here.
    return allMockOfferings;
  }

  /// Get all the registered offerings for the business with [bid]
  Future<List<OfferingData>> getOfferingsForBusiness(BusinessIdentifier bid, {BlockHash? at}) async {
    // Todo: @armin you'd probably extend the encointer store and also set the store here.
    return business1MockOfferings;
  }

  Future<List<OfferingData>> bazaarGetOfferingsForBusiness(CommunityIdentifier cid, String? controller,
      {BlockHash? at}) async {
    return _dartApi.bazaarGetOfferingsForBusiness(cid, controller, at: at ?? store.chain.latestHash);
  }

  Future<Either<ItemOffered, EwHttpException>> getItemOffered(String ipfsUrlHash) async {
    final url = '$infuraIpfsUrl/$ipfsUrlHash';
    return ewHttp.getType(url, fromJson: ItemOffered.fromJson);
  }

  Future<Either<IpfsProduct, EwHttpException>> getSingleBusinessProduct(String ipfsUrlHash) async {
    final url = '$infuraIpfsUrl/$ipfsUrlHash';
    return ewHttp.getType(url, fromJson: IpfsProduct.fromJson);
  }
}

class ParticipantRegistration {
  ParticipantRegistration(this.pIndex, this.participantType);

  final int pIndex;
  final et.ParticipantType participantType;
}

@immutable
class DemocracyParams {
  const DemocracyParams({
    required this.minTurnout,
    required this.confirmationPeriod,
    required this.proposalLifetime,
  });

  final BigInt minTurnout;
  final BigInt confirmationPeriod;
  final BigInt proposalLifetime;
}
