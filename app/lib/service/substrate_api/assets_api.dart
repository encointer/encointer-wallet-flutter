import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/substrate_api/core/js_api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/store/assets/types/balances_info.dart';

class AssetsApi {
  AssetsApi(this.store, this.jsApi);

  final JSApi jsApi;
  final AppStore store;

  final String _balanceSubscribeChannel = 'gas token balance';

  Future<void> startSubscriptions() async {
    Log.d('api: starting assets subscriptions', 'AssetsApi');
    await subscribeBalance();
  }

  Future<void> stopSubscriptions() async {
    Log.d('api: stopping assets subscriptions', 'AssetsApi');
    await jsApi.unsubscribeMessage(_balanceSubscribeChannel);
  }

  Future<void> fetchBalance() async {
    final pubKey = store.account.currentAccountPubKey;
    final currentAddress = store.account.currentAddress;
    if (pubKey != null && pubKey.isNotEmpty) {
      final address = currentAddress;
      final res = await jsApi.evalJavascript<Map<String, dynamic>>('account.getBalance("$address")');
      await store.assets.setAccountBalances(pubKey, Map.of({store.settings.networkState!.tokenSymbol: res}));
    }
    await _fetchMarketPrice();
  }

  Future<BalancesInfo> getBalance() async {
    final res =
        await jsApi.evalJavascript<Map<String, dynamic>>('account.getBalance("${store.account.currentAddress}")');
    return BalancesInfo.fromJson(res);
  }

  Future<void> subscribeBalance() async {
    await jsApi.unsubscribeMessage(_balanceSubscribeChannel);

    final pubKey = store.account.currentAccountPubKey;
    if (pubKey != null && pubKey.isNotEmpty) {
      final address = store.account.currentAddress;

      await jsApi.subscribeMessage(
        'account.subscribeBalance("$_balanceSubscribeChannel","$address")',
        _balanceSubscribeChannel,
        (Map<String, dynamic> data) async {
          await store.assets.setAccountBalances(pubKey, Map.of({store.settings.networkState!.tokenSymbol: data}));
        },
      );
    }
  }

  Future<void> _fetchMarketPrice() async {
    Log.d('Fetch marketprice not implemented for Encointer networks', 'AssetsApi');
  }
}
