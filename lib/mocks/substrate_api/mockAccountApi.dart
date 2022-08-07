import 'package:encointer_wallet/service/substrate_api/accountApi.dart';

import '../../store/app.dart';
import 'mockJSApi.dart';

class MockAccountApi extends AccountApi {
  MockAccountApi(AppStore store, MockJSApi js) : super(store, js);
}
