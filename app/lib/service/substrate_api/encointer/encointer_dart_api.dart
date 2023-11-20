import 'dart:developer';

import 'package:encointer_wallet/models/bazaar/account_business_tuple.dart';
import 'package:encointer_wallet/models/bazaar/offering_data.dart';
import 'package:encointer_wallet/models/communities/cid_name.dart';
import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/models/encointer_balance_data/balance_entry.dart';
import 'package:encointer_wallet/models/index.dart';
import 'package:encointer_wallet/models/location/location.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/substrate_api/core/dart_api.dart';

const _targetLogger = 'EncointerDartApi';

class EncointerDartApi {
  const EncointerDartApi(this._dartApi);

  final SubstrateDartApi _dartApi;

  Future<void> close() async {
    Log.d('[EncointerDartApi: closing', 'EncointerDartApi');
    return _dartApi.close();
  }

  /// Queries the rpc 'encointer_getAggregatedAccountData'.
  ///
  Future<AggregatedAccountData> getAggregatedAccountData(CommunityIdentifier cid, String account) {
    return _dartApi.rpc<Map<String, dynamic>>('encointer_getAggregatedAccountData', [cid.toJson(), account]).then(
      AggregatedAccountData.fromJson,
    );
  }

  /// Queries the rpc 'encointer_getLocations'.
  Future<List<Location>> getLocations(CommunityIdentifier cid) async {
    final locations = await _dartApi.rpc<List<dynamic>>('encointer_getLocations', [cid.toJson()]);
    return locations.map((l) => Location.fromJson(l as Map<String, dynamic>)).toList();
  }

  /// Queries the rpc 'encointer_getReputations'.
  ///
  /// Address needs to be SS58 encoded.
  Future<Map<int, CommunityReputation>> getReputations(String address) async {
    final reputations = await _dartApi.rpc<List<dynamic>>('encointer_getReputations', [address]);
    return reputationsFromList(reputations);
  }

  /// Queries the rpc 'encointer_getReputations'.
  ///
  /// Address needs to be SS58 encoded.
  Future<List<CidName>> getAllCommunities() async {
    final communities = await _dartApi.rpc<List<dynamic>>('encointer_getAllCommunities');
    return communities.map((cn) => CidName.fromJson(cn as Map<String, dynamic>)).toList();
  }

  Future<List<String>> pendingExtrinsics() {
    return _dartApi.rpc<List<dynamic>>('author_pendingExtrinsics', <dynamic>[]).then(List.from);
  }

  Future<List<AccountBusinessTuple>> bazaarGetBusinesses(CommunityIdentifier cid) async {
    final response = await _dartApi.rpc<List<dynamic>>('encointer_bazaarGetBusinesses', [cid.toJson()]);

    if (response.isEmpty) {
      return <AccountBusinessTuple>[];
    }

    return response.map((e) => AccountBusinessTuple.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<Map<CommunityIdentifier, BalanceEntry>> getAllBalances(String account) {
    return _dartApi.rpc<List<dynamic>>('encointer_getAllBalances', [account]).then((data) {
      return {
        for (final bal in data)
          CommunityIdentifier.fromJson((bal as List<dynamic>)[0] as Map<String, dynamic>):
              BalanceEntry.fromJson(bal[1] as Map<String, dynamic>),
      };
    });
  }

  Future<List<OfferingData>> bazaarGetOfferingsForBusines(CommunityIdentifier cid, String? controller) async {
    Log.d('bazaarGetOfferingsForBusines: cid = $cid, controller = $controller', _targetLogger);
    final response = await _dartApi.rpc<List<dynamic>>('encointer_bazaarGetOfferingsForBusiness', [
      {
        'communityIdentifier': cid.toJson(),
        'controller': controller,
      }
    ]);

    log('$_targetLogger.bazaarGetOfferingsForBusines ${response.runtimeType} and $response');

    if (response.isEmpty) {
      return <OfferingData>[];
    }

    return response.map((e) => OfferingData.fromJson(e as Map<String, dynamic>)).toList();
  }
}
