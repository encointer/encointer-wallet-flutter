import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/models/encointer_balance_data/balance_entry.dart';
import 'package:encointer_wallet/models/index.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/substrate_api/core/dart_api.dart';

class EncointerDartApi {
  EncointerDartApi(this._dartApi);

  final SubstrateDartApi _dartApi;

  Future<void> close() async {
    Log.d('[EncointerDartApi: closing', 'EncointerDartApi');
    return _dartApi.close();
  }

  /// Queries the rpc 'encointer_getAggregatedAccountData'.
  ///
  Future<AggregatedAccountData> getAggregatedAccountData(CommunityIdentifier cid, String account) {
    return _dartApi.rpc('encointer_getAggregatedAccountData', [cid.toJson(), account]).then(
      (data) => AggregatedAccountData.fromJson(data as Map<String, dynamic>),
    );
  }

  ///
  Future<List<String>> pendingExtrinsics() {
    return _dartApi.rpc('author_pendingExtrinsics', <dynamic>[]).then((data) => List.from(data as Iterable));
  }

  Future<Map<CommunityIdentifier, BalanceEntry>> getAllBalances(String account) {
    return _dartApi.rpc('encointer_getAllBalances', [account]).then((data) {
      return {
        if (data is List<Map<String, dynamic>> && data.isNotEmpty)
          for (var bal in data)
            CommunityIdentifier.fromJson(bal[0] as Map<String, dynamic>):
                BalanceEntry.fromJson(bal[1] as Map<String, dynamic>),
      };
    });
  }
}
