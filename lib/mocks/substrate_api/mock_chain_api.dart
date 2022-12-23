import 'package:encointer_wallet/mocks/substrate_api/mock_js_api.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/substrate_api/chain_api.dart';

class MockChainApi extends ChainApi {
  MockChainApi(super.store, MockJSApi super.js);

  @override
  Future<void> startSubscriptions() async {
    Log.d('api: unimplemented startSubscriptions', 'MockChainApi');
  }

  @override
  Future<void> stopSubscriptions() async {
    Log.d('api: unimplemented stopSubscriptions', 'MockChainApi');
  }

  @override
  Future<void> subscribeTimestamp() async {
    Log.d('api: unimplemented subscribeTimestamp', 'MockChainApi');
  }

  @override
  Future<void> subscribeNewHeads() async {
    Log.d('api: unimplemented subscribeTimestamp', 'MockChainApi');
  }
}
