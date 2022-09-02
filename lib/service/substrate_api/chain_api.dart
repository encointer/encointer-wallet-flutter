import 'package:encointer_wallet/service/substrate_api/core/js_api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/store/chain/types/header.dart';

class ChainApi {
  ChainApi(this.store, this.jsApi);

  final JSApi jsApi;
  final AppStore store;

  final String _timeStampSubscribeChannel = 'timestamp';
  final String _newHeadsSubscribeChannel = 'latestHeader';

  Future<void> startSubscriptions() async {
    print('api: starting encointer subscriptions');
    subscribeNewHeads();
  }

  Future<void> stopSubscriptions() async {
    print('api: stopping encointer subscriptions');
    jsApi.unsubscribeMessage(_newHeadsSubscribeChannel);
  }

  /// Subscribes to the timestamp of the last block. This is only used as a debug method to see if the dart-js interface
  /// is still communicating.
  Future<void> subscribeTimestamp() async {
    jsApi.subscribeMessage('chain.subscribeTimestamp("$_timeStampSubscribeChannel")', _timeStampSubscribeChannel,
        (data) => {print('timestamp: $data')});
  }

  /// Subscribes to the latest headers
  Future<void> subscribeNewHeads() async {
    jsApi.subscribeMessage('chain.subscribeNewHeads("$_newHeadsSubscribeChannel")', _newHeadsSubscribeChannel,
        (header) {
      store.chain.setLatestHeader(Header.fromJson(header));
    });
  }
}
