import 'dart:core';

import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/mocks/ipfs/mock_ipfs_api.dart';
import 'package:encointer_wallet/mocks/substrate_api/core/mock_dart_api.dart';
import 'package:encointer_wallet/mocks/substrate_api/mock_account_api.dart';
import 'package:encointer_wallet/mocks/substrate_api/mock_assets_api.dart';
import 'package:encointer_wallet/mocks/substrate_api/mock_chain_api.dart';
import 'package:encointer_wallet/mocks/substrate_api/mock_codec_api.dart';
import 'package:encointer_wallet/mocks/substrate_api/mock_encointer_api.dart';
import 'package:encointer_wallet/mocks/substrate_api/mock_js_api.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/app.dart';

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
          MockAssetsApi(js),
          MockChainApi(js),
          MockCodecApi(js),
          MockEncointerApi(store, js, dartApi),
          MockIpfs(ipfs_gateway_local),
          jsServiceEncointer,
        );

  final bool withUi;

  @override
  Future<void> init() async {
    if (withUi) {
      Log.d('[MockApi] launch of webView', 'MockApi');

      await launchWebview();
    }
  }
}
