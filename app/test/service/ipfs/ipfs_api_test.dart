import 'package:encointer_wallet/service/ipfs/ipfs_api.dart';
import 'package:ew_http/ew_http.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../utils/test_tags.dart';

void main() {
  group('Ipfs Api', () {
    test('Can get logo of well-known-business', () async {
      final ipfsApi = IpfsApi(EwHttp());

      final result = await ipfsApi.getFromIpfsFolder('QmbAsammnMX41xiJPVVhLTQB6UaMPyYPFgpZVg8qBTGWNE', 'logo.png');

      expect(result != null, true);
    }, tags: productionE2E);
  });
}
