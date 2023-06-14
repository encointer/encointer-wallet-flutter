import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/page-encointer/new_bazaar/logic/businesses_store.dart';
import 'package:encointer_wallet/common/components/error/error_view.dart';
import 'package:encointer_wallet/common/components/loading/centered_activity_indicator.dart';
import 'package:encointer_wallet/page-encointer/new_bazaar/view/businesses_view.dart';
import 'package:encointer_wallet/models/bazaar/businesses.dart';
import 'package:encointer_wallet/utils/fetch_status.dart';

import '../../helper/pump_widget.dart';
import '../../mock/data/mock_businesses_data.dart';

class MockBusinessesStore extends Mock implements BusinessesStore {}

void main() {
  late BusinessesStore mockStore;

  setUp(() => mockStore = MockBusinessesStore());

  group('BusinessesView Test', () {
    testWidgets('Widget shows loading indicator when fetchStatus is loading', (WidgetTester tester) async {
      when(() => mockStore.fetchStatus).thenReturn(FetchStatus.loading);

      await tester.pumpView(
        Provider<BusinessesStore>.value(
          value: mockStore,
          child: const BusinessesView(),
        ),
      );

      expect(find.byType(CenteredActivityIndicator), findsOneWidget);
      expect(find.byType(BusinessesList), findsNothing);
      expect(find.byType(ErrorView), findsNothing);
    });

    testWidgets('Widget shows error view when fetchStatus is error', (WidgetTester tester) async {
      when(() => mockStore.fetchStatus).thenReturn(FetchStatus.error);

      await tester.pumpView(
        Provider<BusinessesStore>.value(
          value: mockStore,
          child: const BusinessesView(),
        ),
      );

      expect(find.byType(CenteredActivityIndicator), findsNothing);
      expect(find.byType(BusinessesList), findsNothing);
      expect(find.byType(ErrorView), findsOneWidget);
    });

    testWidgets('Widget shows businesses list when fetchStatus is success', (WidgetTester tester) async {
      when(() => mockStore.fetchStatus).thenReturn(FetchStatus.success);
      when(() => mockStore.businesses).thenReturn(mockBusinessesDataList.map(Businesses.fromJson).toList());

      await tester.pumpView(
        Provider<BusinessesStore>.value(
          value: mockStore,
          child: const BusinessesView(),
        ),
      );
      expect(find.byType(CenteredActivityIndicator), findsNothing);
      expect(find.byType(BusinessesList), findsOneWidget);
      expect(find.byType(ErrorView), findsNothing);
    });
  });
}
