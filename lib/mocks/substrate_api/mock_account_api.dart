import 'package:encointer_wallet/service/substrate_api/account_api.dart';
import 'package:encointer_wallet/store/app.dart';

import 'package:encointer_wallet/mocks/substrate_api/mock_js_api.dart';

class MockAccountApi extends AccountApi {
  MockAccountApi(AppStore store, MockJSApi js) : super(store, js);
}
