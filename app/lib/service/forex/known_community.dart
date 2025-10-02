/// Some well-known communities where we define a fixed rate of CC -> local fiat,
/// and then USD with an applied discount.

import 'package:encointer_wallet/service/forex/currency.dart';

const num _leuPerChf = 1;
const num _nytPerTzs = 2;
const num _pnqPerNgn = 2;

const double _defaultDiscount = 0.2;

enum KnownCommunity {
  leu(symbol: 'leu', fiatCurrency: Currency.chf, localFiatRate: _leuPerChf, discount: _defaultDiscount),
  nyt(symbol: 'nyt', fiatCurrency: Currency.tzs, localFiatRate: _nytPerTzs, discount: _defaultDiscount),
  pnq(symbol: 'pnq', fiatCurrency: Currency.ngn, localFiatRate: _pnqPerNgn, discount: _defaultDiscount);

  const KnownCommunity({
    required this.symbol,
    required this.fiatCurrency,
    required this.localFiatRate,
    required this.discount,
  });

  // Community symbol
  final String symbol;
  // Local fiat
  final Currency fiatCurrency;
  // How many CC per 1 unit local fiat ([LocalFiat/CC])
  final num localFiatRate;
  // Discount applied
  final double discount;

  // Lookup map
  static final Map<String, KnownCommunity> _lookup = {for (var c in KnownCommunity.values) c.symbol.toLowerCase(): c};

  static KnownCommunity? tryFromSymbol(String symbol) => _lookup[symbol.toLowerCase()];

  static bool isKnown(String symbol) => _lookup.containsKey(symbol.toLowerCase());
}

extension UsdRateExtension on KnownCommunity {
  /// [CC/LocalFiat] * [localFiat/USD] * discount
  ///
  /// [usdRate] needs to be in [localFiat/USD]
  double ccPerUsd(double usdRate) {
    return (1 / localFiatRate) * usdRate * (1 - discount);
  }
}
