import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:ew_http/src/exception/http_exception.dart';

typedef TokenProvider = Future<String?> Function();
typedef FromJson<T> = T Function(Map<String, dynamic>);

class EwHttp {
  EwHttp({http.Client? client, TokenProvider? tokenProvider})
      : _client = client ?? http.Client(),
        _tokenProvider = tokenProvider;

  final http.Client _client;
  final TokenProvider? _tokenProvider;

  Future<T> get<T>(String url, {required FromJson<T> fromJson}) async {
    try {
      final uri = Uri.parse(url);
      final response = await _client.get(uri, headers: await _getRequestHeaders());
      return fromJson(response.decode());
    } catch (e, s) {
      throw HttpStatusException(error: e, stackTrace: s);
    }
  }

  Future<List<T>> getList<T>(String url, {required FromJson<T> fromJson}) async {
    try {
      final uri = Uri.parse(url);
      final response = await _client.get(uri, headers: await _getRequestHeaders());
      final body = response.decode<List<dynamic>>();
      return body.map((e) => fromJson(e as Map<String, dynamic>)).toList();
    } catch (e, s) {
      throw HttpStatusException(error: e, stackTrace: s);
    }
  }

  Future<Map<String, String>> _getRequestHeaders() async {
    final token = _tokenProvider != null ? await _tokenProvider!() : null;
    return <String, String>{
      HttpHeaders.contentTypeHeader: ContentType.json.value,
      HttpHeaders.acceptHeader: ContentType.json.value,
      if (token != null) HttpHeaders.authorizationHeader: 'Bearer $token',
    };
  }
}

extension on http.Response {
  T decode<T>() {
    try {
      return jsonDecode(body) as T;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(error, stackTrace);
    }
  }
}
