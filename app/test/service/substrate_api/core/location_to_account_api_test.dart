import 'package:encointer_wallet/service/substrate_api/core/location_to_account_api.dart';
import 'package:encointer_wallet/service/substrate_api/core/reconnecting_ws_provider.dart';
import 'package:ew_keyring/ew_keyring.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../utils/test_tags.dart';

void main() {
  group('locationToAccountApi', () {
    late ReconnectingWsProvider provider;
    late LocationToAccountApi api;

    // Initialize provider once for all tests
    setUpAll(() {
      provider = ReconnectingWsProvider(
        Uri.parse('wss://sys.ibp.network/asset-hub-kusama'),
      );
      api = LocationToAccountApi(provider);
    });

    // Disconnect provider after all tests
    tearDownAll(() async {
      await provider.disconnect();
    });

    final testCases = [
      {
        'name': 'Leu',
        'encointer': 'HNJDzJEGaBgWRXz7bjERsRidJFQBnj1AZ2Tn3Q9uRGynhwq',
        'expected': 'DgdA9qwXxBAtdy9veCR4LZpcbYuMgCSL9XpV7gbELFncV2t',
      },
      {
        'name': 'PayNuq',
        'encointer': 'E2mZ1u2xepTF8nuEQVkrimPVwqtqq1joC56cUwYPftXAEQL',
        'expected': 'CqCAXF5M51M7xttMuK47TmyuSos8iusFm524ZzaAZnNiner',
      },
      {
        'name': 'Nyota',
        'encointer': 'E9KVuDLEtBBWSqhCiKn31VPBBLe33CbYJTrnWAbjszwskWH',
        'expected': 'G8yWL9B48XnbwC5aYpotqUk7ZTcpP7SGQcykoo7TVQTkhwJ',
      },
    ];

    for (final testCase in testCases) {
      test(
        '${testCase['name']} converts correctly',
            () async {
          final locationOnAHK = encointerAddressOnAHK(testCase['encointer']!);
          final accountId = await api.locationToAccountId(locationOnAHK);

          expect(accountId, AddressUtils.addressToPubKey(testCase['expected']!));
        },
        tags: productionE2E,
      );
    }
  });
}
