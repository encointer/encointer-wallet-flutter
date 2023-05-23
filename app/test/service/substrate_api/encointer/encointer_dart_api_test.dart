import 'package:flutter_test/flutter_test.dart';

import 'package:encointer_wallet/service/substrate_api/core/dart_api.dart';
import 'package:encointer_wallet/service/substrate_api/encointer/encointer_dart_api.dart';

import '../../../utils/test_tags.dart';
import '../../../utils/test_utils.dart';

void main() {
  group('encointerDartApi', () {
    test('gets aggregated account data', () async {
      final substrateDartApi = SubstrateDartApi();
      await substrateDartApi.connect('ws://localhost:9944');

      final encointerDartApi = EncointerDartApi(substrateDartApi);

      final data = await encointerDartApi.getAggregatedAccountData(mediterraneanTestCommunity, aliceAddress);
      // ignore: avoid_print
      print('data: $data');

      await substrateDartApi.close();
    }, tags: encointerNodeE2E);
  });
}
