import 'package:encointer_wallet/service/forex/currency.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Currency enum', () {
    test('ISO code and lowercase conversion', () {
      expect(Currency.usd.isoCode, 'USD');
      expect(Currency.usd.isoCodeLower, 'usd');

      expect(Currency.ngn.isoCode, 'NGN');
      expect(Currency.ngn.isoCodeLower, 'ngn');
    });

    test('tryFromIso works case-insensitively', () {
      expect(Currency.tryFromIso('usd'), Currency.usd);
      expect(Currency.tryFromIso('Usd'), Currency.usd);
      expect(Currency.tryFromIso('NGN'), Currency.ngn);
      expect(Currency.tryFromIso('xyz'), null);
    });

    test('allIsoCodes returns correct list', () {
      final codes = Currency.allIsoCodes;
      expect(codes, containsAll(['USD', 'EUR', 'CHF', 'NGN', 'TZS']));
    });
  });
}
