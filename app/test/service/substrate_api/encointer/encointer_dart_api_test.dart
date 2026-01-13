import 'package:encointer_wallet/config/networks/networks.dart' show Network;
import 'package:encointer_wallet/models/communities/community_identifier.dart' show CommunityIdentifier;
import 'package:encointer_wallet/service/service.dart';
import 'package:encointer_wallet/service/substrate_api/core/reconnecting_ws_provider.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:encointer_wallet/service/substrate_api/core/dart_api.dart';
import 'package:encointer_wallet/service/substrate_api/encointer/encointer_dart_api.dart';

import '../../../utils/test_tags.dart';
import '../../../utils/test_utils.dart';

void main() {
  group('encointerDartApi', () {
    test('gets aggregated account data', () async {
      final provider = ReconnectingWsProvider(Uri.parse('ws://localhost:9944'));

      final substrateDartApi = SubstrateDartApi(provider);

      final encointerDartApi = EncointerDartApi(substrateDartApi);

      final data = await encointerDartApi.getAggregatedAccountData(mediterraneanTestCommunity, aliceAddress);
      // ignore: avoid_print
      print('data: $data');

      await provider.disconnect();
    }, tags: encointerNodeE2E);
  });

  group('encointerDartApi Businesses', () {
    test('gets allBusinesses data', () async {
      final cid = CommunityIdentifier.fromFmtString('u0qj944rhWE');

      final provider = ReconnectingWsProvider(Uri.parse('wss://kusama.api.encointer.org'));
      final substrateDartApi = SubstrateDartApi(provider);
      final encointerDartApi = EncointerDartApi(substrateDartApi);

      final businesses = await encointerDartApi.bazaarGetBusinesses(cid);

      const expectedOwner = '5FLHLP61LgMsdzwWziyCmZqdKQyQZz4FeAadhMZj1AGFZo3Z';
      await provider.disconnect();

      // We do not overwrite the hashes currently to get object equality.
      // So we need to compare the jsons.
      expect(businesses.any((b) => b.controller == expectedOwner), true);
    }, tags: productionE2E);
  });

  group('endpoint health check', () {
    for (final e in Network.encointerKusama.networkEndpoints()) {
      test(
        'kusama endpoint ${e.address()} is healthy',
        () async {
          final result = await NetworkEndpointChecker().checkHealth(e);
          expect(result, isTrue, reason: 'Endpoint ${e.address()} is not healthy');
        },
        tags: endpointHealthE2E,
      );
    }

    for (final e in Network.gesell.networkEndpoints()) {
      test(
        'gesell endpoint ${e.address()} is healthy',
        () async {
          final result = await NetworkEndpointChecker().checkHealth(e);
          expect(result, isTrue, reason: 'Endpoint ${e.address()} is not healthy');
        },
        tags: endpointHealthE2E,
      );
    }
  });
}
