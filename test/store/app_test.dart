import 'package:encointer_wallet/mocks/data/mock_account_data.dart';
import 'package:encointer_wallet/service_locator/service_locator.dart' as service_locator;
import 'package:encointer_wallet/store/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  service_locator.init(isTest: true);
  final store = AppStore();
  accList = [testAcc];
  currentAccountPubKey = accList[0]['pubKey'] as String;

  group('store test', () {
    test('app store created and not ready', () {
      expect(store.storeIsReady, false);
      // Since introducing null safety, this will throw instead of being null.
      // expect(store.settings, isNull);
    });

    test('app store init and ready', () async {
      await store.init('_en');

      expect(store.settings, isNotNull);
      expect(store.account, isNotNull);
      expect(store.assets, isNotNull);
      expect(store.encointer, isNotNull);

      expect(store.storeIsReady, true);

      expect(store.account.accountList.length, 1);
    });
  });
}
