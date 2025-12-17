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
      test('1 USD -> 0.8058 CHF -> 0.8058 LEU', () {
        const community = KnownCommunity.leu;

        const usdToChfRate = 0.79; // 1 USD = 0.79 CHF

        final ccUsdRate = community.ccPerUsd(usdToChfRate);

        // Manual calculation:
        // 1 CC = 1 CHF
        // 1 USD = 0.79 CHF
        // Apply markup 0.02 → 1 CC/CHF * 0.79 [CHF/USD] * 1.02 ≈ 0.8058 CC/USD
        expect(ccUsdRate, closeTo(0.8058, 1e-6));
      });

      test('1 USD -> 1444.719 NGN -> 1.473 PNQ', () {
        const community = KnownCommunity.pnq;

        const ngnPerUsd = 1444.719; // [NGN/USD]

        final ccUsdRate = community.ccPerUsd(ngnPerUsd);

        // Manual calculation:
        // 1 CC = 1000 NGN -> 1000 [NGN/CC]
        // 1 USD = 1444.719 NGN
        // Apply markup 0.02 → 1/1000 CC/NGN * 1444.719 [NGN/USD] * 1.02 ≈ 1.473 CC/USD
        expect(ccUsdRate, closeTo(1.47361338, 1e-6));
      });

      test('1 USD -> 2457.06 TZS -> 2.5062 NYT', () {
        const community = KnownCommunity.pnq;

        const ngnPerUsd = 2457.06; // [TZS/USD]

        final ccUsdRate = community.ccPerUsd(ngnPerUsd);

        // Manual calculation:
        // 1 CC = 1000 NGN -> 1000 [TZS/CC]
        // 1 USD = 2457.06 TZS
        // Apply markup 0.02 → 1/1000 CC/TZS * 2457.06 [TZS/USD] * 1.02 ≈ 2.5062 CC/USD
        expect(ccUsdRate, closeTo(2.5062012, 1e-6));
      });
    });
  });
}
