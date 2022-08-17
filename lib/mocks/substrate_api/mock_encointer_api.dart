import 'package:encointer_wallet/mocks/data/mock_encointer_data.dart';
import 'package:encointer_wallet/service/substrate_api/encointer/encointer_api.dart';

import '../../models/bazaar/account_business_tuple.dart';
import '../../models/claim_of_attendance/claim_of_attendance.dart';
import '../../models/communities/cid_name.dart';
import '../../models/communities/community_identifier.dart';
import '../../models/encointer_balance_data/balance_entry.dart';
import '../../models/index.dart';
import '../../store/app.dart';
import 'core/mock_dart_api.dart';
import 'mock_js_api.dart';

/// The key rationale behind this mock is that all the getters do not alter the app state.
///
/// This allows to configure the app storage for specific tests via the `PrepareStorage` class.
/// The getters then return the preconfigured value, which in turn leads to consistent
/// responses in the test.
class MockEncointerApi extends EncointerApi {
  MockEncointerApi(AppStore store, MockJSApi js, MockSubstrateDartApi dartApi) : super(store, js, dartApi);

  void _log(String msg) {
    print("[mockApiEncointer] $msg");
  }

  @override
  Future<void> startSubscriptions() async {
    _log("empty startSubscriptions stub");
  }

  @override
  Future<void> stopSubscriptions() async {
    _log("empty stopSubscriptions stub");
  }

  @override
  Future<void> subscribeBusinessRegistry() async {
    _log("empty subscribeBusinessRegistry stub");
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
  Future<AggregatedAccountData> getAggregatedAccountData(CommunityIdentifier cid, String account) {
    // ignore: null_argument_to_non_null_type
    return Future.value();
  }

  @override
  Future<void> getReputations() async {}

  @override
  Future<BalanceEntry> getEncointerBalance(String address, CommunityIdentifier cid) async {
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
    _log("warn: getBusinessRegistry mock is unimplemented");

    return Future.value([]);
  }

  @override
  Future<void> getCommunityMetadata() {
    return Future.value(null);
  }

  @override
  Future<void> getCommunityData() {
    return Future.value(null);
  }

  @override
  Future<DateTime?> getMeetupTime() async {
    return DateTime.fromMillisecondsSinceEpoch(claim['timestamp']);
  }

  @override
  Future<Map<CommunityIdentifier, BalanceEntry>> getAllBalances(String account) async {
    return Future.value(Map<CommunityIdentifier, BalanceEntry>.of({
      store.encointer.chosenCid!: BalanceEntry.fromJson(testBalanceEntry),
    }));
  }

  @override
  Future<ClaimOfAttendance> signClaimOfAttendance(int participants, String password) async {
    Meetup meetup = store.encointer.communityAccount!.meetup!;

    var claim = ClaimOfAttendance(
      store.account.currentAccountPubKey,
      store.encointer.currentCeremonyIndex,
      store.encointer.chosenCid,
      meetup.index,
      store.encointer.community!.meetupLocations![meetup.locationIndex],
      meetup.time,
      participants,
    );

    // skip signing for mocks.
    return Future.value(claim);
  }

  @override
  Future<void> getBootstrappers() {
    return Future.value(null);
  }

  @override
  Future<List<String>> pendingExtrinsics() {
    _log("calling mock `pendingExtrinsics");
    return Future.value([]);
  }
}
