import 'package:encointer_wallet/mocks/data/mockAccountData.dart';
import 'package:encointer_wallet/service/substrate_api/assetsApi.dart';
import 'package:encointer_wallet/store/app.dart';

import 'mockJSApi.dart';

class MockAssetsApi extends AssetsApi {
  MockAssetsApi(AppStore store, MockJSApi js)
      : _store = store,
        super(store, js);

  // final store = globalAppStore;
  final AppStore _store;

  @override
  Future<void> startSubscriptions() async {
    print("api: unimplemented startSubscription stub");
  }

  @override
  Future<void> stopSubscriptions() async {
    print("api: unimplemented stopSubscriptions stub");
  }

  @override
  Future<void> subscribeBalance() async {
    print("api: unimplemented subscribeBalance stub");
  }

  @override
  Future<void> fetchBalance() async {
    print('api: fetching mock balance');
    _store.assets.setAccountBalances(
      _store.account.currentAccountPubKey,
      Map.of({_store.settings.networkState!.tokenSymbol: balancesInfo}),
      needCache: false,
    );
  }
}
