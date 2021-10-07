import 'package:encointer_wallet/store/encointer/types/bazaar.dart';
import 'package:encointer_wallet/mocks/data/mockBazaarData.dart';
import 'package:flutter/material.dart';

class BazaarIpfsApiMock {

  Future<List<IpfsBusiness>> getBusinesses(List<String> ipfsCids) {
    return Future.value(allMockIpfsBusinesses);
  }


  Future<List<IpfsOffering>> getOfferings(List<String> ipfsCids) {
     return Future.value(allMockIpfsOfferings);
  }

  /// Image path in mock. Ipfs cid in real api
  Future<List<Image>> getImage(String imagePath) {
    return Future.value([Image.asset(imagePath)]);
  }
}