import 'package:encointer_wallet/service/substrate_api/core/js_api.dart';
import 'package:encointer_wallet/store/app.dart';

class AssetsApi {
  AssetsApi(this.store, this.jsApi);

  final JSApi jsApi;
  final AppStore store;

  final String _balanceSubscribeChannel = 'gas token balance';

  Future<void> startSubscriptions() async {
    print('api: starting assets subscriptions');
    this.subscribeBalance();
  }

  Future<void> stopSubscriptions() async {
    print('api: stopping assets subscriptions');
    jsApi.unsubscribeMessage(_balanceSubscribeChannel);
  }

  Future<void> fetchBalance() async {
    String? pubKey = store.account.currentAccountPubKey;
    String? currentAddress = store.account.currentAddress;
    if (pubKey != null && pubKey.isNotEmpty) {
      String address = currentAddress;
      Map res = await jsApi.evalJavascript(
        'account.getBalance("$address")',
        allowRepeat: true,
      );
      store.assets.setAccountBalances(pubKey, Map.of({store.settings.networkState!.tokenSymbol: res}));
    }
    _fetchMarketPrice();
  }

  Future<void> subscribeBalance() async {
    jsApi.unsubscribeMessage(_balanceSubscribeChannel);

    String? pubKey = store.account.currentAccountPubKey;
    if (pubKey != null && pubKey.isNotEmpty) {
      String address = store.account.currentAddress;

      jsApi.subscribeMessage(
        'account.subscribeBalance("$_balanceSubscribeChannel","$address")',
        _balanceSubscribeChannel,
        (data) => {
          store.assets.setAccountBalances(pubKey, Map.of({store.settings.networkState!.tokenSymbol: data})),
        },
      );
    }
  }

  Future<void> _fetchMarketPrice() async {
    print('Fetch marketprice not implemented for Encointer networks');
  }
}
