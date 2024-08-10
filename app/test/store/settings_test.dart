import 'package:flutter_test/flutter_test.dart';

import 'package:encointer_wallet/store/settings.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/config/networks/networks.dart';
import 'package:encointer_wallet/store/account/services/legacy_storage.dart';
import 'package:ew_storage/ew_storage.dart' show SecureStorageMock;

import '../mock/mock.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('SettingsStore test', () {
    final root = AppStore(MockLocalStorage(), SecureStorageMock(), LegacyLocalStorageMock());
    final store = SettingsStore(root);

    test('set locale code properly', () async {
      await store.setLocalCode('_en');
      expect(store.localeCode, '_en');
      await store.setLocalCode('_zh');
      expect(store.localeCode, '_zh');
    });
    test('set network loading state properly', () async {
      expect(store.loading, true);
      store.setNetworkLoading(false);
      expect(store.loading, false);
      store.setNetworkLoading(true);
      expect(store.loading, true);
    });

    test('network endpoint test', () async {
      await store.init('_en');
      expect(store.currentNetwork, Network.encointerKusama);
    });
  });
}
