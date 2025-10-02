/// Some well-known fiat currencies used as base or lookup.

enum Currency {
  usd('USD', r'$'),
  eur('EUR', '€'),
  chf('CHF', 'CHF'),
  ngn('NGN', '₦'),
  tzs('TZS', 'TSh');

  const Currency(this.isoCode, this.symbol);

  /// ISO 4217 alphabetic code (standard uppercase)
  final String isoCode;

  /// Display symbol
  final String symbol;

  /// Lowercase ISO code for API calls
  String get isoCodeLower => isoCode.toLowerCase();

  // Lookup map by uppercase ISO code (case-insensitive)
  static final Map<String, Currency> _lookup = {
    for (var c in Currency.values) c.isoCode.toLowerCase(): c,
  };

  /// Safe lookup
  static Currency? tryFromIso(String code) => _lookup[code.toLowerCase()];

  /// All ISO codes (uppercase)
  static List<String> get allIsoCodes => Currency.values.map((c) => c.isoCode).toList();
}
