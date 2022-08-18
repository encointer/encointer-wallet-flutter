import 'package:encointer_wallet/store/data_update/data_update.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('DataUpdateStore test', () {
    test('refreshes data when it should', () async {
      DataUpdateStore store = DataUpdateStore(
        refreshPeriod: const Duration(seconds: 5),
      );

      int count = 0;

      store.setupUpdateReaction(() async {
        count = count + 1;
        return Future.delayed(Duration(seconds: 1));
      });

      await Future.delayed(Duration(seconds: 2));
      expect(count, 1);

      await Future.delayed(Duration(seconds: 4));
      expect(count, 1);

      await Future.delayed(Duration(seconds: 2));
      expect(count, 2);
    });
  });
}
