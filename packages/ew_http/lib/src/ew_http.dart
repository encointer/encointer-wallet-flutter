import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:ew_http/src/exception/http_exception.dart';

typedef TokenProvider = Future<String?> Function();
typedef FromJsonM<T> = T Function(Map<String, dynamic>);

class EwHttp {
  EwHttp({
    http.Client? client,
    String baseUrl = 'api.encointer.org',
    TokenProvider? tokenProvider,
  })  : _client = client ?? http.Client(),
        _baseUrl = baseUrl,
        _tokenProvider = tokenProvider;

  final http.Client _client;
  final String _baseUrl;
  final TokenProvider? _tokenProvider;

  Future<T> get<T>(String path, {required FromJsonM<T> fromJson}) async {
    try {
      final uri = Uri.parse('$_baseUrl/$path');
      final response = await _client.get(uri, headers: await _getRequestHeaders());
      return fromJson(response.jsonBody());
    } catch (e, s) {
      throw HttpStatusException(statusCode: 101, error: e, stackTrace: s);
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
  Map<String, dynamic> jsonBody() {
    try {
      return jsonDecode(body) as Map<String, dynamic>;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(error, stackTrace);
    }
  }
}
