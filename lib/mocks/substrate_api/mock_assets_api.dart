import 'package:encointer_wallet/mocks/data/mock_account_data.dart';
import 'package:encointer_wallet/mocks/substrate_api/mock_js_api.dart';
import 'package:encointer_wallet/service/substrate_api/assets_api.dart';
import 'package:encointer_wallet/store/app.dart';

class MockAssetsApi extends AssetsApi {
  MockAssetsApi(this.store, MockJSApi js) : super(store, js);

  final AppStore store;

  @override
  Future<void> startSubscriptions() async {
    print('api: unimplemented startSubscription stub');
  }

  @override
  Future<void> stopSubscriptions() async {
    print('api: unimplemented stopSubscriptions stub');
  }

  @override
  Future<void> subscribeBalance() async {
    print('api: unimplemented subscribeBalance stub');
  }

  @override
  Future<void> fetchBalance() async {
    print('api: fetching mock balance');
    store.assets.setAccountBalances(
        store.account.currentAccountPubKey, Map.of({store.settings.networkState!.tokenSymbol: balancesInfo}),
        needCache: false);
  }
}
