import 'package:encointer_wallet/app.dart';
import 'package:encointer_wallet/config.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:encointer_wallet/utils/local_storage.dart' as util;

extension PumpApp on WidgetTester {
  Future<void> pumpApp() async {
    await pumpWidget(
      Provider(
        // On test mode instead of LocalStorage() must be use MockLocalStorage()
        create: (context) => AppStore(util.LocalStorage(), config: const AppConfig()),
        child: const WalletApp(),
      ),
    );
  }
}
