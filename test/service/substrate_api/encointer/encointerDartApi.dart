import 'package:encointer_wallet/service/substrate_api/core/dartApi.dart';
import 'package:encointer_wallet/service/substrate_api/encointer/encointerDartApi.dart';
import 'package:encointer_wallet/store/encointer/types/communities.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('can connect', () {
    test('gets aggregated account data', () async {
      var substrateDartApi = SubstrateDartApi();
      await substrateDartApi.connect('ws://localhost:9944');

      var encointerDartApi = EncointerDartApi(substrateDartApi);

      var alice = "5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY";

      // community from `bootstrap_demo_community.py`
      var cid = CommunityIdentifier.fromFmtString("sqm1v79dF6b");
      var data = encointerDartApi.getAggregatedAccountData(cid, alice);

      print("data: ${data.toString()}");
      await substrateDartApi.close();
    });
  });
}
