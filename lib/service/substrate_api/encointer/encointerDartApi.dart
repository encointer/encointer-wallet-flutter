import 'package:encointer_wallet/models/index.dart';
import 'package:encointer_wallet/service/substrate_api/core/dartApi.dart';

class EncointerDartApi {
  EncointerDartApi(this._dartApi);

  SubstrateDartApi _dartApi;

  /// Queries the rpc 'ceremonies_getAggregatedAccountData'.
  ///
  Future<AggregatedAccountData> getAggregatedAccountData(String account) {
    return _dartApi.rpc(aggregatedAccountDataRpc, [account]).then((data) => AggregatedAccountData.fromJson(data));
  }
}
