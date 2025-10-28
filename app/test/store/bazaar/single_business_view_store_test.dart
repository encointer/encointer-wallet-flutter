import 'package:flutter_test/flutter_test.dart';

import 'package:encointer_wallet/mocks/mock_bazaar_data.dart';
import 'package:encointer_wallet/page-encointer/bazaar/single_business/logic/single_business_store.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/store/account/services/legacy_storage.dart';
import 'package:ew_storage/ew_storage.dart' show SecureStorageMock;

import '../../mock/api/mock_api.dart';
import '../../mock/storage/mock_local_storage.dart';

void main() {
  late SingleBusinessStore businessesStore;

  setUp(() async {
    webApi = getMockApi(AppStore(MockLocalStorage(), SecureStorageMock(), LegacyLocalStorageMock()));
    await webApi.init();

    businessesStore = SingleBusinessStore(businessesMockForSingleBusiness);
  });

  group('SingleBusinessStore Test', () {
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
