import 'package:flutter_test/flutter_test.dart';

import 'package:encointer_wallet/mocks/mock_bazaar_data.dart';
import 'package:encointer_wallet/page-encointer/bazaar/single_business/logic/single_business_store.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/fetch_status.dart';

import '../../mock/api/mock_api.dart';
import '../../mock/storage/mock_local_storage.dart';

void main() {
  late SingleBusinessStore businessesStore;

  setUp(() async {
    webApi = getMockApi(AppStore(MockLocalStorage()), withUI: false);
    await webApi.init();

    businessesStore = SingleBusinessStore(businessesMockForSingleBusiness, cidEdisonPaula);
  });

  group('SingleBusinessStore Test', () {
    test('`getSingleBusiness()` should update fetchStatus to success and populate ipfsProducts list and singleBusiness',
        () async {
      expect(businessesStore.fetchStatus, FetchStatus.loading);
      expect(businessesStore.singleBusiness, isNull);

      await businessesStore.getSingleBusiness();

      expect(businessesStore.fetchStatus, FetchStatus.success);
      expect(businessesStore.singleBusiness, isNotNull);
      expect(businessesStore.singleBusiness!.name, businessesMockForSingleBusiness.name);

      expect(businessesStore.ipfsProducts, isNotNull);
      expect(businessesStore.ipfsProducts.length, greaterThan(0));
    });

    test('`toggleLikes()` test likes', () async {
      expect(businessesStore.isLiked, false);

      businessesStore.toggleLikes();

      expect(businessesStore.isLiked, isNotNull);
      expect(businessesStore.isLiked, isNot(!businessesStore.isLiked));
    });

    test('`toggleOwnLikes()` test own likes', () async {
      expect(businessesStore.isLikedPersonally, false);

      businessesStore.toggleOwnLikes();

      expect(businessesStore.isLikedPersonally, isNotNull);
      expect(businessesStore.isLikedPersonally, isNot(!businessesStore.isLikedPersonally));
    });
  });
}
