import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/substrate_api/core/js_api.dart';

class AssetsApi {
  const AssetsApi(this.jsApi);

  final JSApi jsApi;

  static const String _balanceSubscribeChannel = 'gas token balance';

  Future<void> startSubscriptions(
    String? pubKey,
    String currentAddress,
    Future<void> Function(String? pubKey, Map<String, dynamic> data, {bool? needCache, bool? fromCache}) callback,
  ) async {
    Log.d('api: starting assets subscriptions', 'AssetsApi');
    jsApi.unsubscribeMessage(_balanceSubscribeChannel);

    if (pubKey != null && pubKey.isNotEmpty) {
      jsApi.subscribeMessage(
          'account.subscribeBalance("$_balanceSubscribeChannel","$currentAddress")', _balanceSubscribeChannel,
          (dynamic data) {
        callback(pubKey, data as Map<String, dynamic>);
      });
    }
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
    if (pubKey != null && pubKey.isNotEmpty) {
      final address = currentAddress;
      final res = await jsApi.evalJavascript('account.getBalance("$address")');
      callback(pubKey, res as Map<String, dynamic>);
    }
    Log.d('Fetch marketprice not implemented for Encointer networks', 'AssetsApi');
  }
}
