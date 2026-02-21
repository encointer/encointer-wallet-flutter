import 'package:flutter_test/flutter_test.dart';

import 'package:encointer_wallet/store/data_update/data_update.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('DataUpdateStore test', () {
    test('refreshes data when it should', () async {
      final store = DataUpdateStore(
        refreshPeriod: const Duration(seconds: 5),
      );

      var count = 0;

      store.setupUpdateReaction(() async {
        count = count + 1;
        return Future.delayed(const Duration(seconds: 1));
      });

      // lastUpdate starts at DateTime.now(), so first refresh fires after refreshPeriod (~5s).
      await Future<void>.delayed(const Duration(seconds: 2));
      expect(count, 0);

      await Future<void>.delayed(const Duration(seconds: 5));
      expect(count, 1);

      // After first update completes (~T+7s), next refresh fires ~5s later (~T+12s).
      await Future<void>.delayed(const Duration(seconds: 6));
      expect(count, 2);
    });
  });
}
