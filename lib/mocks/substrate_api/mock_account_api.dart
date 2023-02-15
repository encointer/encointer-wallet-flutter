import 'package:encointer_wallet/common/data/substrate_api/account_api.dart';
import 'package:encointer_wallet/mocks/substrate_api/mock_js_api.dart';

class MockAccountApi extends AccountApi {
  MockAccountApi(super.store, MockJSApi super.js);
}
