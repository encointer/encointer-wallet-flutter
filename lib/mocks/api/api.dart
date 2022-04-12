import 'package:encointer_wallet/mocks/api/apiAssets.dart';
import 'package:encointer_wallet/mocks/api/apiIpfs.dart';
import 'package:encointer_wallet/mocks/api/mockChainApi.dart';
import 'package:encointer_wallet/mocks/api/mockEncointerApi.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/service/substrate_api/codecApi.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'jsApi.dart';
import 'mockAccountApi.dart';

class MockApi extends Api {
  MockApi(BuildContext context, AppStore store, {this.withUi = true}) : super(context, store);

  final bool withUi;

  @override
  Future<void> init() async {
    jsStorage = GetStorage();
    js = MockJSApi();

    account = MockAccountApi(js, fetchAccountData);
    assets = MockApiAssets(js);
    chain = MockChainApi(js);
    codec = CodecApi(js);
    encointer = MockApiEncointer(js);
    ipfs = MockIpfs();

    if (withUi) {
      print("first launch of webview");
      await launchWebview();

      //TODO: fix this properly!
      // hack to allow hot-restart with re-loaded webview
      // the problem is that hot-restart doesn't call dispose(),
      // so the webview will not be closed properly. Therefore,
      // the first call to launchWebView will crash. The second
      // one seems to succeed
      print("second launch of webview");
      await launchWebview();
    }
  }
}
