import 'package:encointer_wallet/service/substrate_api/account_api.dart';

import 'mock_js_api.dart';

class MockAccountApi extends AccountApi {
  MockAccountApi(super.store, MockJSApi super.js);
}
