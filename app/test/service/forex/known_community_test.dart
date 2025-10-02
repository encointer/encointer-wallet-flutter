import 'package:encointer_wallet/service/forex/known_community.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('KnownCommunity enum', () {
    test('tryFromSymbol and isKnown', () {
      expect(KnownCommunity.tryFromSymbol('leu'), KnownCommunity.leu);
      expect(KnownCommunity.tryFromSymbol('NYT'), KnownCommunity.nyt);
      expect(KnownCommunity.tryFromSymbol('pnq'), KnownCommunity.pnq);
      expect(KnownCommunity.tryFromSymbol('xyz'), null);

      expect(KnownCommunity.isKnown('leu'), true);
      expect(KnownCommunity.isKnown('xyz'), false);
    });

    // One well-understandable explicit test
    test('CC → USD computation with mock local fiat rate', () {
      const leu = KnownCommunity.nyt;
      const mockLocalFiatToUsd = 1.1; // pretend 1 CHF = 1.1 USD

      final ccUsdRate = leu.computeCcUsdRateFromLocalFiat(mockLocalFiatToUsd);

      // 1 CC = 0.5 CHF * 1.1 USD * (1 - 0.2 discount) = 0.44
      expect(ccUsdRate, closeTo(0.44, 1e-6));
    });

    // test the rest parametrized
    test('CC → USD computation with mock local fiat rate', () {
      const mockRates = {
        'leu': 1.1, // 1 CHF = 1.1 USD
        'nyt': 0.0043, // 1 TZS = 0.0043 USD
        'pnq': 0.0023, // 1 NGN = 0.0023 USD
      };

      for (final community in KnownCommunity.values) {
        final mockLocalToUsd = mockRates[community.symbol]!;
        final ccUsdRate = community.computeCcUsdRateFromLocalFiat(mockLocalToUsd);

        // sanity check: rate > 0
        expect(ccUsdRate, greaterThan(0));

        // optionally, verify manual calculation
        final expected = (1 / community.ccPerLocalFiat) * mockLocalToUsd * (1 - community.discount);
        expect(ccUsdRate, closeTo(expected, 1e-6));
      }
    });
  });
}
