import 'package:encointer_wallet/mocks/data/mockAccountData.dart';
import 'package:encointer_wallet/mocks/storage/mockLocalStorage.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final AppStore store = AppStore(MockLocalStorage());
  accList = [testAcc];
  currentAccountPubKey = accList[0]['pubKey'];

  group('store test', () {
    test('app store created and not ready', () {
      expect(store.isReady, false);
      // Since introducing null safety, this will throw instead of being null.
      // expect(store.settings, isNull);
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
