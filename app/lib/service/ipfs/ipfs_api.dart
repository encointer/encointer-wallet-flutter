import 'package:ew_http/ew_http.dart';

import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/service/log/log_service.dart';

class IpfsApi {
  const IpfsApi(this.ewHttp, {this.gateway = ipfsGatewayEncointer});

  final EwHttp ewHttp;
  final String gateway;

  static const String getRequest = '/api/v0/object/get?arg=';

  Future<String?> getCommunityIcon(String cid) async {
    if (cid.isEmpty) {
      Log.d('[IPFS] return default encointer icon because ipfs-cid is not set', 'Ipfs');
      return null;
    }
    final data = await ewHttp.get<Map<String, dynamic>>('$gateway/$getRequest$cid/$communityIconName');
    return data?['Data'] as String?;
  }
}
