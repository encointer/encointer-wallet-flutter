import 'package:encointer_wallet/mocks/mock_bazaar_data.dart';
import 'package:encointer_wallet/models/bazaar/account_business_tuple.dart';
import 'package:encointer_wallet/models/bazaar/businesses.dart';
import 'package:encointer_wallet/models/bazaar/ipfs_product.dart';
import 'package:encointer_wallet/models/bazaar/item_offered.dart';
import 'package:encointer_wallet/models/bazaar/offering_data.dart';
import 'package:encointer_wallet/models/ceremonies/ceremonies.dart';
import 'package:encointer_wallet/models/communities/cid_name.dart';
import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/models/encointer_balance_data/balance_entry.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/substrate_api/encointer/encointer_api.dart';
import 'package:ew_http/ew_http.dart';

import '../data/mock_encointer_data.dart';
import 'mock_js_api.dart';
import 'mock_substrate_dart_api.dart';

/// The key rationale behind this mock is that all the getters do not alter the app state.
///
/// This allows to configure the app storage for specific tests via the `PrepareStorage` class.
/// The getters then return the preconfigured value, which in turn leads to consistent
/// responses in the test.
class MockEncointerApi extends EncointerApi {
  MockEncointerApi(
    super.store,
    MockJSApi super.js,
    MockSubstrateDartApi super.dartApi,
    super.ewHttp,
    super.encointerKusama,
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
  Future<CeremonyPhase?> getCurrentPhase() async {
    // ignore: unnecessary_null_comparison
    if (store.encointer.currentPhase == null) {
      store.encointer.setCurrentPhase(initialPhase);
    }

    return store.encointer.currentPhase;
  }

  @override
  Future<int?> getCurrentCeremonyIndex() async {
    if (store.encointer.currentCeremonyIndex == null) {
      store.encointer.setCurrentCeremonyIndex(1);
    }
    return store.encointer.currentCeremonyIndex;
  }

  @override
  Future<AggregatedAccountData> getAggregatedAccountData(CommunityIdentifier cid, String pubKey) {
    // ignore: null_argument_to_non_null_type
    return Future.value();
  }

  @override
  Future<void> getReputations() async {}

  @override
  Future<BalanceEntry> getEncointerBalance(String pubKeyOrAddress, CommunityIdentifier cid, String pin) async {
    return BalanceEntry.fromJson(testBalanceEntry);
  }

  @override
  Future<void> getAllMeetupLocations() async {}

  @override
  Future<List<CommunityIdentifier>> getCommunityIdentifiers() async {
    return testCommunityIdentifiers;
  }

  @override
  Future<List<CidName>?> communitiesGetAll() async {
    return store.encointer.communities;
  }

  @override
  Future<bool> hasPendingIssuance() async {
    return true;
  }

  @override
  Future<void> getDemurrage() async {}

  @override
  Future<List<AccountBusinessTuple>> getBusinesses() async {
    Log.d('warn: getBusinessRegistry mock is unimplemented', 'MockEncointerApi');
    return Future.value([]);
  }

  @override
  Future<void> getCommunityMetadata() {
    return Future.value();
  }

  @override
  Future<void> getCommunityData() {
    return Future.value();
  }

  @override
  Future<DateTime?> getMeetupTime() async {
    return DateTime.fromMillisecondsSinceEpoch(testTimeStamp);
  }

  @override
  Future<Map<CommunityIdentifier, BalanceEntry>> getAllBalances(String account) async {
    return Future.value(Map<CommunityIdentifier, BalanceEntry>.of({
      store.encointer.chosenCid!: BalanceEntry.fromJson(testBalanceEntry),
    }));
  }

  @override
  Future<void> getBootstrappers() {
    return Future.value();
  }

  @override
  Future<List<String>> pendingExtrinsics() {
    Log.d('calling mock `pendingExtrinsics', 'MockEncointerApi');
    return Future.value([]);
  }

  @override
  Future<int> getNumberOfNewbieTicketsForBootstrapper() {
    return Future.value(0);
  }

  @override
  Future<int> getNumberOfNewbieTicketsForReputable() {
    return Future.value(0);
  }

  @override
  Future<List<AccountBusinessTuple>> bazaarGetBusinesses(CommunityIdentifier cid) async {
    return Future.value(allMockBusinesses);
  }

  @override
  Future<Either<Businesses, EwHttpException>> getBusinesseses(String ipfsUrlHash) async {
    Either<Businesses, EwHttpException> getRight() => Right(Businesses.fromJson(mockBusinessData));
    return Future.value(getRight());
  }

  @override
  Future<List<OfferingData>> bazaarGetOfferingsForBusines(CommunityIdentifier cid, String? controller) async {
    return Future.value(offeringDataMockList);
  }

  @override
  Future<Either<ItemOffered, EwHttpException>> getItemOffered(String ipfsUrlHash) async {
    Either<ItemOffered, EwHttpException> getRight() => Right(ItemOffered.fromJson(itemOfferedMock));
    return Future.value(getRight());
  }

  @override
  Future<Either<IpfsProduct, EwHttpException>> getSingleBusinessProduct(String ipfsUrlHash) async {
    Either<IpfsProduct, EwHttpException> getRight() => Right(IpfsProduct.fromJson(ipfsProductMock));
    return Future.value(getRight());
  }
}
