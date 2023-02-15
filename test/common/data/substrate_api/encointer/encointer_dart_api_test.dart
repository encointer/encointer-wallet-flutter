import 'package:encointer_wallet/common/data/substrate_api/core/dart_api.dart';
import 'package:encointer_wallet/common/data/substrate_api/encointer/encointer_dart_api.dart';
import 'package:encointer_wallet/mocks/test_tags.dart';
import 'package:encointer_wallet/mocks/test_utils.dart';
import 'package:flutter_test/flutter_test.dart';

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
