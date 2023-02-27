import 'package:encointer_wallet/common/constants/consts.dart';
import 'package:encointer_wallet/common/services/preferences/preferences_service.dart';
import 'package:encointer_wallet/extras/config/build_options.dart';
import 'package:encointer_wallet/service_locator/service_locator.dart' as service_locator;
import 'package:encointer_wallet/store/settings.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  setEnvironment(Environment.test);
  await PreferencesService.instance.init();
  service_locator.init(isTest: true);

  group('SettingsStore test', () {
    late final store = SettingsStore();

    test('settings store created', () {
      expect(store.cacheNetworkStateKey, 'network');
      expect(store.localeCode, '');
    });
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
    test('set network name properly', () async {
      expect(store.networkName, '');
      store.setNetworkName('Encointer');
      expect(store.networkName, 'Encointer');
      expect(store.loading, false);
    });

    test('network endpoint test', () async {
      await store.init();
      expect(store.endpoint.info, networkEndpointEncointerMainnet.info);
      expect(store.endpointList.length, 1);
    });

    test('set network state properly', () async {
      store.setNetworkState(Map<String, dynamic>.of({
        'ss58Format': 2,
        'tokenDecimals': 12,
        'tokenSymbol': 'KSM',
      }));
      expect(store.networkState!.ss58Format, 2);
      expect(store.networkState!.tokenDecimals, 12);
      expect(store.networkState!.tokenSymbol, 'KSM');
    });
  });
}
