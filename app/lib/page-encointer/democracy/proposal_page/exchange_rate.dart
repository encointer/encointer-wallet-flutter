import 'package:encointer_wallet/service/forex/currency.dart';

/// Hardcoded exchange rates of CC to local fiat
const num _leuPerChf = 2;
const num _nytPerTzs = 2;
const num _pnqPerNgn = 2;

/// Discount applied to communities (can be per-community if needed)
const double _defaultDiscount = 0.2;

enum KnownCommunity {
  leu(
    symbol: 'leu',
    localFiat: Currency.chf,
    ccPerFiatRate: _leuPerChf,
    discount: _defaultDiscount,
  ),
  nyt(
    symbol: 'nyt',
    localFiat: Currency.tzs,
    ccPerFiatRate: _nytPerTzs,
    discount: _defaultDiscount,
  ),
  pnq(
    symbol: 'pnq',
    localFiat: Currency.ngn,
    ccPerFiatRate: _pnqPerNgn,
    discount: _defaultDiscount,
  );

  const KnownCommunity({
    required this.symbol,
    required this.localFiat,
    required this.ccPerFiatRate,
    required this.discount,
  });

  /// Community symbol (e.g., 'leu', 'nyt', 'pnq')
  final String symbol;

  /// Local fiat currency
  final Currency localFiat;

  /// CC per fiat exchange rate
  final num ccPerFiatRate;

  /// Discount for this community
  final double discount;

  /// Lookup map by symbol (lowercase)
  static final Map<String, KnownCommunity> _lookup = {for (var c in KnownCommunity.values) c.symbol.toLowerCase(): c};

  /// Safe lookup by symbol (returns null if unknown)
  static KnownCommunity? tryFromSymbol(String symbol) => _lookup[symbol.toLowerCase()];

  /// Check if a symbol belongs to a known community
  static bool isKnown(String symbol) => _lookup.containsKey(symbol.toLowerCase());
}
