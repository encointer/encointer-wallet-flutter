import 'package:flutter_test/flutter_test.dart';

import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/mocks/mock_bazaar_data.dart';
import 'package:encointer_wallet/page-encointer/new_bazaar/businesses/widgets/dropdown_widget.dart';
import 'package:encointer_wallet/page-encointer/new_bazaar/businesses/logic/businesses_store.dart';
import 'package:encointer_wallet/utils/fetch_status.dart';

import '../../mock/api/mock_api.dart';
import '../../mock/storage/mock_local_storage.dart';

void main() {
  late BusinessesStore businessesStore;

  setUp(() async {
    webApi = getMockApi(AppStore(MockLocalStorage()), withUI: false);
    await webApi.init();

    businessesStore = BusinessesStore(cidEdisonPaula);
  });

  group('BusinessesStore Test', () {
    test('`getBusinesses()` should update fetchStatus to success and populate businesses list', () async {
      expect(businessesStore.fetchStatus, FetchStatus.loading);
      expect(businessesStore.sortedBusinesses, isEmpty);

      await businessesStore.getBusinesses();

      expect(businessesStore.fetchStatus, FetchStatus.success);
      expect(businessesStore.sortedBusinesses, isNotEmpty);
      expect(businessesStore.sortedBusinesses.length, greaterThan(0));
      expect(businessesStore.businesses.length, greaterThan(0));
    });

    test('`getBusinesses()` should filter businesses by category', () async {
      await businessesStore.getBusinesses();

      expect(businessesStore.sortedBusinesses, isNotEmpty);
      expect(businessesStore.sortedBusinesses.every((business) => business.category == Category.food), isTrue);
    });
  });
}
