import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/app.dart';

import 'core/mockDartApi.dart';
import 'mockJSApi.dart';

class MockApi extends Api {
  MockApi(
    AppStore store,
    String jsServiceEncointer, {
    this.withUi = true,
  }) : super(store, MockJSApi(), MockSubstrateDartApi(), jsServiceEncointer);

  final bool withUi;

  @override
  Future<void> init() async {
    if (withUi) {
      print("[MockApi] launch of webView");
      await launchWebview();
    }
  }
}
