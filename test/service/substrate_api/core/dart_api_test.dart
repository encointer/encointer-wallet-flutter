import 'package:encointer_wallet/mocks/test_tags.dart';
import 'package:encointer_wallet/service/substrate_api/core/dart_api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('can connect', () {
    test('rpc methods contains getAggregatedAccountData', () async {
      var encointerApi = SubstrateDartApi();

      await encointerApi.connect('ws://localhost:9944');

      expect(encointerApi.rpcMethods.contains("encointer_getAggregatedAccountData"), true);

      await encointerApi.close();
    }, tags: encointerNodeE2E);
  });
}
