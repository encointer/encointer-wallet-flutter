import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

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

  // -------------------- GET --------------------

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
    final data = await get<Map<String, dynamic>>(url);
    return data.fold(
      Left.new,
      (r) {
        try {
          return Right(fromJson(r));
        } catch (e, s) {
          return Left(
            EwHttpException(
              FailureType.decode,
              error: e,
              moreErrorData: r,
              stackTrace: s,
            ),
          );
        }
      },
    );
  }

  Future<Either<List<T>, EwHttpException>> getTypeList<T>(String url, {required FromJson<T> fromJson}) async {
    final data = await get<List<dynamic>>(url);
    return data.fold(
      Left.new,
      (r) {
        try {
          final list = r.map((result) => fromJson(result as Map<String, dynamic>)).toList();
          return Right(list);
        } catch (e, s) {
          return Left(
            EwHttpException(
              FailureType.decode,
              error: e,
              moreErrorData: r,
              stackTrace: s,
            ),
          );
        }
      },
    );
  }

  /// Fetch raw bytes (e.g., IPFS file, image, audio).
  Future<Either<Uint8List, EwHttpException>> getBytes(String url) async {
    try {
      final uri = Uri.parse(url);
      final response = await _client.get(uri, headers: await _getRequestHeaders());
      if (response.statusCode == HttpStatus.ok) {
        return Right(response.bodyBytes);
      }
      return Left(_returnErrorResponse(response));
    } catch (e, s) {
      return Left(EwHttpException(FailureType.unknown, error: e, stackTrace: s));
    }
  }

  // -------------------- POST --------------------

  /// Standard POST expecting JSON response
  Future<Either<T, EwHttpException>> post<T>(String url, {Object? body}) async {
    try {
      final uri = Uri.parse(url);
      final response = await _client.post(
        uri,
        headers: await _getRequestHeaders(),
        body: body == null ? null : jsonEncode(body),
      );
      if (response.statusCode == HttpStatus.ok) {
        return Right(response.decode<T>());
      }
      return Left(_returnErrorResponse(response));
    } catch (e, s) {
      return Left(EwHttpException(FailureType.unknown, error: e, stackTrace: s));
    }
  }

  /// POST returning binary data (useful for IPFS /api/v0/ calls).
  Future<Either<Uint8List, EwHttpException>> postBytes(String url, {Map<String, dynamic>? body}) async {
    try {
      final uri = Uri.parse(url);
      final response = await _client.post(
        uri,
        headers: await _getRequestHeaders(),
        body: body == null ? null : jsonEncode(body),
      );
      if (response.statusCode == HttpStatus.ok) {
        return Right(response.bodyBytes);
      }
      return Left(_returnErrorResponse(response));
    } catch (e, s) {
      return Left(EwHttpException(FailureType.unknown, error: e, stackTrace: s));
    }
  }

  Future<Either<T, EwHttpException>> postForm<T>(
    String url, {
    required T Function(http.Response) decodeResponse,
    Map<String, String>? fields,
  }) async {
    try {
      final uri = Uri.parse(url);
      final request = http.MultipartRequest('POST', uri)..fields.addAll(fields ?? {});
      final streamed = await request.send();
      final response = await http.Response.fromStream(streamed);

      if (response.statusCode == HttpStatus.ok) {
        return Right(decodeResponse(response));
      }

      return Left(_returnErrorResponse(response));
    } catch (e, s) {
      return Left(EwHttpException(FailureType.unknown, error: e, stackTrace: s));
    }
  }

  // -------------------- Helpers --------------------

  Future<Map<String, String>> _getRequestHeaders() async {
    final token = await _tokenProvider?.call();
    return <String, String>{
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
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

// -------------------- Extensions --------------------

extension on http.Response {
  T decode<T>() {
    try {
      return jsonDecode(utf8.decode(bodyBytes)) as T;
    } catch (e, s) {
      throw EwHttpException(FailureType.decode, error: e, stackTrace: s);
    }
  }
}
