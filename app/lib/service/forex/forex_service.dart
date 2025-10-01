import 'dart:convert';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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
  Future<ForexRate?> getRate(String base, String target) async {
    final baseNormalized = base.toLowerCase();
    final targetNormalized = target.toLowerCase();
    final cacheKey = '$baseNormalized-$targetNormalized';

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
    final primaryUrl = Uri.parse('$_primaryBaseUrl/$baseNormalized.json');
    final fallbackUrl = Uri.parse('$_fallbackBaseUrl/$baseNormalized.json');

    var rate = await _fetchRateFromUrl(primaryUrl, baseNormalized, targetNormalized);
    rate ??= await _fetchRateFromUrl(fallbackUrl, baseNormalized, targetNormalized);

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
  Future<ForexRate?> getUsdRate(String target) => getRate('usd', target);

  Future<double?> _fetchRateFromUrl(Uri url, String base, String target) async {
    try {
      final resp = await _client.get(url);
      if (resp.statusCode == 200) {
        final data = json.decode(resp.body);
        if (data is Map && data.containsKey(base) && data[base] is Map && data[base][target] is num) {
          return (data[base][target] as num).toDouble();
        }
      }
    } catch (e) {
      Log.e('Error fetching rate from $url: $e', 'ForexService');
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
