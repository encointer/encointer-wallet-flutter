import 'package:encointer_wallet/service/substrate_api/accountApi.dart';

import 'mockJSApi.dart';

class MockAccountApi extends AccountApi {
  MockAccountApi(MockJSApi js, Function fetchAccountData) : super(js, fetchAccountData);
}
