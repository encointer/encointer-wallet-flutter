import 'package:encointer_wallet/models/index.dart';
import 'package:encointer_wallet/service/substrate_api/core/dartApi.dart';
import 'package:encointer_wallet/store/encointer/types/communities.dart';

class EncointerDartApi {
  EncointerDartApi(this._dartApi);

  SubstrateDartApi _dartApi;

  /// Queries the rpc 'encointer_getAggregatedAccountData'.
  ///
  Future<AggregatedAccountData> getAggregatedAccountData(CommunityIdentifier cid, String account) {
    return _dartApi.rpc("encointer_getAggregatedAccountData", [cid.toJson(), account]).then(
        (data) => AggregatedAccountData.fromJson(data));
  }

  ///
  Future<List<dynamic>> pendingExtrinsics() {
    return _dartApi.rpc("author_pendingExtrinsics", []).then((data) => List.from(data));
  }
}
