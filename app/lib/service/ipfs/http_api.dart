import 'dart:convert';

import 'package:http/http.dart';

import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/service/log/log_service.dart';

class HttpApi {
  const HttpApi(Client client, {this.gateway = ipfsGatewayEncointer}) : _client = client;

  final Client _client;
  final String gateway;

  static const String getRequest = '/api/v0/object/get?arg=';

  Future<String?> getCommunityIcon(String cid) async {
    if (cid.isEmpty) {
      Log.d('[IPFS] return default encointer icon because ipfs-cid is not set', 'Ipfs');
      return null;
    }
    try {
      final uri = Uri.parse('$gateway/$getRequest$cid/$communityIconName');
      final response = await _client.get(uri).timeout(const Duration(seconds: 8));
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      return body['Data'] as String?;
    } catch (e, s) {
      Log.e('$e', 'Ipfs', s);
      return null;
    }
  }
}
