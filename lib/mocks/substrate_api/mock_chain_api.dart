import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/substrate_api/chain_api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'mock_js_api.dart';

class MockChainApi extends ChainApi {
  MockChainApi(AppStore store, MockJSApi js) : super(store, js);

  @override
  Future<void> startSubscriptions() async {
    Log.d("api: unimplemented startSubscriptions");
  }

  @override
  Future<void> stopSubscriptions() async {
    Log.d("api: unimplemented stopSubscriptions");
  }

  @override
  Future<void> subscribeTimestamp() async {
    Log.d("api: unimplemented subscribeTimestamp");
  }

  @override
  Future<void> subscribeNewHeads() async {
    Log.d("api: unimplemented subscribeTimestamp");
  }
}
