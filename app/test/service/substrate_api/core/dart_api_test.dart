import 'package:encointer_wallet/service/substrate_api/core/reconnecting_ws_provider.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:encointer_wallet/service/substrate_api/core/dart_api.dart';

import '../../../utils/test_tags.dart';

void main() {
  group('can connect', () {
    test('rpc methods contains getAggregatedAccountData', () async {
      final provider = ReconnectingWsProvider(Uri.parse('ws://localhost:9944'));

      final encointerApi = SubstrateDartApi(provider);

      expect((await encointerApi.rpcMethods()).methods!.contains('encointer_getAggregatedAccountData'), true);

      await provider.disconnect();
    }, tags: encointerNodeE2E);
  });
}
