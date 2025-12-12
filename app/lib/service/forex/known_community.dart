/// Some well-known communities where we define a fixed rate of CC -> local fiat,
/// and then USD with an applied discount.

import 'package:encointer_wallet/service/forex/currency.dart';

const num _leuPerChf = 1;
const num _nytPerTzs = 0.001;
const num _pnqPerNgn = 0.001;

const double _defaultMarkup = 0.02;

enum KnownCommunity {
  leu(symbol: 'leu', fiatCurrency: Currency.chf, localFiatRate: _leuPerChf, markup: _defaultMarkup),
  nyt(symbol: 'nyt', fiatCurrency: Currency.tzs, localFiatRate: _nytPerTzs, markup: _defaultMarkup),
  pnq(symbol: 'pnq', fiatCurrency: Currency.ngn, localFiatRate: _pnqPerNgn, markup: _defaultMarkup);

  const KnownCommunity({
    required this.symbol,
    required this.fiatCurrency,
    required this.localFiatRate,
    required this.markup,
  });

  // Community symbol
  final String symbol;
  // Local fiat
  final Currency fiatCurrency;
  // How many CC per 1 unit local fiat ([LocalFiat/CC])
  final num localFiatRate;
  // Markup applied
  final double markup;

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
    return (1 / localFiatRate) * usdRate * (1 + markup);
  }
}
