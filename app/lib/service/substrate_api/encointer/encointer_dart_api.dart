import 'package:encointer_wallet/models/bazaar/account_business_tuple.dart';
import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/models/encointer_balance_data/balance_entry.dart';
import 'package:encointer_wallet/models/index.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/substrate_api/core/dart_api.dart';

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

  ///
  Future<List<String>> pendingExtrinsics() {
    return _dartApi.rpc<List<dynamic>>('author_pendingExtrinsics', <dynamic>[]).then(List.from);
  }

  Future<List<dynamic>> bazaarGetBusinesses(CommunityIdentifier cid) {
    return _dartApi.rpc<List<dynamic>>('encointer_bazaarGetBusinesses', [cid.toJson()]);
  }

  Future<Map<CommunityIdentifier, BalanceEntry>> getAllBalances(String account) {
    return _dartApi.rpc<List<dynamic>>('encointer_getAllBalances', [account]).then((data) {
      return {
        for (var bal in data)
          CommunityIdentifier.fromJson((bal as List<dynamic>)[0] as Map<String, dynamic>):
              BalanceEntry.fromJson(bal[1] as Map<String, dynamic>),
      };
    });
  }
}
