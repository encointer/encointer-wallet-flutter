/// Simple mock to return some hardcoded data used in the bazaar UI.
import 'package:encointer_wallet/mocks/data/mock_bazaar_data.dart';
import 'package:encointer_wallet/models/bazaar/ipfs_business.dart';
import 'package:encointer_wallet/models/bazaar/ipfs_offering.dart';
import 'package:flutter/material.dart';

class MockIpfsBazaarApi {
  /// get the business that lives at the specified [ipfsCid].
  /// In the real api this might be the full ipfs url.
  static Future<IpfsBusiness> getBusiness(String ipfsCid) {
    return Future.value(ipfsBusinesses[ipfsCid]);
  }

  /// get the Offering that lives at the specified [ipfsCid].
  /// In the real api this might be the full ipfs url.
  static Future<IpfsOffering> getOffering(String ipfsCid) {
    // todo: @armin: This is not used currently but you'd probably need this soon
    return Future.value(ipfsOfferings[ipfsCid]);
  }

  /// Image path in mock. Ipfs cid in real api
  static Future<List<Image>> getImage(String imagePath) {
    // todo: @armin: This is not used currently but you'd probably need this soon
    return Future.value([Image.asset(imagePath)]);
  }
}
