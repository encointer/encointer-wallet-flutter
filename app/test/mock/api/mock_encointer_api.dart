import 'package:encointer_wallet/mocks/mock_bazaar_data.dart';
import 'package:encointer_wallet/models/bazaar/account_business_tuple.dart';
import 'package:encointer_wallet/models/bazaar/offering_data.dart';
import 'package:encointer_wallet/models/ceremonies/ceremonies.dart';
import 'package:encointer_wallet/models/communities/cid_name.dart';
import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/models/encointer_balance_data/balance_entry.dart';
import 'package:ew_log/ew_log.dart';
import 'package:encointer_wallet/service/substrate_api/encointer/encointer_api.dart';
import 'package:ew_polkadart/ew_polkadart.dart' show BlockHash;
import 'package:ew_polkadart/encointer_types.dart' as et;
import 'package:ew_polkadart/generated/encointer_kusama/types/sp_core/crypto/account_id32.dart';

import '../data/mock_encointer_data.dart';
import 'mock_substrate_dart_api.dart';
import 'mock_encointer_kusama_api.dart';

/// The key rationale behind this mock is that all the getters do not alter the app state.
///
/// This allows to configure the app storage for specific tests via the `PrepareStorage` class.
/// The getters then return the preconfigured value, which in turn leads to consistent
/// responses in the test.
class MockEncointerApi extends EncointerApi {
  MockEncointerApi(
    super.store,
    MockSubstrateDartApi super.dartApi,
    super.ewHttp,
    MockEncointerKusamaApi super.encointerKusama,
  );

  @override
  Future<void> startSubscriptions() async {
    Log.d('empty startSubscriptions stub', 'MockEncointerApi');
  }

  @override
  Future<void> stopSubscriptions() async {
    Log.d('empty stopSubscriptions stub', 'MockEncointerApi');
  }

  @override
  Future<void> subscribeBusinessRegistry() async {
    Log.d('empty subscribeBusinessRegistry stub', 'MockEncointerApi');
  }

  @override
  Future<CeremonyPhase?> getCurrentPhase({BlockHash? at}) async {
    // ignore: unnecessary_null_comparison
    if (store.encointer.currentPhase == null) {
      store.encointer.setCurrentPhase(initialPhase);
    }

    return store.encointer.currentPhase;
  }

  @override
  Future<int?> getCurrentCeremonyIndex({BlockHash? at}) async {
    if (store.encointer.currentCeremonyIndex == null) {
      store.encointer.setCurrentCeremonyIndex(1);
    }
    return store.encointer.currentCeremonyIndex;
  }

  @override
  Future<AggregatedAccountData> getAggregatedAccountData(CommunityIdentifier cid, String pubKey, {BlockHash? at}) {
    // ignore: null_argument_to_non_null_type
    return Future.value();
  }

  @override
  Future<Map<int, CommunityReputation>> getReputations({BlockHash? at}) async {
    return Future.value({});
  }

  @override
  Future<BalanceEntry> getEncointerBalance(String pubKeyOrAddress, CommunityIdentifier cid, {BlockHash? at}) async {
    return BalanceEntry.fromJson(testBalanceEntry);
  }

  @override
  Future<void> getAllMeetupLocations({BlockHash? at}) async {}

  @override
  Future<List<CommunityIdentifier>> getCommunityIdentifiers({BlockHash? at}) async {
    return testCommunityIdentifiers;
  }

  @override
  Future<List<CidName>?> communitiesGetAll({BlockHash? at}) async {
    return store.encointer.communities;
  }

  @override
  Future<bool> hasPendingIssuance({BlockHash? at}) async {
    return true;
  }

  @override
  Future<void> getDemurrage({BlockHash? at}) async {}

  @override
  Future<void> getCommunityMetadata({BlockHash? at}) {
    return Future.value();
  }

  @override
  Future<void> getCommunityData() {
    return Future.value();
  }

  @override
  Future<DateTime?> getMeetupTime({BlockHash? at}) async {
    return DateTime.fromMillisecondsSinceEpoch(testTimeStamp);
  }

  @override
  Future<Map<CommunityIdentifier, BalanceEntry>> getAllBalances(String account, {BlockHash? at}) async {
    return Future.value(Map<CommunityIdentifier, BalanceEntry>.of({
      store.encointer.chosenCid!: BalanceEntry.fromJson(testBalanceEntry),
    }));
  }

  @override
  Future<void> getBootstrappers({BlockHash? at}) {
    return Future.value();
  }

  @override
  Future<List<String>> pendingExtrinsics() {
    Log.d('calling mock `pendingExtrinsics', 'MockEncointerApi');
    return Future.value([]);
  }

  @override
  Future<int> getNumberOfNewbieTicketsForBootstrapper({BlockHash? at}) {
    return Future.value(0);
  }

  @override
  Future<int> getNumberOfNewbieTicketsForReputable({BlockHash? at}) {
    return Future.value(0);
  }

  @override
  Future<List<et.ProxyDefinition>> getProxyAccounts(AccountId32 accountId, {BlockHash? at}) async {
    return [];
  }

  @override
  Future<List<AccountBusinessTuple>> bazaarGetBusinesses(CommunityIdentifier cid, {BlockHash? at}) async {
    return Future.value(allMockBusinesses);
  }

  @override
  Future<List<OfferingData>> bazaarGetOfferingsForBusiness(CommunityIdentifier cid, String? controller,
      {BlockHash? at}) async {
    return Future.value(offeringDataMockList);
  }
}
