import 'package:encointer_wallet/service/substrate_api/chainApi.dart';
import 'package:encointer_wallet/store/app.dart';

import 'mockJSApi.dart';

class MockChainApi extends ChainApi {
  MockChainApi(AppStore store, MockJSApi js) : super(store, js);

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
