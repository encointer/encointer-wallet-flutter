import 'package:flutter_test/flutter_test.dart';
import 'package:encointer_wallet/store/app.dart';

import 'package:encointer_wallet/mocks/localStorage_mock.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final AppStore store = AppStore();
  store.localStorage = getMockLocalStorage();

  group('store test', () {
    test('app store created and not ready', () {
      expect(store.isReady, false);
      expect(store.settings, isNull);
    });

    test('app store init and ready', () async {
      await store.init('_en');

      expect(store.settings, isNotNull);
      expect(store.account, isNotNull);
      expect(store.assets, isNotNull);
      expect(store.encointer, isNotNull);

      expect(store.isReady, true);

      expect(store.account.accountList.length, 1);
    });
  });
}
