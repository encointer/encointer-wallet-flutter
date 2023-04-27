import 'package:http/http.dart' as http;

class EwHttp {
  EwHttp([http.Client? client]) : _client = client ?? http.Client();

  final http.Client _client;

  
}
