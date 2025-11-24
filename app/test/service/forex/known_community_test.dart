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

    group('computeCcUsdFromApiRate', () {
      // Unparameterized example for LEU community (for better understanding)
      test('1 USD -> 0.79 CHF, LEU community', () {
        const community = KnownCommunity.leu;

        const usdToChfRate = 0.79; // 1 USD = 0.79 CHF

        final ccUsdRate = community.ccPerUsd(usdToChfRate);

        // Manual calculation:
        // 1 CC = 1 CHF
        // 1 USD = 0.79 CHF
        // Apply discount 0.2 → 1 CHF/CC * 0.79 [USD/CHF] * 0.8 ≈ 0.632 USD
        expect(ccUsdRate, closeTo(0.6320, 1e-6));
      });

      test('1 USD -> 0.79 CHF, LEU community', () {
        const community = KnownCommunity.leu;

        const usdToChfRate = 0.79; // 1 USD = 0.79 CHF

        final ccUsdRate = community.ccPerUsd(usdToChfRate);

        // Manual calculation:
        // 1 CC = 1 CHF
        // 1 USD = 0.79 CHF
        // Apply discount 0.2 → 1 CC/CHF * 0.79 [USD/CHF] * 0.8 ≈ 0.632 USD
        expect(ccUsdRate, closeTo(0.6320, 1e-6));
      });

      test('1 USD -> 0.1484.76300699 NGN, PNQ community', () {
        const community = KnownCommunity.pnq;

        const usdToNgnRate = 2452.61; // 1 USD = 2452.61339866 CHF

        final ccUsdRate = community.ccPerUsd(usdToNgnRate);

        // Manual calculation:
        // 2 CC = 1 CHF
        // 1 USD = 2452.61 NGN
        // Apply discount 0.2 → 1/2 CC/CHF * 2452.61 [USD/CHF] * 0.8 ≈ 981.044 CC/USD
        expect(ccUsdRate, closeTo(981.044, 1e-6));
      });

      // Mock API rates: 1 USD = x local fiat
      const apiRates = {
        'leu': 0.79, // 1 USD = 0.79 CHF
        'nyt': 2452.61, // 1 USD = 2452.61339866 TZS
        'pnq': 1484.76, // 1 USD = 1484.76300699 NGN
      };

      test('computes CC -> USD for all communities (USD->localFiat)', () {
        for (final community in KnownCommunity.values) {
          final usdToLocal = apiRates[community.symbol]!;

          final ccUsdRate = community.ccPerUsd(usdToLocal);

          final expected = (1 / community.localFiatRate) * usdToLocal * (1 - community.discount);

          expect(ccUsdRate, closeTo(expected, 1e-6), reason: 'CC → USD failed for ${community.symbol}');
        }
      });
    });
  });
}
