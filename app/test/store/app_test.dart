import 'package:encointer_wallet/extras/config/build_options.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:encointer_wallet/service_locator/service_locator.dart' as service_locator;
import 'package:encointer_wallet/mocks/data/mock_account_data.dart';
import 'package:encointer_wallet/store/app_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  setEnvironment(Environment.unitTest);
  SharedPreferences.setMockInitialValues({});
  service_locator.init(isTest: true);
  await service_locator.sl.allReady();

  late final store = service_locator.sl.get<AppStore>();
  accList = [testAcc];
  currentAccountPubKey = accList[0]['pubKey'] as String;

  group('store test', () {
    test('app store created and not ready', () {
      expect(store.storeIsReady, false);
      // Since introducing null safety, this will throw instead of being null.
      // expect(store.settings, isNull);
    });

    test('app store init and ready', () async {
      await store.init();

      expect(store.settings, isNotNull);
      expect(store.account, isNotNull);
      expect(store.assets, isNotNull);
      expect(store.encointer, isNotNull);

      expect(store.storeIsReady, true);

      expect(store.account.accountList.length, 1);
    });
  });
}
