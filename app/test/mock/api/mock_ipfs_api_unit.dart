import 'package:encointer_wallet/mocks/ipfs_api.dart';
import 'package:encointer_wallet/mocks/mock_bazaar_data.dart';
import 'package:encointer_wallet/models/bazaar/ipfs_business.dart';

/// Unit-test-only mock that returns canned business data.
///
/// The base [MockIpfsApi] (in app/lib/mocks/) intentionally does NOT
/// override [getIpfsBusiness] so that integration tests hit real IPFS.
/// See https://github.com/encointer/encointer-wallet-flutter/issues/1982
class MockIpfsApiUnit extends MockIpfsApi {
  MockIpfsApiUnit(super.httpClient, {super.gateway});

  @override
  Future<IpfsBusiness> getIpfsBusiness(String businessIpfsCid) {
    return Future.value(IpfsBusiness.fromJson(Map<String, dynamic>.from(mockBusinessData)));
  }
}
