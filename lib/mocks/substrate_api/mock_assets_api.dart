// import 'package:encointer_wallet/mocks/data/mock_account_data.dart';
import 'package:encointer_wallet/mocks/substrate_api/mock_js_api.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/substrate_api/assets_api.dart';

class MockAssetsApi extends AssetsApi {
  MockAssetsApi(MockJSApi super.js);

  @override
  Future<void> startSubscriptions(
    String? pubKey,
    String currentAddress,
    Future<void> Function(String? pubKey, Map<String, dynamic> data, {bool? needCache, bool? fromCache}) callback,
  ) async {
    Log.d('api: unimplemented startSubscription stub', 'MockAssetsApi');
  }

  @override
  Future<void> stopSubscriptions() async {
    Log.d('api: unimplemented stopSubscriptions stub', 'MockAssetsApi');
  }

  // @override
  // Future<void> subscribeBalance() async {
  //   Log.d('api: unimplemented subscribeBalance stub', 'MockAssetsApi');
  // }

  @override
  Future<void> fetchBalance(
    String? pubKey,
    String currentAddress,
    Future<void> Function(String? pubKey, Map<String, dynamic> data, {bool? needCache, bool? fromCache}) callback,
  ) async {
    Log.d('api: fetching mock balance', 'MockAssetsApi');
    // store.assets.setAccountBalances(
    //   store.account.currentAccountPubKey,
    //   Map.of({store.settings.networkState!.tokenSymbol: balancesInfo}),
    //   needCache: false,
    // );
  }
}
