import 'package:encointer_wallet/mocks/ipfs/mockIpfsApi.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:get_storage/get_storage.dart';

import 'core/mockDartApi.dart';
import 'mockAccountApi.dart';
import 'mockAssetsApi.dart';
import 'mockChainApi.dart';
import 'mockCodecApi.dart';
import 'mockEncointerApi.dart';
import 'mockJSApi.dart';

class MockApi extends Api {
  MockApi(
    AppStore store,
    String jsServiceEncointer, {
    this.withUi = true,
  }) : super(store, jsServiceEncointer);

  final bool withUi;

  @override
  Future<void> init() async {
    jsStorage = GetStorage();
    js = MockJSApi();

    account = MockAccountApi(store, js as MockJSApi, fetchAccountData);
    assets = MockApiAssets(store, js as MockJSApi);
    chain = MockChainApi(store, js as MockJSApi);
    codec = MockCodecApi(js as MockJSApi);
    encointer = MockApiEncointer(store, js as MockJSApi, MockSubstrateDartApi());
    ipfs = MockIpfs();

    if (withUi) {
      print("first launch of webview");
      await launchWebview();
    }
  }
}
