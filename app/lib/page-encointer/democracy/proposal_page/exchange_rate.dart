import 'package:encointer_wallet/service/forex/currency.dart';

// Hardcoded exchange rates of CC to the local national currency.
const num leuPerChf = 2;
const num nytPerTzs = 2;
const num pnqPerNgn = 2;

const leu = 'leu';
const pnq = 'pnq';
const nyt = 'nyt';

const discount = 0.2;

enum KnownCommunity {
  leu,
  nyt,
  pnq,
}

extension KnownCommunityExt on KnownCommunity {
  Currency get localFiatCurrency {
    return switch (this) {
      KnownCommunity.leu => Currency.chf,
      KnownCommunity.nyt => Currency.tzs,
      KnownCommunity.pnq => Currency.ngn,
    };
  }

  String get symbol {
    return switch (this) {
      KnownCommunity.leu => leu,
      KnownCommunity.nyt => nyt,
      KnownCommunity.pnq => pnq,
    };
  }

  num get ccPerFiatRate {
    return switch (this) {
      KnownCommunity.leu => leuPerChf,
      KnownCommunity.nyt => nytPerTzs,
      KnownCommunity.pnq => pnqPerNgn,
    };
  }
}

bool isKnownCommunity(String symbol) {
  return KnownCommunity.values.map((e) => e.symbol).contains(symbol.toLowerCase());
}

KnownCommunity knownCommunityFromMetadata(String symbol) {
  return switch (symbol.toLowerCase()) {
    leu => KnownCommunity.leu,
    nyt => KnownCommunity.nyt,
    pnq => KnownCommunity.pnq,
    _ => throw Exception('Unknown community symbol: $symbol')
  };
}
