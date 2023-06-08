import 'dart:convert';
import 'dart:io';

import 'package:ew_http/ew_http.dart';
import 'package:http/http.dart' as http;

typedef TokenProvider = Future<String?> Function();
typedef FromJson<T> = T Function(Map<String, dynamic>);

class EwHttp {
  EwHttp({http.Client? client, TokenProvider? tokenProvider})
      : _client = client ?? http.Client(),
        _tokenProvider = tokenProvider;

  final http.Client _client;
  final TokenProvider? _tokenProvider;

  Future<Either<T, EwHttpException>> get<T>(String url) async {
    try {
      final uri = Uri.parse(url);
      final response = await _client.get(uri, headers: await _getRequestHeaders());
      if (response.statusCode == HttpStatus.ok) return Right(response.decode<T>());
      return Left(_returnErrorResponse(response));
    } catch (e, s) {
      return Left(EwHttpException(FailureType.unknown, error: e, stackTrace: s));
    }
  }

  Future<Either<T, EwHttpException>> getType<T>(String url, {required FromJson<T> fromJson}) async {
    try {
      final data = await get<Map<String, dynamic>>(url);
      return data.fold(Left.new, (r) => Right(fromJson(r)));
    } catch (e, s) {
      return Left(EwHttpException(FailureType.decode, error: e, stackTrace: s));
    }
  }

  Future<Either<List<T>, EwHttpException>> getTypeList<T>(String url, {required FromJson<T> fromJson}) async {
    try {
      final data = await get<List<dynamic>>(url);
      return data.fold(Left.new, (r) => Right(r.map((e) => fromJson(e as Map<String, dynamic>)).toList()));
    } catch (e, s) {
      return Left(EwHttpException(FailureType.deserialization, error: e, stackTrace: s));
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

  EwHttpException _returnErrorResponse(Response response) {
    return switch (response.statusCode) {
      400 => EwHttpException(FailureType.badRequest, statusCode: response.statusCode),
      401 => EwHttpException(FailureType.noAuthorization, statusCode: response.statusCode),
      403 => EwHttpException(FailureType.forbidden, statusCode: response.statusCode),
      500 => EwHttpException(FailureType.internalServer, statusCode: response.statusCode),
      _ => EwHttpException(FailureType.unknown, error: response.statusCode, statusCode: response.statusCode),
    };
  }
}

extension on http.Response {
  T decode<T>() {
    try {
      return jsonDecode(body) as T;
    } catch (e, s) {
      throw EwHttpException(FailureType.decode, error: e, stackTrace: s);
    }
  }
}
