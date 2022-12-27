import 'package:encointer_wallet/service/log/log_service.dart';
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
    Log.d('api: starting encointer subscriptions', 'ChainApi');
    subscribeNewHeads();
  }

  Future<void> stopSubscriptions() async {
    Log.d('api: stopping encointer subscriptions', 'ChainApi');
    jsApi.unsubscribeMessage(_newHeadsSubscribeChannel);
  }

  /// Subscribes to the timestamp of the last block. This is only used as a debug method to see if the dart-js interface
  /// is still communicating.
  Future<void> subscribeTimestamp() async {
    jsApi.subscribeMessage(
      'chain.subscribeTimestamp("$_timeStampSubscribeChannel")',
      _timeStampSubscribeChannel,
      (dynamic data) => {Log.d('timestamp: $data', 'ChainApi')},
    );
  }

  /// Subscribes to the latest headers
  Future<void> subscribeNewHeads() async {
    jsApi.subscribeMessage('chain.subscribeNewHeads("$_newHeadsSubscribeChannel")', _newHeadsSubscribeChannel,
        (dynamic header) {
      store.chain.setLatestHeader(Header.fromJson(header as Map<String, dynamic>));
    });
  }
}
