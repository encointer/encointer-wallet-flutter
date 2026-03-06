import 'package:encointer_wallet/models/bazaar/category.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/store/account/services/legacy_storage.dart';
import 'package:encointer_wallet/page-encointer/bazaar/businesses/logic/businesses_store.dart';
import 'package:encointer_wallet/utils/fetch_status.dart';
import 'package:ew_storage/ew_storage.dart' show SecureStorageMock;

import '../../mock/mock.dart';

void main() {
  late BusinessesStore businessesStore;

  setUp(() async {
    webApi = getMockApi(AppStore(MockLocalStorage(), SecureStorageMock(), LegacyLocalStorageMock()));
    await webApi.init();

    businessesStore = BusinessesStore();
  });

  group('BusinessesStore Test', () {
    test('`getBusinesses()` should update fetchStatus to success and populate businesses list', () async {
      expect(businessesStore.fetchStatus, FetchStatus.loading);
      expect(businessesStore.sortedBusinesses, isEmpty);

      await businessesStore.getBusinesses(cid, '');

      expect(businessesStore.fetchStatus, FetchStatus.success);
      expect(businessesStore.sortedBusinesses, isNotEmpty);
      expect(businessesStore.sortedBusinesses.length, greaterThan(0));
      expect(businessesStore.businesses.length, greaterThan(0));
    });

    test('all businesses from RPC are present after getBusinesses()', () async {
      await businessesStore.getBusinesses(cid, '');

      // Mock returns 3 businesses (allMockBusinesses)
      expect(businessesStore.sortedBusinesses.length, 3);
      expect(businessesStore.businesses.length, 3);
    });

    test('`getBusinesses()` should filter businesses by category', () async {
      await businessesStore.getBusinesses(cid, '');

      expect(businessesStore.sortedBusinesses, isNotNull);
      expect(businessesStore.sortedBusinesses.every((business) => business.category == Category.food), isTrue);
    });

    test('`getBusinesses()` skips re-fetch within TTL for same CID', () async {
      await businessesStore.getBusinesses(cid, '');
      expect(businessesStore.sortedBusinesses.length, 3);

      // Mutate to detect if re-fetch happens
      businessesStore.businesses.clear();
      businessesStore.sortedBusinesses.clear();

      // Call again without force — should skip (TTL not expired, same CID)
      await businessesStore.getBusinesses(cid, '');
      expect(businessesStore.sortedBusinesses, isEmpty);
    });

    test('`getBusinesses()` with force bypasses TTL', () async {
      await businessesStore.getBusinesses(cid, '');
      expect(businessesStore.sortedBusinesses.length, 3);

      await businessesStore.getBusinesses(cid, '', force: true);
      expect(businessesStore.sortedBusinesses.length, 3);
    });
  });
}
