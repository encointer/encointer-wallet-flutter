import 'dart:core';

import 'package:ew_http/ew_http.dart';

import 'package:encointer_wallet/mocks/ipfs_api.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/app.dart';

import 'mock_account_api.dart';
import 'mock_assets_api.dart';
import 'mock_chain_api.dart';
import 'mock_encointer_api.dart';
import 'mock_encointer_kusama_api.dart';
import 'mock_js_api.dart';
import 'mock_polkadart_provider.dart';
import 'mock_substrate_dart_api.dart';

MockApi getMockApi(AppStore store, {required bool withUI}) {
  return MockApi(store, MockJSApi(), MockSubstrateDartApi(), EwHttp(), '', withUi: withUI);
}

class MockApi extends Api {
  MockApi(
    AppStore store,
    MockJSApi js,
    MockSubstrateDartApi dartApi,
    EwHttp ewHttp,
    String jsServiceEncointer, {
    required this.withUi,
  }) : super(
          store,
          js,
          MockPolkadartProvider(),
          dartApi,
          MockAccountApi(store, js, MockPolkadartProvider()),
          MockAssetsApi(store, js, MockEncointerKusamaApi()),
          MockChainApi(store, MockPolkadartProvider()),
          MockEncointerApi(store, js, dartApi, ewHttp, MockEncointerKusamaApi()),
          MockIpfsApi(ewHttp),
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
