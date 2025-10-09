import 'package:encointer_wallet/models/bazaar/ipfs_business.dart';
import 'package:ew_http/ew_http.dart';

import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/service/log/log_service.dart';

class IpfsApi {
  const IpfsApi(this.ewHttp, {this.gateway = encointerIpfsUrl});

  final EwHttp ewHttp;
  final String gateway;

  static const String getRequest = '/api/v0/object/get?arg=';

  Future<String?> getCommunityIcon(String ipfsCid) async {
    if (ipfsCid.isEmpty) {
      Log.d('[IPFS] return default encointer icon because ipfs-cid is not set', 'Ipfs');
      return null;
    }

    return getFromIpfsFolder(ipfsCid, communityIconName);
  }

  Future<Either<IpfsBusiness, EwHttpException>> getBusinessesIpfs(String ipfsCid) async {
    return ewHttp.getType(ipfsUrl(ipfsCid), fromJson: IpfsBusiness.fromJson);
  }

  Future<String?> getFromIpfsFolder(String folderCid, String assetName) async {
    final response = await ewHttp.get<String>('$gateway/$folderCid/$assetName');
    return response.fold((l) {
      Log.e('[getFromIpfsFolder] error: $l', 'Ipfs');
      return null;
    }, (r) => r);
  }
}
