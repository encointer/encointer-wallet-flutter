import 'dart:convert';
import 'package:encointer_wallet/service/forex/forex_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('ForexService with mocked client', () {
    test('returns a fresh rate from primary API', () async {
      final mockClient = MockClient((request) async {
        return http.Response(
          json.encode({
            'usd': {'ngn': 1600.5}
          }),
          200,
        );
      });

      SharedPreferences.setMockInitialValues({});
      final service = ForexService(client: mockClient);

      final rate = await service.getRate('usd', 'ngn');

      expect(rate, isNotNull);
      expect(rate!.value, 1600.5);
      expect(rate.isStale, false);
    });

    test('falls back to cached rate if API fails', () async {
      final now = DateTime.now();
      final cached = {
        'value': 1234.5,
        'expiry': now.add(const Duration(hours: 12)).toIso8601String(),
        'fetchedAt': now.toIso8601String(),
      };
      SharedPreferences.setMockInitialValues({
        'forex_usd-ngn': json.encode(cached),
      });

      final mockClient = MockClient((_) async => http.Response('fail', 500));
      final service = ForexService(client: mockClient);

      final rate = await service.getRate('usd', 'ngn');

      expect(rate, isNotNull);
      expect(rate!.value, 1234.5);
      expect(rate.isStale, false);
    });

    test('returns stale rate when preferStale is true', () async {
      final expired = {
        'value': 999.9,
        'expiry': DateTime.now().subtract(const Duration(hours: 1)).toIso8601String(),
        'fetchedAt': DateTime.now().subtract(const Duration(hours: 2)).toIso8601String(),
      };
      SharedPreferences.setMockInitialValues({
        'forex_usd-ngn': json.encode(expired),
      });

      final mockClient = MockClient((_) async => http.Response('fail', 500));
      final service = ForexService(client: mockClient);

      final rate = await service.getRate('usd', 'ngn');

      expect(rate, isNotNull);
      expect(rate!.isStale, true);
      expect(rate.value, 999.9);
    });

    test('returns null when no data and API fails', () async {
      SharedPreferences.setMockInitialValues({});
      final mockClient = MockClient((_) async => http.Response('fail', 500));
      final service = ForexService(client: mockClient, preferStale: false);

      final rate = await service.getRate('usd', 'ngn');

      expect(rate, isNull);
    });
  });

  group('ForexService live API (integration)', () {
    for (final c in ['chf', 'ngn', 'tzs']) {
      test(
        'fetches USD->$c successfully from real API',
        () async {
          // Use in-memory SharedPreferences so plugin is not needed
          SharedPreferences.setMockInitialValues({});

          final service = ForexService(
            client: http.Client(), // real HTTP client
          );

          final rate = await service.getUsdRate(c);

          expect(rate, isNotNull);
          expect(rate!.value, greaterThan(0));
          expect(rate.isStale, false);
        },
        timeout: const Timeout(Duration(seconds: 10)),
        tags: 'productionE2E',
      ); // adjust your tag if needed
    }
  });
}
