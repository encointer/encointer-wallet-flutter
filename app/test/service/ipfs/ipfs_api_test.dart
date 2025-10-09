import 'package:encointer_wallet/models/bazaar/ipfs_business.dart';
import 'package:encointer_wallet/page-encointer/bazaar/businesses/widgets/dropdown_widget.dart';
import 'package:encointer_wallet/service/ipfs/ipfs_api.dart';
import 'package:ew_http/ew_http.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../utils/test_tags.dart';

void main() {
  // Test that we can access the files added in:
  //
  // https://github.com/encointer/encointer-node/pull/404
  group('Ipfs Api', () {
    test('Can well-known-business', () async {
      final ipfsApi = IpfsApi(EwHttp());

      const businessIpfsCid = 'QmTvnruvcgvcW9K5AN4p47mwcDQytaBckNzndvRzNnEHx6';
      final result = await ipfsApi.getIpfsBusiness(businessIpfsCid);

      final expectedBusiness = IpfsBusiness(
        name: 'Revamp-IT',
        description: 'Computersupport und -dienste',
        category: Category.iTHardware,
        address: 'Birmensdorferstrasse 379, 8055 Zürich',
        longitude: '8.5049619',
        latitude: '47.3690377',
        openingHours: 'Mon 9h-12h, Tue-Fri 13h-17h',
        logo: 'QmbAsammnMX41xiJPVVhLTQB6UaMPyYPFgpZVg8qBTGWNE',
        photos: 'QmasSnnY6w6tMYYFzC5xaHa9GrhmeZ99aGx3eXD2rqpz8b',
      );

      expect(result.toJson(), expectedBusiness.toJson());
    }, tags: productionE2E);

    test('Can get logo of well-known-business', () async {
      final ipfsApi = IpfsApi(EwHttp());

      final result = await ipfsApi.getFileFromFolder('QmbAsammnMX41xiJPVVhLTQB6UaMPyYPFgpZVg8qBTGWNE', 'logo.png');

      expect(result != null, true);
    }, tags: productionE2E);


    test('Can list asset folder', () async {
      final ipfsApi = IpfsApi(EwHttp());

      final result = await ipfsApi.listFolderRecursive('QmasSnnY6w6tMYYFzC5xaHa9GrhmeZ99aGx3eXD2rqpz8b');
      // Yes, the files to have different extensions
      expect(result, ['image01.png', 'image02.jpg', 'image03.jpg']);
    }, tags: productionE2E);
  });
}
