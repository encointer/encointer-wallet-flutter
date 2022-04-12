import 'package:encointer_wallet/service/substrate_api/accountApi.dart';

import 'jsApi.dart';

class MockAccountApi extends AccountApi {
  MockAccountApi(MockJSApi js, Function fetchAccountData) : super(js, fetchAccountData);
}
