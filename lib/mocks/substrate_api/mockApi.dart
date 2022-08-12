import 'package:encointer_wallet/mocks/ipfs/mockIpfsApi.dart';
import 'package:encointer_wallet/mocks/substrate_api/core/mockDartApi.dart';
import 'package:encointer_wallet/mocks/substrate_api/mockChainApi.dart';
import 'package:encointer_wallet/mocks/substrate_api/mockCodecApi.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/app.dart';

import 'mockAccountApi.dart';
import 'mockAssetsApi.dart';
import 'mockEncointerApi.dart';
import 'mockJSApi.dart';

MockApi getMockApi(AppStore store, {required bool withUI}) {
  return MockApi(store, MockJSApi(), MockSubstrateDartApi(), "", withUi: withUI);
}

class MockApi extends Api {
  MockApi(
    AppStore store,
    MockJSApi js,
    MockSubstrateDartApi dartApi,
    String jsServiceEncointer, {
    required this.withUi,
  }) : super(
          store,
          js,
          dartApi,
          MockAccountApi(store, js),
          MockAssetsApi(store, js),
          MockChainApi(store, js),
          MockCodecApi(js),
          MockEncointerApi(store, js, dartApi),
          MockIpfs(),
          jsServiceEncointer,
        );

  final bool withUi;

  @override
  Future<void> init() async {
    if (withUi) {
      Log.p("[MockApi] launch of webView");
      await launchWebview();
    }
  }
}
