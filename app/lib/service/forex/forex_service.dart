/// Forex service for fetching the rates for some well-known communities to USD
///
/// Other base currencies can also be used.

import 'dart:convert';
import 'package:encointer_wallet/service/forex/currency.dart';
import 'package:ew_log/ew_log.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

const String logTarget = 'ForexService';

class ForexService {
  ForexService({
    this.cacheDuration = const Duration(days: 1),
    this.preferStale = true,
    http.Client? client,
  }) : _client = client ?? http.Client();

  static const _primaryBaseUrl = 'https://cdn.jsdelivr.net/npm/@fawazahmed0/currency-api@latest/v1/currencies';
  static const _fallbackBaseUrl = 'https://cdn.statically.io/gh/fawazahmed0/exchange-api/latest/v1/currencies';

  final Duration cacheDuration;
  final bool preferStale;
  final Map<String, _CacheEntry> _cache = {};
  final http.Client _client;

  /// Generic method: fetch exchange rate from [base] to [target].
  Future<ForexRate?> getRate(Currency base, Currency target) async {
    final baseIsoCode = base.isoCodeLower;
    final targetIsoCode = target.isoCodeLower;
    final cacheKey = '$baseIsoCode-$targetIsoCode';

    final prefs = await SharedPreferences.getInstance();

    // 1. In-memory cache
    final cached = _cache[cacheKey];
    if (cached != null) {
      final fresh = DateTime.now().isBefore(cached.expiry);
      if (fresh) {
        return ForexRate(
          value: cached.value,
          fetchedAt: cached.fetchedAt,
          isStale: false,
        );
      }
    }

    // 2. Persistent cache
    final storedJson = prefs.getString('forex_$cacheKey');
    _CacheEntry? stored;
    if (storedJson != null) {
      stored = _CacheEntry.fromJson(json.decode(storedJson) as Map<String, dynamic>);
      final fresh = DateTime.now().isBefore(stored.expiry);
      if (fresh) {
        _cache[cacheKey] = stored;
        return ForexRate(
          value: stored.value,
          fetchedAt: stored.fetchedAt,
          isStale: false,
        );
      }
    }

    // 3. Fetch from API
    final primaryUrl = Uri.parse('$_primaryBaseUrl/$baseIsoCode.json');
    final fallbackUrl = Uri.parse('$_fallbackBaseUrl/$baseIsoCode.json');

    var rate = await _fetchRateFromUrl(primaryUrl, base, target);
    rate ??= await _fetchRateFromUrl(fallbackUrl, base, target);

    if (rate != null) {
      final entry = _CacheEntry(
        value: rate,
        expiry: DateTime.now().add(cacheDuration),
        fetchedAt: DateTime.now(),
      );
      _cache[cacheKey] = entry;
      await prefs.setString('forex_$cacheKey', json.encode(entry.toJson()));
      return ForexRate(value: entry.value, fetchedAt: entry.fetchedAt, isStale: false);
    }

    // 4. Stale fallback
    if (preferStale) {
      final entry = cached ?? stored;
      if (entry != null) {
        return ForexRate(
          value: entry.value,
          fetchedAt: entry.fetchedAt,
          isStale: true,
        );
      }
    }

    return null;
  }

  /// Convenience wrapper: always use USD as base.
  Future<ForexRate?> getUsdRate(Currency target) => getRate(Currency.usd, target);

  Future<double?> _fetchRateFromUrl(Uri url, Currency base, Currency target) async {
    final baseIsoCode = base.isoCodeLower;
    final targetIsoCode = target.isoCodeLower;

    try {
      final resp = await _client.get(url);
      if (resp.statusCode == 200) {
        Log.d('Response: ${resp.body}', logTarget);
        // Cast the decoded JSON to the expected structure
        final data = json.decode(resp.body) as Map<String, dynamic>?;

        if (data != null && data.containsKey(baseIsoCode)) {
          // 'baseValue' will be dynamic, needs further checking/casting
          final baseValue = data[baseIsoCode];
          if (baseValue is Map<String, dynamic> && baseValue.containsKey(targetIsoCode)) {
            // 'targetValue' will be dynamic, needs further checking/casting
            final targetValue = baseValue[targetIsoCode];
            if (targetValue is num) {
              return targetValue.toDouble();
            }
          }
        }
        Log.e('Could not find currency in response. Data structure unexpected.', logTarget);
      } else {
        Log.e('Received non-200 status: ${resp.statusCode} from $url', logTarget);
      }
    } catch (e) {
      Log.e('Error fetching rate from $url: $e', logTarget);
    }
    return null;
  }
}

/// Public-facing object returned by ForexService
class ForexRate {
  ForexRate({
    required this.value,
    required this.fetchedAt,
    required this.isStale,
  });
  final double value;
  final DateTime fetchedAt;
  final bool isStale;
}

class _CacheEntry {
  _CacheEntry({
    required this.value,
    required this.expiry,
    required this.fetchedAt,
  });

  factory _CacheEntry.fromJson(Map<String, dynamic> json) {
    return _CacheEntry(
      value: (json['value'] as num).toDouble(),
      expiry: DateTime.parse(json['expiry'] as String),
      fetchedAt: DateTime.parse(json['fetchedAt'] as String),
    );
  }
  final double value;
  final DateTime expiry;
  final DateTime fetchedAt;

  Map<String, dynamic> toJson() => {
        'value': value,
        'expiry': expiry.toIso8601String(),
        'fetchedAt': fetchedAt.toIso8601String(),
      };
}
