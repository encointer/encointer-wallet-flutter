import 'package:encointer_wallet/config/networks/networks.dart';
import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/service/substrate_api/asset_hub/asset_hub_api.dart';
import 'package:encointer_wallet/service/substrate_api/core/reconnecting_ws_provider.dart';
import 'package:ew_keyring/ew_keyring.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:encointer_wallet/service/substrate_api/core/dart_api.dart';
import 'package:encointer_wallet/service/substrate_api/encointer/encointer_dart_api.dart';

import '../../utils/test_tags.dart';

void main() {
  late ReconnectingWsProvider assetHubProvider;
  late AssetHubApi assetHubApi;

  late ReconnectingWsProvider encointerProvider;
  late EncointerDartApi encointerApi;

  for (final endpoint in assetHubKusamaEndpoints()) {
    group('Asset Hub Kusama Endpoint: ${endpoint.address()}', () {
      // Initialize provider once for all tests
      setUpAll(() {
        assetHubProvider = ReconnectingWsProvider(
          Uri.parse('wss://sys.ibp.network/asset-hub-kusama'),
        );
        assetHubApi = AssetHubApi(assetHubProvider);

        encointerProvider = ReconnectingWsProvider(
          Uri.parse('wss://kusama.api.encointer.org'),
        );
        encointerApi = EncointerDartApi(SubstrateDartApi(encointerProvider));
      });

      // Disconnect provider after all tests
      tearDownAll(() async {
        await assetHubProvider.disconnect();
      });

      group('Resolves Treasury Account Correctly', () {
        final testCases = [
          {
            'name': 'Leu',
            'cid': 'u0qj944rhWE',
            'encointer': 'HNJDzJEGaBgWRXz7bjERsRidJFQBnj1AZ2Tn3Q9uRGynhwq',
            'asset_hub': 'DgdA9qwXxBAtdy9veCR4LZpcbYuMgCSL9XpV7gbELFncV2t',
          },
          {
            'name': 'PayNuq',
            'cid': 's1vrqQL2SD',
            'encointer': 'E2mZ1u2xepTF8nuEQVkrimPVwqtqq1joC56cUwYPftXAEQL',
            'asset_hub': 'CqCAXF5M51M7xttMuK47TmyuSos8iusFm524ZzaAZnNiner',
          },
          {
            'name': 'Nyota',
            'cid': 'kygch5kVGq7',
            'encointer': 'E9KVuDLEtBBWSqhCiKn31VPBBLe33CbYJTrnWAbjszwskWH',
            'asset_hub': 'G8yWL9B48XnbwC5aYpotqUk7ZTcpP7SGQcykoo7TVQTkhwJ',
          },
        ];

        for (final testCase in testCases) {
          test(
            '${testCase['name']} has correct treasury accounts on encointer',
            () async {
              final cid = CommunityIdentifier.fromFmtString(testCase['cid']!);
              final encointerAddress = await encointerApi.getTreasuryAccount(cid);
              expect(AddressUtils.transformPrefix(encointerAddress, 2), testCase['encointer']);
            },
            tags: productionE2E,
          );
        }

        for (final testCase in testCases) {
          test(
            '${testCase['name']} has correct treasury accounts on asset hub kusama',
            () async {
              final accountId = await assetHubApi.encointerAccountOnAHK(testCase['encointer']!);

              expect(AddressUtils.pubKeyToAddress(accountId, prefix: 2), testCase['asset_hub']);
            },
            tags: productionE2E,
          );
        }
      });
    });
  }
}
