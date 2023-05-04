import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:ew_http/src/exceptions/exceptions.dart';

typedef TokenProvider = Future<String?> Function();
typedef FromJson<T> = T Function(Map<String, dynamic>);

class EwHttp {
  EwHttp({http.Client? client, TokenProvider? tokenProvider})
      : _client = client ?? http.Client(),
        _tokenProvider = tokenProvider;

  final http.Client _client;
  final TokenProvider? _tokenProvider;

  Future<T> get<T>(String url) async {
    try {
      final uri = Uri.parse(url);
      final response = await _client.get(uri, headers: await _getRequestHeaders());
      if (response.statusCode != HttpStatus.ok) {
        throw HttpRequestException(statusCode: response.statusCode);
      }
      return response.decode<T>();
    } catch (e, s) {
      throw HttpRequestException(error: e, stackTrace: s);
    }
  }

  Future<T> getType<T>(String url, {required FromJson<T> fromJson}) async {
    try {
      final data = await get<Map<String, dynamic>>(url);
      return fromJson(data);
    } catch (e, s) {
      throw JsonDeserializationException(error: e, stackTrace: s);
    }
  }

  Future<List<T>> getTypeList<T>(String url, {required FromJson<T> fromJson}) async {
    try {
      final data = await get<List<dynamic>>(url);
      return data.map((e) => fromJson(e as Map<String, dynamic>)).toList();
    } catch (e, s) {
      throw JsonDeserializationException(error: e, stackTrace: s);
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
    } catch (e, s) {
      throw JsonDecodeException(error: e, stackTrace: s);
    }
  }
}
