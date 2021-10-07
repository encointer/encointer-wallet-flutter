import 'package:encointer_wallet/store/encointer/types/bazaar.dart';
import 'package:encointer_wallet/mocks/data/mockBazaarData.dart';
import 'package:flutter/material.dart';

class BazaarIpfsApiMock {

  static Future<IpfsBusiness> getBusiness(String ipfsCid) {
    return Future.value(ipfsBusinesses[ipfsCid]);
  }


  static Future<List<IpfsOffering>> getOfferings(List<String> ipfsCids) {
     return Future.value([]);
  }

  /// Image path in mock. Ipfs cid in real api
  static Future<List<Image>> getImage(String imagePath) {
    return Future.value([Image.asset(imagePath)]);
  }
}