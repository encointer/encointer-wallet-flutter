import 'package:flutter_test/flutter_test.dart';

import 'package:encointer_wallet/mocks/test_tags.dart';
import 'package:encointer_wallet/mocks/test_utils.dart';
import 'package:encointer_wallet/service/substrate_api/core/dart_api.dart';
import 'package:encointer_wallet/service/substrate_api/encointer/encointer_dart_api.dart';

void main() {
  group('encointerDartApi', () {
    test('gets aggregated account data', () async {
      final substrateDartApi = SubstrateDartApi();
      await substrateDartApi.connect('ws://localhost:9944');

      final encointerDartApi = EncointerDartApi(substrateDartApi);

      final data = await encointerDartApi.getAggregatedAccountData(mediterraneanTestCommunity, aliceAddress);
      print('data: ${data.toString()}');

      await substrateDartApi.close();
    }, tags: encointerNodeE2E);
  });
}
