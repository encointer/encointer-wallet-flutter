import 'package:encointer_wallet/mocks/substrate_api/mock_js_api.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/substrate_api/chain_api.dart';
import 'package:encointer_wallet/store/chain/types/header.dart';

class MockChainApi extends ChainApi {
  MockChainApi(MockJSApi super.js);

  @override
  Future<void> startSubscriptions(void Function(Header latest) callback) async {
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
}
