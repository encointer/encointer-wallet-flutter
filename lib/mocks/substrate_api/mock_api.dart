import 'package:encointer_wallet/mocks/ipfs/mock_ipfs_api.dart';
import 'package:encointer_wallet/mocks/substrate_api/core/mock_dart_api.dart';
import 'package:encointer_wallet/mocks/substrate_api/mock_chain_api.dart';
import 'package:encointer_wallet/mocks/substrate_api/mock_codec_api.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/app.dart';

import 'mock_account_api.dart';
import 'mock_assets_api.dart';
import 'mock_encointer_api.dart';
import 'mock_js_api.dart';

MockApi getMockApi(AppStore store, {required bool withUI}) {
  return MockApi(store, MockJSApi(), MockSubstrateDartApi(), '', withUi: withUI);
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
      print('[MockApi] launch of webView');
      await launchWebview();
    }
  }
}
