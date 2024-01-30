import 'package:encointer_wallet/service/substrate_api/account_api.dart';

import 'mock_polkadart_provider.dart';

class MockAccountApi extends AccountApi {
  MockAccountApi(super.store, MockPolkadartProvider super.provider);
}
