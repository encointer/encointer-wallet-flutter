import 'dart:async';

import 'package:ew_log/ew_log.dart';
import 'package:encointer_wallet/service/substrate_api/assets_api.dart';
import 'package:ew_polkadart/ew_polkadart.dart';

import 'mock_encointer_kusama_api.dart';

class MockAssetsApi extends AssetsApi {
  MockAssetsApi(super.store, MockEncointerKusamaApi super.encointerKusama);

  @override
  Future<void> startSubscriptions() async {
    Log.d('api: unimplemented startSubscription stub', 'MockAssetsApi');
  }

  @override
  Future<void> stopSubscriptions() async {
    Log.d('api: unimplemented stopSubscriptions stub', 'MockAssetsApi');
  }

  @override
  Future<StreamSubscription<StorageChangeSet>?> subscribeBalance() async {
    Log.d('api: unimplemented subscribeBalance stub', 'MockAssetsApi');
    return null;
  }

  @override
  Future<void> fetchBalance() async {
    Log.d('api: unimplemented fetchBalance', 'MockAssetsApi');
  }
}
