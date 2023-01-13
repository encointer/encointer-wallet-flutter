import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/substrate_api/core/js_api.dart';
// import 'package:encointer_wallet/store/app.dart';

class AssetsApi {
  AssetsApi(this.jsApi);

  final JSApi jsApi;
  // final AppStore store;

  final String _balanceSubscribeChannel = 'gas token balance';

  Future<void> startSubscriptions(
    String? pubKey,
    String currentAddress,
    Future<void> Function(String? pubKey, Map<String, dynamic> data, {bool? needCache, bool? fromCache}) callback,
  ) async {
    Log.d('api: starting assets subscriptions', 'AssetsApi');
    jsApi.unsubscribeMessage(_balanceSubscribeChannel);

    // final pubKey = store.account.currentAccountPubKey;
    if (pubKey != null && pubKey.isNotEmpty) {
      // final address = store.account.currentAddress;

      jsApi.subscribeMessage(
        'account.subscribeBalance("$_balanceSubscribeChannel","$currentAddress")',
        _balanceSubscribeChannel,
        (dynamic data) {
          callback(pubKey, data as Map<String, dynamic>);
          // store.assets.setAccountBalances(pubKey, Map.of({store.settings.networkState!.tokenSymbol: data}));
        },
      );
    }
    // subscribeBalance();
  }

  Future<void> stopSubscriptions() async {
    Log.d('api: stopping assets subscriptions', 'AssetsApi');
    jsApi.unsubscribeMessage(_balanceSubscribeChannel);
  }

  Future<void> fetchBalance(
    String? pubKey,
    String currentAddress,
    Future<void> Function(String? pubKey, Map<String, dynamic> data, {bool? needCache, bool? fromCache}) callback,
  ) async {
    // final pubKey = store.account.currentAccountPubKey;
    // final currentAddress = store.account.currentAddress;
    if (pubKey != null && pubKey.isNotEmpty) {
      final address = currentAddress;
      final res = await jsApi.evalJavascript('account.getBalance("$address")');
      callback(pubKey, res as Map<String, dynamic>);
      // return res as Map<String, dynamic>;
      // store.assets.setAccountBalances(pubKey, Map.of({store.settings.networkState!.tokenSymbol: res as Map}));
    }
    Log.d('Fetch marketprice not implemented for Encointer networks', 'AssetsApi');
  }

  // Future<void> subscribeBalance(
  //   Future<void> Function(String? pubKey, Map<dynamic, dynamic> data, {bool? needCache}) callback,
  // ) async {
  //   jsApi.unsubscribeMessage(_balanceSubscribeChannel);

  //   final pubKey = store.account.currentAccountPubKey;
  //   if (pubKey != null && pubKey.isNotEmpty) {
  //     final address = store.account.currentAddress;

  //     jsApi.subscribeMessage(
  //       'account.subscribeBalance("$_balanceSubscribeChannel","$address")',
  //       _balanceSubscribeChannel,
  //       (dynamic data) {
  //         callback(pubKey, data as Map<String, dynamic>);
  //         // store.assets.setAccountBalances(pubKey, Map.of({store.settings.networkState!.tokenSymbol: data}));
  //       },
  //     );
  //   }
  // }

  // Future<void> _fetchMarketPrice() async {
  //   Log.d('Fetch marketprice not implemented for Encointer networks', 'AssetsApi');
  // }
}
