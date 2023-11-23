import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/substrate_api/core/js_api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/store/chain/types/header.dart';

class ChainApi {
  ChainApi(this.store, this.jsApi);

  final JSApi jsApi;
  final AppStore store;

  final String _newHeadsSubscribeChannel = 'latestHeader';

  Future<void> startSubscriptions() async {
    Log.d('api: starting encointer subscriptions', 'ChainApi');
    await subscribeNewHeads();
  }

  Future<void> stopSubscriptions() async {
    Log.d('api: stopping encointer subscriptions', 'ChainApi');
    await jsApi.unsubscribeMessage(_newHeadsSubscribeChannel);
  }

  /// Subscribes to the latest headers
  Future<void> subscribeNewHeads() async {
    await jsApi.subscribeMessage('chain.subscribeNewHeads("$_newHeadsSubscribeChannel")', _newHeadsSubscribeChannel,
        (Map<String, dynamic> header) {
      store.chain.setLatestHeader(Header.fromJson(header));
    });
  }
}
