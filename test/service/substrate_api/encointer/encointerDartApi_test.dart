import 'package:encointer_wallet/mocks/testTags.dart';
import 'package:encointer_wallet/mocks/testUtils.dart';
import 'package:encointer_wallet/service/substrate_api/core/dartApi.dart';
import 'package:encointer_wallet/service/substrate_api/encointer/encointerDartApi.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('encointerDartApi', () {
    test('gets aggregated account data', () async {
      var substrateDartApi = SubstrateDartApi();
      await substrateDartApi.connect('ws://localhost:9944');

      var encointerDartApi = EncointerDartApi(substrateDartApi);

      var data = await encointerDartApi.getAggregatedAccountData(mediterraneanTestCommunity, ALICE_ADDRESS);
      print("data: ${data.toString()}");

      await substrateDartApi.close();
    }, tags: encointerNodeE2E);
  });
}
