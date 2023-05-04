import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:encointer_wallet/data/common_services/models/network/api_response.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

const _logTarget = 'api_services';

typedef TokenProvider = Future<String?> Function();

class ApiServices {
  ApiServices({
    required String baseUrl,
    required http.Client client,
    TokenProvider? tokenProvider,
  })  : _baseUrl = baseUrl,
        _client = client,
        _tokenProvider = tokenProvider {
    _init();
  }

  late final http.Client _client;
  late final String _baseUrl;
  late final TokenProvider? _tokenProvider;
  final _clientCompleter = Completer<http.Client>();

  Future<void> _init() async {
    Log.d(_logTarget, '_init: _baseUrl = $_baseUrl, _client = $_client');

    final uri = Uri.tryParse(_baseUrl);
    if (uri == null) {
      throw Exception(['Not connected to the server, please try again!']);
    } else {
      await _client.head(
        uri,
        headers: await _getRequestHeaders(),
      );
    }

    _clientCompleter.complete(_client);
  }

  Future<Map<String, String>> _getRequestHeaders() async {
    final token = _tokenProvider != null ? await _tokenProvider!() : null;
    return <String, String>{
      HttpHeaders.contentTypeHeader: ContentType.json.value,
      HttpHeaders.acceptHeader: ContentType.json.value,
      if (token != null) HttpHeaders.authorizationHeader: 'Bearer $token',
    };
  }

  Future<ApiResponse> get({required String endpoint}) async {
    final uri = Uri.tryParse(_baseUrl + endpoint);
    if (uri == null) {
      throw Exception(['Not connected to the server, please try again!']);
    } else {
      return _executeQuery((client) => client.get(uri));
    }
  }

  Future<ApiResponse> _executeQuery(
    Future<Response> Function(http.Client client) function,
  ) async {
    late final Response response;
    response = await _clientCompleter.future.then(function);
    return _returnResponse(response);
  }

  ApiResponse _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        final responseJson = json.decode(response.body);
        return Success(data: responseJson);
      case 400:
        return Failure(error: 'Bad Request Error');
      case 401:
      case 403:
        return Failure(error: 'You have no authorization!');
      case 500:
      default:
        return Failure(
          error: 'Something went wrong with the server, please try again. StatusCode: ${response.statusCode}',
        );
    }
  }
}
