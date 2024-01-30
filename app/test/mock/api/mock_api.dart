import 'dart:core';

import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:ew_http/ew_http.dart';
import 'package:encointer_wallet/mocks/ipfs_api.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/app.dart';

import 'mock_account_api.dart';
import 'mock_assets_api.dart';
import 'mock_chain_api.dart';
import 'mock_encointer_api.dart';
import 'mock_encointer_kusama_api.dart';
import 'mock_polkadart_provider.dart';
import 'mock_substrate_dart_api.dart';

MockApi getMockApi(AppStore store) {
  return MockApi(store, MockSubstrateDartApi(), EwHttp());
}

class MockApi extends Api {
  MockApi(AppStore store, MockSubstrateDartApi dartApi, EwHttp ewHttp)
      : super(
          store,
          MockPolkadartProvider(),
          dartApi,
          MockAccountApi(store, MockPolkadartProvider()),
          MockAssetsApi(store, MockEncointerKusamaApi()),
          MockChainApi(store, MockPolkadartProvider()),
          MockEncointerApi(store, dartApi, ewHttp, MockEncointerKusamaApi()),
          MockIpfsApi(ewHttp),
        );

  @override
  Future<void> init() async {
    Log.d('[MockApi] launch of webView', 'MockApi');
  }
}
