import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/mocks/mock_bazaar_data.dart';
import 'package:encointer_wallet/models/bazaar/account_business_tuple.dart';
import 'package:encointer_wallet/models/bazaar/business_identifier.dart';
import 'package:encointer_wallet/models/bazaar/offering_data.dart';
import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/models/communities/community_metadata.dart';
import 'package:encointer_wallet/models/encointer_balance_data/balance_entry.dart';
import 'package:encointer_wallet/models/index.dart';
import 'package:encointer_wallet/models/proof_of_attendance/proof_of_attendance.dart';
import 'package:encointer_wallet/models/bazaar/businesses.dart';
import 'package:encointer_wallet/models/bazaar/ipfs_product.dart';
import 'package:encointer_wallet/models/bazaar/item_offered.dart';
import 'package:encointer_wallet/models/faucet/faucet.dart';
import 'package:encointer_wallet/service/encointer_feed/feed.dart' as feed;
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/substrate_api/core/dart_api.dart';
import 'package:encointer_wallet/service/substrate_api/core/js_api.dart';
import 'package:encointer_wallet/service/substrate_api/encointer/encointer_dart_api.dart';
import 'package:encointer_wallet/service/substrate_api/encointer/no_tee_api.dart';
import 'package:encointer_wallet/service/substrate_api/encointer/tee_proxy_api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:ew_encointer_utils/ew_encointer_utils.dart' as ew_utils;
import 'package:ew_http/ew_http.dart';
import 'package:ew_keyring/ew_keyring.dart';
import 'package:ew_polkadart/ew_polkadart.dart';
import 'package:ew_substrate_fixed/substrate_fixed.dart';

