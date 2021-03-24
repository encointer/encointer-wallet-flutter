import 'package:encointer_wallet/app.dart';
import 'package:encointer_wallet/common/components/passwordInputDialog.dart';
import 'package:encointer_wallet/config.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('EncointerWallet App', () {

    setUpAll(() async {
    });

    tearDownAll(() async {
    });

    testWidgets('screenshot test', (WidgetTester tester) async {
      await tester.pumpWidget(WalletApp(const Config(mockLocalStorage: true)));
      await tester.pumpAndSettle();
      globalAppStore.account.setPin("1234");

      // var dialogFinder = find.byType(PasswordInputDialog);
      // PasswordInputDialog dialog = dialogFinder.evaluate().first.widget;
      // dialog.onOk("1234");
      // await tester.pumpAndSettle();

      // IntegrationTestWidgetsFlutterBinding()
      //     .takeScreenshot('hello');
    });
  });
}

const SETUP_STORE = "setup_store";