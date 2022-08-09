import 'package:encointer_wallet/models/index.dart';
import 'package:encointer_wallet/service/substrate_api/core/dart_api.dart';
import '../../../models/communities/community_identifier.dart';
import '../../../models/encointer_balance_data/balance_entry.dart';

class EncointerDartApi {
  EncointerDartApi(this._dartApi);

  SubstrateDartApi _dartApi;

  Future<void> close() async {
    print("[EncointerDartApi: closing");
    return _dartApi.close();
  }

  /// Queries the rpc 'encointer_getAggregatedAccountData'.
  ///
  Future<AggregatedAccountData> getAggregatedAccountData(
      CommunityIdentifier cid, String account) {
    return _dartApi.rpc("encointer_getAggregatedAccountData", [
      cid.toJson(),
      account
    ]).then((data) => AggregatedAccountData.fromJson(data));
  }

  ///
  Future<List<String>> pendingExtrinsics() {
    return _dartApi
        .rpc("author_pendingExtrinsics", []).then((data) => List.from(data));
  }

  Future<Map<CommunityIdentifier, BalanceEntry>> getAllBalances(
      String account) {
    return _dartApi.rpc("encointer_getAllBalances", [account]).then((data) {
      return Map.fromIterable(data,
          key: (bal) => CommunityIdentifier.fromJson(bal[0]),
          value: (bal) => BalanceEntry.fromJson(bal[1]));
    });
  }
}