// disambiguate global imports of encointer types. We can remove this
// once we got rid of our manual type definitions.
import 'package:ew_polkadart/encointer_types.dart' as et;

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
  EncointerApi(this.store, this.jsApi, SubstrateDartApi dartApi, this.ewHttp, this.encointerKusama)
      : _noTee = NoTeeApi(jsApi),
        _teeProxy = TeeProxyApi(jsApi),
        _dartApi = EncointerDartApi(dartApi);

  final JSApi jsApi;
  final EncointerDartApi _dartApi;
  final EwHttp ewHttp;
  final EncointerKusama encointerKusama;

  final AppStore store;

  StreamSubscription<StorageChangeSet>? _currentPhaseSubscription;
  StreamSubscription<StorageChangeSet>? _cidSubscription;

  /// Placeholder, we don't subscribe to the business registry yet.
  StreamSubscription<StorageChangeSet>? _businessRegistry;

  final NoTeeApi _noTee;
  final TeeProxyApi _teeProxy;

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

  Future<void> close() async {
    Log.d('[EncointerApi: closing', 'EncointerApi');
    return _dartApi.close();
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
  }

  /// Queries the Scheduler pallet: encointerScheduler.currentPhase().
  Future<CeremonyPhase?> getCurrentPhase() async {
    Log.d('api: getCurrentPhase', 'EncointerApi');
    final phase = await encointerKusama.query.encointerScheduler.currentPhase().then(ceremonyPhaseTypeFromPolkadart);

    Log.d('api: Phase enum: $phase', 'EncointerApi');
    store.encointer.setCurrentPhase(phase);
    return phase;
  }

  /// Queries the Scheduler pallet: encointerScheduler.nextPhaseTimestamp().
  Future<int> getNextPhaseTimestamp() async {
    Log.d('api: getNextPhaseTimestamp', 'EncointerApi');
    final timestampBigInt = await encointerKusama.query.encointerScheduler.nextPhaseTimestamp();
    final timestamp = timestampBigInt.toInt();

    Log.d('api: next phase timestamp: $timestamp', 'EncointerApi');
    store.encointer.setNextPhaseTimestamp(timestamp);
    return timestamp;
  }

  /// Queries the Scheduler pallet: encointerScheduler.currentPhase().
  ///
  /// This should be done only once at app-startup, as this is practically const.
  Future<void> getPhaseDurations() async {
    final durations = await Future.wait([
      encointerKusama.query.encointerScheduler.phaseDurations(et.CeremonyPhaseType.registering),
      encointerKusama.query.encointerScheduler.phaseDurations(et.CeremonyPhaseType.assigning),
      encointerKusama.query.encointerScheduler.phaseDurations(et.CeremonyPhaseType.attesting),
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
  Future<AggregatedAccountData> getAggregatedAccountData(CommunityIdentifier cid, String pubKey) async {
    final address = AddressUtils.pubKeyHexToAddress(pubKey);

    try {
      final accountData = await _dartApi.getAggregatedAccountData(cid, address);
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

  Future<Map<CommunityIdentifier, BalanceEntry>> getAllBalances(String account) async {
    return _dartApi.getAllBalances(account);
  }

  /// Queries the Scheduler pallet: encointerScheduler.currentCeremonyIndex().
  Future<int?> getCurrentCeremonyIndex() async {
    Log.d('api: getCurrentCeremonyIndex', 'EncointerApi');
    final cIndex = await encointerKusama.query.encointerScheduler.currentCeremonyIndex();
    Log.d('api: Current Ceremony index: $cIndex', 'EncointerApi');
    store.encointer.setCurrentCeremonyIndex(cIndex);
    return cIndex;
  }

  /// Queries the Communities pallet's RPC: api.rpc.communities.getLocations(cid)
  Future<void> getAllMeetupLocations() async {
    Log.d('api: getAllMeetupLocations', 'EncointerApi');
    final cid = store.encointer.chosenCid;

    if (cid == null) return;

    final locations = await _dartApi.getLocations(cid);

    Log.d('api: getAllMeetupLocations: $locations ' 'EncointerApi');
    if (store.encointer.community != null) {
      store.encointer.community!.setMeetupLocations(locations);
    }
  }

  /// Queries the Communities pallet: encointerCommunities.communityMetadata(cid)
  Future<void> getCommunityMetadata() async {
    Log.d('api: getCommunityMetadata', 'EncointerApi');
    final cid = store.encointer.chosenCid;
    if (cid == null) return;

    final meta = await encointerKusama.query.encointerCommunities
        .communityMetadata(et.CommunityIdentifier(geohash: cid.geohash, digest: cid.digest))
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
  Future<void> getDemurrage() async {
    final cid = store.encointer.chosenCid;
    if (cid == null) return;

    var dem = await encointerKusama.query.encointerBalances
        .demurragePerBlock(et.CommunityIdentifier(geohash: cid.geohash, digest: cid.digest))
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
  Future<void> communitiesGetAll() async {
    final cidNames = await _dartApi.getAllCommunities();

    Log.d('api: CidNames: ${cidNames.length} and $cidNames ', 'EncointerApi');
    store.encointer.setCommunities(cidNames);
  }

  /// Queries the Scheduler pallet
  Future<DateTime?> getMeetupTime() async {
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

    final offset = await encointerKusama.query.encointerCeremonies.meetupTimeOffset();

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

  Future<bool?> hasPendingIssuance() async {
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

    final participantMeetupIndex = await getMeetupIndex(cc, Address.decode(address));

    if (participantMeetupIndex == 0) {
      Log.d('[hasPendingIssuance] participant was not assigned to a meetup');
      return false;
    }

    final meetupResult =
        await encointerKusama.query.encointerCeremonies.issuedRewards(cc, BigInt.from(participantMeetupIndex));

    if (meetupResult == null) {
      return true;
    } else {
      Log.d('[hasPendingIssuance] meetupResult: ${jsonEncode(meetupResult)}');
      return false;
    }
  }

  Future<int> getMeetupIndex(
    Tuple2<et.CommunityIdentifier, int> cc,
    Address address,
  ) async {
    final [mCount, assignments, assignmentCount, registration] = await Future.wait([
      encointerKusama.query.encointerCeremonies.meetupCount(cc),
      encointerKusama.query.encointerCeremonies.assignments(cc),
      encointerKusama.query.encointerCeremonies.assignmentCounts(cc),
      getParticipantRegistration(cc, address),
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
      mCount! as int,
    );

    return participantMeetupIndex;
  }

  Future<ParticipantRegistration?> getParticipantRegistration(
    Tuple2<et.CommunityIdentifier, int> cc,
    Address address,
  ) async {
    final pIndexes = await Future.wait([
      encointerKusama.query.encointerCeremonies.bootstrapperIndex(cc, address.pubkey),
      encointerKusama.query.encointerCeremonies.reputableIndex(cc, address.pubkey),
      encointerKusama.query.encointerCeremonies.endorseeIndex(cc, address.pubkey),
      encointerKusama.query.encointerCeremonies.newbieIndex(cc, address.pubkey),
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
  Future<BalanceEntry> getEncointerBalance(String pubKeyOrAddress, CommunityIdentifier cid, String pin) async {
    Log.d('Getting encointer balance for $pubKeyOrAddress and ${cid.toFmtString()}', 'EncointerApi');

    final balanceEntry = store.settings.endpointIsNoTee
        ? await _noTee.balance(cid, pubKeyOrAddress)
        : await _teeProxy.balance(cid, pubKeyOrAddress, pin);

    Log.d('balanceEntryJson: $balanceEntry', 'EncointerApi');

    return balanceEntry;
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
          // The `storageChangeSet.block` contains the block hash, we can use this as the `at`
          // parameter instead of polling, see #1559.
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
  /// This is needed because the aggregated account data lags behind, when then the ceremony phase is updated:
  /// See: https://github.com/encointer/encointer-wallet-flutter/issues/632
  Future<AggregatedAccountData> pollAggregatedAccountDataUntilNextPhase(
    CeremonyPhase nextPhase,
    CommunityIdentifier cid,
    String pubKey,
  ) async {
    while (true) {
      final data = await getAggregatedAccountData(cid, pubKey);
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

    _cidSubscription =
        await encointerKusama.rpc.state.subscribeStorage([cidsPhaseKey], (storageChangeSet) async {
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
  Future<List<CommunityIdentifier>> getCommunityIdentifiers() async {
    // cids in polkadart type
    final cidsPolkadart = await encointerKusama.query.encointerCommunities.communityIdentifiers();

    // transform them into our own cid
    final cids = cidsPolkadart.map(CommunityIdentifier.fromPolkadart).toList();

    Log.d('[getCommunityIdentifiers]: $cids', 'EncointerApi');
    return cids;
  }

  /// Queries the EncointerCommunities pallet: encointerCommunities.bootstrappers(cid).
  Future<void> getBootstrappers() async {
    final cid = store.encointer.chosenCid;

    if (cid == null) return;

    final bootstrappersBytes = await encointerKusama.query.encointerCommunities.bootstrappers(et.CommunityIdentifier(
      geohash: cid.geohash,
      digest: cid.digest,
    ));

    final bootstrappers =
        bootstrappersBytes.map((p) => AddressUtils.pubKeyToAddress(p, prefix: store.settings.endpoint.ss58!)).toList();

    Log.d('api: bootstrappers $bootstrappers', 'EncointerApi');
    if (store.encointer.community != null) {
      await store.encointer.community!.setBootstrappers(bootstrappers);
    }
  }

  Future<void> getReputations() async {
    final address = store.account.currentAddress;

    if (address.isEmpty) return;

    final reputations = await _dartApi.getReputations(address);

    Log.d('api: getReputations: $reputations', 'EncointerApi');
    if (reputations.isNotEmpty) await store.encointer.account?.setReputations(reputations);
  }

  /// Gets a proof of attendance for the oldest attended ceremony, if available.
  ///
  /// returns null, if none available.
  Future<ProofOfAttendance?> getProofOfAttendance(String pin) async {
    final pubKey = store.account.currentAccountPubKey;
    final cIndex = store.encointer.account?.ceremonyIndexForNextProofOfAttendance;

    if (cIndex == null || cIndex == 0) {
      return Future.value();
    }

    final cid = store.encointer.account?.reputations[cIndex]?.communityIdentifier;
    Log.d('getProofOfAttendance: cachedPin: $pin', 'EncointerApi');
    final proof = await jsApi
        .evalJavascript<Map<String, dynamic>>(
            'encointer.getProofOfAttendance("$pubKey", ${jsonEncode(cid)}, "$cIndex", "$pin")')
        .then(ProofOfAttendance.fromJson);

    Log.d('Proof: $proof', 'EncointerApi');
    return proof;
  }

  Future<int> getNumberOfNewbieTicketsForReputable() async {
    final address = store.account.currentAddress;
    final reputations = store.encointer.account?.reputations ?? {};
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
        ),
        encointerKusama.query.encointerCeremonies.endorsementTicketsPerReputable()
      ]);
      Log.p('NewbieTickets: ticketPerReputable: $ticketsPerReputable, burned: $burned');
      return ticketsPerReputable - burned;
    } catch (e, s) {
      Log.e('EncointerApi', '$e', s);
    }

    return 0;
  }

  Future<int> getNumberOfNewbieTicketsForBootstrapper() async {
    final address = store.account.currentAddress;
    final cid = store.encointer.chosenCid;
    if (cid == null) return 0;

    try {
      final [burned, ticketsPerBootstrapper] = await Future.wait([
        encointerKusama.query.encointerCeremonies.burnedBootstrapperNewbieTickets(
          et.CommunityIdentifier(geohash: cid.geohash, digest: cid.digest),
          AddressUtils.addressToPubKey(address).toList(),
        ),
        encointerKusama.query.encointerCeremonies.endorsementTicketsPerBootstrapper(),
      ]);

      Log.p('NewbieTickets: ticketsPerBootstrapper: $ticketsPerBootstrapper, burned: $burned');

      // could be negative in case the `ticketsPerBootstrapper` has been decreased over time.
      return max(ticketsPerBootstrapper - burned, 0);
    } catch (e, s) {
      Log.e('Encointer Api', '$e', s);
    }

    return 0;
  }

  Future<Map<String, Faucet>> getAllFaucetsWithAccount() async {
    try {
      // faucets: Map<String, Faucet>
      final faucets = await jsApi.evalJavascript<Map<String, dynamic>>(
        'encointer.getAllFaucetsWithAccount()',
      );
      final f = faucets.map((address, faucet) => MapEntry(address, Faucet.fromJson(faucet as Map<String, dynamic>)));
      Log.d('Encointer Api', 'all faucets2: $f');
      return f;
    } catch (e, s) {
      Log.e('Encointer Api', '$e', s);
      return Map.of({});
    }
  }

  Future<bool> hasCommittedFor(CommunityIdentifier cid, int cIndex, int purposeId, String address) async {
    try {
      final hasCommitted = await jsApi.evalJavascript<bool>(
        'encointer.hasCommittedFor(${jsonEncode(cid)}, "$cIndex", "$purposeId","$address")',
      );
      Log.d('Encointer Api', 'hasCommitted : $hasCommitted');
      return hasCommitted;
    } catch (e, s) {
      Log.e('Encointer Api', '$e', s);
      return false;
    }
  }

  /// Get all the registered businesses for the current `chosenCid`
  Future<List<AccountBusinessTuple>> getBusinesses() async {
    // set the store because the current bazaar data model reads the values from the store.
    store.encointer.bazaar?.setBusinessRegistry(allMockBusinesses);
    return allMockBusinesses;
  }

  Future<List<AccountBusinessTuple>> bazaarGetBusinesses(CommunityIdentifier cid) async {
    return _dartApi.bazaarGetBusinesses(cid);
  }

  Future<Either<Businesses, EwHttpException>> getBusinesseses(String ipfsUrlHash) async {
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
  Future<List<OfferingData>> getOfferings() async {
    // Todo: @armin you'd probably extend the encointer store and also set the store here.
    return allMockOfferings;
  }

  /// Get all the registered offerings for the business with [bid]
  Future<List<OfferingData>> getOfferingsForBusiness(BusinessIdentifier bid) async {
    // Todo: @armin you'd probably extend the encointer store and also set the store here.
    return business1MockOfferings;
  }

  Future<List<OfferingData>> bazaarGetOfferingsForBusines(CommunityIdentifier cid, String? controller) async {
    return _dartApi.bazaarGetOfferingsForBusines(cid, controller);
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
