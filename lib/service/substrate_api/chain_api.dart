import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/substrate_api/core/js_api.dart';
import 'package:encointer_wallet/store/chain/types/header.dart';

class ChainApi {
  const ChainApi(this.jsApi);

  final JSApi jsApi;

  static const String _timeStampSubscribeChannel = 'timestamp';
  static const String _newHeadsSubscribeChannel = 'latestHeader';

  Future<void> startSubscriptions(void Function(Header latest) callback) async {
    Log.d('api: starting encointer subscriptions', 'ChainApi');
    jsApi.subscribeMessage(
      'chain.subscribeNewHeads("$_newHeadsSubscribeChannel")',
      _newHeadsSubscribeChannel,
      (dynamic header) {
        callback(Header.fromJson(header as Map<String, dynamic>));
      },
    );
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
}
