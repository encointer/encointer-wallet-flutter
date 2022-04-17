import 'package:encointer_wallet/mocks/data/mockAccountData.dart';
import 'package:encointer_wallet/mocks/storage/mockLocalStorage.dart';
import 'package:encointer_wallet/mocks/substrate_api/mockApi.dart';
import 'package:encointer_wallet/models/index.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('EncointerStore test', () {
    globalAppStore = AppStore(getMockLocalStorage());
    final AppStore root = globalAppStore;
    accList = [testAcc];
    currentAccountPubKey = accList[0]['pubKey'];

    webApi = MockApi(null, root, withUi: false);

    test('encointer store cache works', () async {
      await root.init('_en');
      await webApi.init();

      final store = root.encointer;

      var phase = CeremonyPhase.REGISTERING;

      store.setCurrentPhase(CeremonyPhase.ASSIGNING);
      store.setCurrentPhase(phase);
      expect(store.currentPhase, phase);
    });
  });
}
