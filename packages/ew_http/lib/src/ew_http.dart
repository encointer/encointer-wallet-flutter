import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:ew_http/src/exceptions/exceptions.dart';
import 'package:ew_http/src/interface/either.dart';

typedef TokenProvider = Future<String?> Function();
typedef FromJson<T> = T Function(Map<String, dynamic>);

class EwHttp {
  EwHttp({http.Client? client, TokenProvider? tokenProvider})
      : _client = client ?? http.Client(),
        _tokenProvider = tokenProvider;

  final http.Client _client;
  final TokenProvider? _tokenProvider;

  Future<Either<T, Exception>> get<T>(String url) async {
    try {
      final uri = Uri.parse(url);
      final response = await _client.get(uri, headers: await _getRequestHeaders());
      if (response.statusCode == HttpStatus.ok) return Right(response.decode<T>());
      return Left(HttpRequestException(statusCode: response.statusCode));
    } catch (e, s) {
      return Left(HttpRequestException(error: e, stackTrace: s));
    }
  }

  Future<Either<T, Exception>> getType<T>(String url, {required FromJson<T> fromJson}) async {
    try {
      final data = await get<Map<String, dynamic>>(url);
      return data.fold(Left.new, (r) => Right(fromJson(r)));
    } catch (e, s) {
      return Left(JsonDeserializationException(error: e, stackTrace: s));
    }
  }

  Future<Either<List<T>, Exception>> getTypeList<T>(String url, {required FromJson<T> fromJson}) async {
    try {
      final data = await get<List<dynamic>>(url);
      return data.fold(Left.new, (r) => Right(r.map((e) => fromJson(e as Map<String, dynamic>)).toList()));
    } catch (e, s) {
      return Left(JsonDeserializationException(error: e, stackTrace: s));
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
