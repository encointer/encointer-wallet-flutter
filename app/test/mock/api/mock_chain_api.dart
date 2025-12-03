import 'package:ew_log/ew_log.dart';
import 'package:encointer_wallet/service/substrate_api/chain_api.dart';

import 'mock_polkadart_provider.dart';

class MockChainApi extends ChainApi {
  MockChainApi(super.store, MockPolkadartProvider super.provider);

  @override
  Future<void> startSubscriptions() async {
    Log.d('api: unimplemented startSubscriptions', 'MockChainApi');
  }

  @override
  Future<void> stopSubscriptions() async {
    Log.d('api: unimplemented stopSubscriptions', 'MockChainApi');
  }

  @override
  Future<void> subscribeNewHeads() async {
    Log.d('api: unimplemented subscribeTimestamp', 'MockChainApi');
  }
}
