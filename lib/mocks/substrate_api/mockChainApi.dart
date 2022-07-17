import 'package:encointer_wallet/service/substrate_api/chainApi.dart';

import 'mockJSApi.dart';

class MockChainApi extends ChainApi {
  MockChainApi(MockJSApi? js) : super(js);

  @override
  Future<void> startSubscriptions() async {
    _log("api: unimplemented startSubscriptions");
  }

  @override
  Future<void> stopSubscriptions() async {
    _log("api: unimplemented stopSubscriptions");
  }

  @override
  Future<void> subscribeTimestamp() async {
    _log("api: unimplemented subscribeTimestamp");
  }

  @override
  Future<void> subscribeNewHeads() async {
    _log("api: unimplemented subscribeTimestamp");
  }
}

void _log(String msg) {
  print("[MockChainApi]: $msg");
}
