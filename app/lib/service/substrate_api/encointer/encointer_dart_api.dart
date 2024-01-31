import 'dart:developer';

import 'package:convert/convert.dart' show hex;

import 'package:encointer_wallet/models/bazaar/account_business_tuple.dart';
import 'package:encointer_wallet/models/bazaar/offering_data.dart';
import 'package:encointer_wallet/models/communities/cid_name.dart';
import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/models/encointer_balance_data/balance_entry.dart';
import 'package:encointer_wallet/models/index.dart';
import 'package:encointer_wallet/models/location/location.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/substrate_api/core/dart_api.dart';
import 'package:ew_polkadart/ew_polkadart.dart' show BlockHash;

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
  Future<AggregatedAccountData> getAggregatedAccountData(CommunityIdentifier cid, String account, {BlockHash? at}) {
    final params = <Object>[cid.toJson(), account];

    if (at != null) params.add('0x${hex.encode(at)}');

    return _dartApi.rpc<Map<String, dynamic>>('encointer_getAggregatedAccountData', params).then(
          AggregatedAccountData.fromJson,
        );
  }

  /// Queries the rpc 'encointer_getLocations'.
  Future<List<Location>> getLocations(CommunityIdentifier cid, {BlockHash? at}) async {
    final params = <Object>[cid.toJson()];

    if (at != null) params.add('0x${hex.encode(at)}');

    final locations = await _dartApi.rpc<List<dynamic>>('encointer_getLocations', params);
    return locations.map((l) => Location.fromJson(l as Map<String, dynamic>)).toList();
  }

  /// Queries the rpc 'encointer_getReputations'.
  ///
  /// Address must be SS58 encoded.
  Future<Map<int, CommunityReputation>> getReputations(String address, {BlockHash? at}) async {
    final params = [address];

    if (at != null) params.add('0x${hex.encode(at)}');

    final reputations = await _dartApi.rpc<List<dynamic>>('encointer_getReputations', params);
    return reputationsFromList(reputations);
  }

  /// Queries the rpc 'encointer_getAllCommunities'.
  Future<List<CidName>> getAllCommunities({BlockHash? at}) async {
    final params = at != null ? ['0x${hex.encode(at)}'] : <String>[];

    final communities = await _dartApi.rpc<List<dynamic>>('encointer_getAllCommunities', params);
    return communities.map((cn) => CidName.fromJson(cn as Map<String, dynamic>)).toList();
  }

  Future<List<String>> pendingExtrinsics() {
    return _dartApi.rpc<List<dynamic>>('author_pendingExtrinsics', <dynamic>[]).then(List.from);
  }

  Future<List<AccountBusinessTuple>> bazaarGetBusinesses(CommunityIdentifier cid, {BlockHash? at}) async {
    final params = <Object>[cid.toJson()];

    if (at != null) params.add('0x${hex.encode(at)}');

    final response = await _dartApi.rpc<List<dynamic>>('encointer_bazaarGetBusinesses', params);

    if (response.isEmpty) {
      return <AccountBusinessTuple>[];
    }

    return response.map((e) => AccountBusinessTuple.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<Map<CommunityIdentifier, BalanceEntry>> getAllBalances(String account, {BlockHash? at}) {
    final params = <Object>[account];

    if (at != null) params.add('0x${hex.encode(at)}');

    return _dartApi.rpc<List<dynamic>>('encointer_getAllBalances', params).then((data) {
      return {
        for (final bal in data)
          CommunityIdentifier.fromJson((bal as List<dynamic>)[0] as Map<String, dynamic>):
              BalanceEntry.fromJson(bal[1] as Map<String, dynamic>),
      };
    });
  }

  Future<List<OfferingData>> bazaarGetOfferingsForBusiness(CommunityIdentifier cid, String? controller,
      {BlockHash? at}) async {
    final params = <Object>[
      {
        'communityIdentifier': cid.toJson(),
        'controller': controller,
      }
    ];

    if (at != null) params.add('0x${hex.encode(at)}');

    Log.d('bazaarGetOfferingsForBusiness: cid = $cid, controller = $controller', _targetLogger);
    final response = await _dartApi.rpc<List<dynamic>>('encointer_bazaarGetOfferingsForBusiness', params);

    log('$_targetLogger.bazaarGetOfferingsForBusiness ${response.runtimeType} and $response');

    if (response.isEmpty) {
      return <OfferingData>[];
    }

    return response.map((e) => OfferingData.fromJson(e as Map<String, dynamic>)).toList();
  }
}
