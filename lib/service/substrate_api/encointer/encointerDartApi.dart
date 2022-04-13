import 'package:encointer_wallet/models/index.dart';
import 'package:encointer_wallet/service/substrate_api/core/dartApi.dart';
import 'package:encointer_wallet/store/encointer/types/communities.dart';

class EncointerDartApi {
  EncointerDartApi(this._dartApi);

  SubstrateDartApi _dartApi;

  /// Queries the rpc 'ceremonies_getAggregatedAccountData'.
  ///
  Future<AggregatedAccountData> getAggregatedAccountData(CommunityIdentifier cid, String account) {
    return _dartApi
        .rpc(aggregatedAccountDataRpc, [cid.toJson(), account]).then((data) => AggregatedAccountData.fromJson(data));
  }
}
