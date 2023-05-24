import 'package:flutter_test/flutter_test.dart';

import 'package:encointer_wallet/service/substrate_api/core/dart_api.dart';

import '../../../utils/test_tags.dart';

void main() {
  group('can connect', () {
    test('rpc methods contains getAggregatedAccountData', () async {
      final encointerApi = SubstrateDartApi();

      await encointerApi.connect('ws://localhost:9944');

      expect(encointerApi.rpcMethods?.contains('encointer_getAggregatedAccountData'), true);

      await encointerApi.close();
    }, tags: encointerNodeE2E);
  });
}
