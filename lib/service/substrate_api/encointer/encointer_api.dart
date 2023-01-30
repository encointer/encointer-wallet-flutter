import 'dart:convert';

import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/mocks/data/mock_bazaar_data.dart';
import 'package:encointer_wallet/models/bazaar/account_business_tuple.dart';
import 'package:encointer_wallet/models/bazaar/business_identifier.dart';
import 'package:encointer_wallet/models/bazaar/offering_data.dart';
import 'package:encointer_wallet/models/communities/cid_name.dart';
import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/models/communities/community_metadata.dart';
import 'package:encointer_wallet/models/encointer_balance_data/balance_entry.dart';
import 'package:encointer_wallet/models/index.dart';
import 'package:encointer_wallet/models/location/location.dart';
import 'package:encointer_wallet/models/proof_of_attendance/proof_of_attendance.dart';
import 'package:encointer_wallet/service/encointer_feed/feed.dart' as feed;
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/substrate_api/core/dart_api.dart';
import 'package:encointer_wallet/service/substrate_api/core/js_api.dart';
import 'package:encointer_wallet/service/substrate_api/encointer/encointer_dart_api.dart';
import 'package:encointer_wallet/service/substrate_api/encointer/no_tee_api.dart';
import 'package:encointer_wallet/service/substrate_api/encointer/tee_proxy_api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/format.dart';

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
  EncointerApi(this.store, this.jsApi, SubstrateDartApi dartApi)
      : _noTee = NoTeeApi(jsApi),
        _teeProxy = TeeProxyApi(jsApi),
        _dartApi = EncointerDartApi(dartApi);

  final JSApi jsApi;
  final EncointerDartApi _dartApi;

  final AppStore store;
  final String _currentPhaseSubscribeChannel = 'currentPhase';
  final String _communityIdentifiersChannel = 'communityIdentifiers';
  final String _encointerBalanceChannel = 'encointerBalance';
  final String _businessRegistryChannel = 'businessRegistry';

  final NoTeeApi _noTee;
  final TeeProxyApi _teeProxy;

  Future<void> startSubscriptions() async {
    Log.d('api: starting encointer subscriptions', 'EncointerApi');
    await getPhaseDurations();
    await subscribeCurrentPhase();
    await subscribeCommunityIdentifiers();
    if (store.settings.endpointIsNoTee) {
      await subscribeBusinessRegistry();
    }
  }

  Future<void> stopSubscriptions() async {
    Log.d('api: stopping encointer subscriptions', 'EncointerApi');
    jsApi
      ..unsubscribeMessage(_currentPhaseSubscribeChannel)
      ..unsubscribeMessage(_communityIdentifiersChannel)
      ..unsubscribeMessage(_businessRegistryChannel);

    if (store.settings.endpointIsNoTee) {
      await jsApi.unsubscribeMessage(_businessRegistryChannel);
    }
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
  ///
  /// This is on-chain in Cantillon.
  Future<CeremonyPhase?> getCurrentPhase() async {
    Log.d('api: getCurrentPhase', 'EncointerApi');
    final res = await jsApi.evalJavascript('encointer.getCurrentPhase()');

    final phase = ceremonyPhaseFromString(res as String)!;
    Log.d('api: Phase enum: $phase', 'EncointerApi');
    store.encointer.setCurrentPhase(phase);
    return phase;
  }

  /// Queries the Scheduler pallet: encointerScheduler.nextPhaseTimestamp().
  ///
  /// This is on-chain in Cantillon.
  Future<int> getNextPhaseTimestamp() async {
    Log.d('api: getNextPhaseTimestamp', 'EncointerApi');
    final timestamp =
        await jsApi.evalJavascript('encointer.getNextPhaseTimestamp()').then((time) => int.parse(time as String));

    Log.d('api: next phase timestamp: $timestamp', 'EncointerApi');
    store.encointer.setNextPhaseTimestamp(timestamp);
    return timestamp;
  }

  /// Queries the Scheduler pallet: encointerScheduler.currentPhase().
  ///
  /// This should be done only once at app-startup, as this is practically const.
  ///
  /// This is on-chain in Cantillon.
  Future<void> getPhaseDurations() async {
    final phaseDurations =
        await jsApi.evalJavascript('encointer.getPhaseDurations()').then((m) => Map<String, dynamic>.from(m as Map).map(
              (key, value) => MapEntry(ceremonyPhaseFromString(key)!, int.parse(value as String)),
            ));

    store.encointer.setPhaseDurations(phaseDurations);
  }

  /// Queries the rpc 'encointer_getAggregatedAccountData' with the dart api.
  ///
  Future<AggregatedAccountData> getAggregatedAccountData(CommunityIdentifier cid, String address) async {
    try {
      final accountData = await _dartApi.getAggregatedAccountData(cid, address);
      Log.d(
        '[EncointerApi]: AggregatedAccountData for ${cid.toFmtString()} and ${address.substring(0, 7)}...: $accountData'
        'EncointerApi',
      );
      return accountData;
    } catch (e) {
      throw Exception('[EncointerApi]: Error getting aggregated account data ${e.toString()}');
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
  ///
  /// This is on-chain in Cantillon.
  Future<int?> getCurrentCeremonyIndex() async {
    Log.d('api: getCurrentCeremonyIndex', 'EncointerApi');
    final cIndex =
        await jsApi.evalJavascript('encointer.getCurrentCeremonyIndex()').then((index) => int.parse(index as String));
    Log.d('api: Current Ceremony index: $cIndex', 'EncointerApi');
    store.encointer.setCurrentCeremonyIndex(cIndex);
    return cIndex;
  }

  /// Queries the Communities pallet's RPC: api.rpc.communities.getLocations(cid)
  ///
  /// This is on-chain in Cantillon
  Future<void> getAllMeetupLocations() async {
    Log.d('api: getAllMeetupLocations', 'EncointerApi');
    final cid = store.encointer.chosenCid;

    if (cid == null) {
      return;
    }

    final locs = await jsApi.evalJavascript('encointer.getAllMeetupLocations(${jsonEncode(cid)})').then((list) =>
        List<dynamic>.from(list as Iterable).map((l) => Location.fromJson(l as Map<String, dynamic>)).toList());

    Log.d('api: getAllMeetupLocations: $locs ' 'EncointerApi');
    if (store.encointer.community != null) {
      store.encointer.community!.setMeetupLocations(locs);
    }
  }

  /// Queries the Communities pallet: encointerCommunities.communityMetadata(cid)
  ///
  /// This is on-chain in Cantillon
  Future<void> getCommunityMetadata() async {
    Log.d('api: getCommunityMetadata', 'EncointerApi');
    final cid = store.encointer.chosenCid;
    if (cid == null) {
      return;
    }

    final meta = await jsApi
        .evalJavascript('encointer.getCommunityMetadata(${jsonEncode(cid)})')
        .then((m) => CommunityMetadata.fromJson(m as Map<String, dynamic>));

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
  ///
  /// This is on-chain in Cantillon
  Future<void> getDemurrage() async {
    final cid = store.encointer.chosenCid;
    if (cid == null) {
      return;
    }

    final dem = await jsApi.evalJavascript('encointer.getDemurrage(${jsonEncode(cid)})');
    Log.d('api: fetched demurrage: $dem', 'EncointerApi');
    if (store.encointer.community != null) {
      store.encointer.community!.setDemurrage(dem as double?);
    }
  }

  /// Calls the custom rpc: api.rpc.communities.communitiesGetAll()
  Future<void> communitiesGetAll() async {
    final cn = await jsApi.evalJavascript('encointer.communitiesGetAll()').then(
          (list) =>
              List<dynamic>.from(list as Iterable).map((cn) => CidName.fromJson(cn as Map<String, dynamic>)).toList(),
        );

    Log.d('api: CidNames: $cn', 'EncointerApi');
    store.encointer.setCommunities(cn);
  }

  /// Queries the Scheduler pallet: encointerScheduler./-currentPhase(), -phaseDurations(phase), -nextPhaseTimestamp().
  ///
  /// Fixme: Sometimes the PhaseAwareBox takes ages to update. This might be due to multiple network requests on JS side.
  /// We could fetch the phaseDurations at application startup, cache them and supply them in the call here.
  Future<DateTime?> getMeetupTime() async {
    Log.d('api: getMeetupTime', 'EncointerApi');

    // I we are not assigned to a meetup, we just get any location to get an estimate of the chosen community's meetup
    // times.
    final locationIndex = store.encointer.communityAccount?.meetup?.locationIndex;

    final mLocation = locationIndex != null && store.encointer.community?.meetupLocations != null
        ? store.encointer.community?.meetupLocations![locationIndex]
        : (store.encointer.community?.meetupLocations?.first);

    if (mLocation == null) {
      Log.d("No meetup locations found, can't get meetup time.", 'EncointerApi');
      return Future.value();
    }

    final time = await jsApi
        .evalJavascript('encointer.getNextMeetupTime(${jsonEncode(mLocation)})')
        .then((value) => int.parse(value as String));

    Log.d('api: Next Meetup Time: $time', 'EncointerApi');
    store.encointer.community!.setMeetupTime(time);
    return DateTime.fromMillisecondsSinceEpoch(time);
  }

  Future<void> getMeetupTimeOverride() async {
    Log.d('api: Check if there are meetup time overrides', 'EncointerApi');
    final cid = store.encointer.chosenCid;
    if (cid == null) {
      return;
    }

    try {
      final meetupTimeOverride = await feed.getMeetupTimeOverride(
        store.encointer.network,
        cid,
        store.encointer.currentPhase,
      );
      if (store.encointer.community != null) {
        store.encointer.community!.setMeetupTimeOverride(meetupTimeOverride?.millisecondsSinceEpoch);
      }
    } catch (e, s) {
      Log.e('api: exception: $e', 'EncointerApi', s);
    }
  }

  Future<bool?> hasPendingIssuance() async {
    final cid = store.encointer.chosenCid;

    final cIndex = store.encointer.currentCeremonyIndex;
    final pubKey = store.account.currentAccountPubKey;
    Log.d('api: Getting pendingIssuance for $pubKey', 'EncointerApi');

    if (pubKey == null || pubKey.isEmpty || cid == null || cIndex == null || cIndex <= 1) {
      return false;
    }

    // -1 as we get the pending issuance for the last ceremony
    var issuanceCIndex = cIndex - 1;

    if (store.encointer.currentPhase == CeremonyPhase.Attesting) {
      // If we are in the attesting phase we want to payout the current meetup
      // aka early payout directly after the key-signing gathering.
      issuanceCIndex = cIndex;
    }

    final hasPendingIssuance =
        await jsApi.evalJavascript('encointer.hasPendingIssuance(${jsonEncode(cid)}, "$issuanceCIndex","$pubKey")');

    Log.d('api:has pending issuance $hasPendingIssuance', 'EncointerApi');
    return hasPendingIssuance as bool?;
  }

  /// Queries the EncointerBalances pallet: encointer.encointerBalances.balance(cid, address).
  ///
  /// This is off-chain and trusted in Cantillon, accessible with TrustedGetter::balance(cid, accountId).
  Future<BalanceEntry> getEncointerBalance(String pubKeyOrAddress, CommunityIdentifier cid) async {
    Log.d('Getting encointer balance for $pubKeyOrAddress and ${cid.toFmtString()}', 'EncointerApi');

    final balanceEntry = store.settings.endpointIsNoTee
        ? await _noTee.balances.balance(cid, pubKeyOrAddress)
        : await _teeProxy.balances.balance(cid, pubKeyOrAddress, store.settings.cachedPin);

    Log.d('balanceEntryJson: $balanceEntry', 'EncointerApi');

    return balanceEntry;
  }

  Future<void> subscribeCurrentPhase() async {
    await jsApi.subscribeMessage(
        'encointer.subscribeCurrentPhase("$_currentPhaseSubscribeChannel")', _currentPhaseSubscribeChannel,
        (String data) async {
      final phase = ceremonyPhaseFromString(data.toUpperCase())!;

      final cid = store.encointer.chosenCid;
      final address = store.account.currentAddress;

      if (cid != null) {
        final data = await pollAggregatedAccountDataUntilNextPhase(phase, cid, address);
        store.encointer.setAggregatedAccountData(cid, address, data);
      }

      store.encointer.setCurrentPhase(phase);
      await getNextPhaseTimestamp();
    });
  }

  /// Polls the aggregated account data until its ceremony phase field equals [nextPhase].
  ///
  /// This is needed because the aggregated account data lags behind, when then the ceremony phase is updated:
  /// See: https://github.com/encointer/encointer-wallet-flutter/issues/632
  Future<AggregatedAccountData> pollAggregatedAccountDataUntilNextPhase(
    CeremonyPhase nextPhase,
    CommunityIdentifier cid,
    String address,
  ) async {
    while (true) {
      final data = await getAggregatedAccountData(cid, address);
      final phase = data.global!.ceremonyPhase;

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

  /// Subscribes to storage changes in the Scheduler pallet: encointerScheduler.currentPhase().
  ///
  /// This is on-chain in Cantillon.
  Future<void> subscribeCommunityIdentifiers() async {
    await jsApi.subscribeMessage(
        'encointer.subscribeCommunityIdentifiers("$_communityIdentifiersChannel")', _communityIdentifiersChannel,
        (Iterable<dynamic> data) async {
      final cids =
          List<dynamic>.from(data).map((cn) => CommunityIdentifier.fromJson(cn as Map<String, dynamic>)).toList();

      await store.encointer.setCommunityIdentifiers(cids);

      await communitiesGetAll();
    });
  }

  /// Subscribes to storage changes in the EncointerBalances pallet: encointerBalances.balance(cid, address).
  ///
  /// This is off-chain in Cantillon. Hence, subscriptions are not supported.
  Future<void> subscribeEncointerBalance() async {
    // unsubscribe from potentially other community updates
    Log.d('Subscribe encointer balance', 'EncointerApi');
    await jsApi.unsubscribeMessage(_encointerBalanceChannel);

    final account = store.account.currentAccountPubKey;
    final cid = store.encointer.chosenCid;
    if (cid == null) {
      return;
    }

    await jsApi.subscribeMessage(
      'encointer.subscribeBalance("$_encointerBalanceChannel", ${jsonEncode(cid)}, "$account")',
      _encointerBalanceChannel,
      (Map<String, dynamic> data) {
        final balance = BalanceEntry.fromJson(data);
        store.encointer.account?.addBalanceEntry(cid, balance);
      },
    );
  }

  Future<void> subscribeBusinessRegistry() async {
    // todo: implement subscribing
  }

  /// Queries the EncointerCurrencies pallet: encointerCurrencies.communityIdentifiers().
  ///
  /// This is on-chain in Cantillon.
  Future<List<CommunityIdentifier>> getCommunityIdentifiers() async {
    final cids = await jsApi.evalJavascript('encointer.getCommunityIdentifiers()').then(
          (res) => List<dynamic>.from(res['cids'] as Iterable)
              .map((cn) => CommunityIdentifier.fromJson(cn as Map<String, dynamic>))
              .toList(),
        );

    Log.d('CID: $cids', 'EncointerApi');
    return cids;
  }

  /// Queries the EncointerCommunities pallet: encointerCommunities.bootstrappers(cid).
  ///
  Future<void> getBootstrappers() async {
    final cid = store.encointer.chosenCid;

    if (cid == null) return;

    final bootstrappers =
        await jsApi.evalJavascript('encointer.getBootstrappers($cid)').then((bs) => List<String>.from(bs as Iterable));

    Log.d('api: bootstrappers $bootstrappers', 'EncointerApi');
    if (store.encointer.community != null) {
      await store.encointer.community!.setBootstrappers(bootstrappers);
    }
  }

  Future<void> getReputations() async {
    final address = store.account.currentAddress;

    final reputationsList = await jsApi.evalJavascript('encointer.getReputations("$address")');

    Log.d('api: getReputations: $reputationsList', 'EncointerApi');
    if (reputationsList is List && reputationsList.isEmpty) {
      return Future.value();
    }

    final reputations = {
      for (var cr in reputationsList as List) cr[0] as int: CommunityReputation.fromJson(cr[1] as Map<String, dynamic>)
    };

    await store.encointer.account?.setReputations(reputations);
  }

  Future<dynamic> sendFaucetTx() async {
    final address = store.account.currentAddress;
    final amount = Fmt.tokenInt(faucetAmount.toString(), ertDecimals);
    final res = await jsApi.evalJavascript('account.sendFaucetTx("$address", "$amount")');
    // Log.d("Faucet Result : $res", 'EncointerApi');
    return res;
  }

  /// Gets a proof of attendance for the oldest attended ceremony, if available.
  ///
  /// returns null, if none available.
  Future<ProofOfAttendance?> getProofOfAttendance() async {
    final pubKey = store.account.currentAccountPubKey;
    final cIndex = store.encointer.account?.ceremonyIndexForProofOfAttendance;

    if (cIndex == null || cIndex == 0) {
      return Future.value();
    }

    final cid = store.encointer.account?.reputations[cIndex]?.communityIdentifier;
    final pin = store.settings.cachedPin;
    Log.d('getProofOfAttendance: cachedPin: $pin', 'EncointerApi');
    final proofJs =
        await jsApi.evalJavascript('encointer.getProofOfAttendance("$pubKey", ${jsonEncode(cid)}, "$cIndex", "$pin")');
    final proof = ProofOfAttendance.fromJson(proofJs as Map<String, dynamic>);
    Log.d('Proof: $proof', 'EncointerApi');
    return proof;
  }

  Future<int> getNumberOfNewbieTicketsForReputable() async {
    var remainingTickets = 0;
    final address = store.account.currentAddress;
    final reputations = store.encointer.account?.reputations;
    final cid = store.encointer.chosenCid;
    final cIndex = store.encointer.currentCeremonyIndex;

    if ((reputations?.length ?? 0) > 0) {
      try {
        remainingTickets = await jsApi.evalJavascript(
          'encointer.remainingNewbieTicketsReputable(${jsonEncode(cid)}, "$cIndex","$address")',
        ) as int;

        Log.d('EncointerApi', 'numberOfNewbieTickets: $remainingTickets');
      } catch (e, s) {
        Log.e('EncointerApi', '$e', s);
      }
    }

    return remainingTickets;
  }

  Future<int> getNumberOfNewbieTicketsForBootstrapper() async {
    var remainingTickets = 0;
    final address = store.account.currentAddress;
    final cid = store.encointer.chosenCid;
    try {
      final numberOfTickets = await jsApi.evalJavascript(
        'encointer.remainingNewbieTicketsBootstrapper(${jsonEncode(cid)},"$address")',
      );
      Log.d('Encointer Api', 'numberOfBootstrapperTickets: $numberOfTickets');
      remainingTickets += numberOfTickets as int;
    } catch (e, s) {
      Log.e('Encointer Api', '$e', s);
    }
    return remainingTickets;
  }

  /// Get all the registered businesses for the current `chosenCid`
  Future<List<AccountBusinessTuple>> getBusinesses() async {
    // set the store because the current bazaar data model reads the values from the store.
    store.encointer.bazaar?.setBusinessRegistry(allMockBusinesses);
    return allMockBusinesses;
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
}
