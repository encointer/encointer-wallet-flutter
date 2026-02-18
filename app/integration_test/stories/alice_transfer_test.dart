import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../app/app.dart';
import '../helpers/test_app_launcher.dart';
import '../helpers/wait_helpers.dart';

/// Independent single-device story:
/// Launch app -> create account + PIN -> enable dev mode -> switch to dev network
/// -> import Alice -> select demo community -> import Bob
/// -> Alice sends 0.1 CC to Bob -> verify transfer in history.
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Alice transfer story', (tester) async {
    final launcher = TestAppLauncher();
    await launcher.launch(tester);
    final s = launcher.appSettings;
    final b = launcher.binding;
    final l = launcher.locales;

    // Create throwaway account + PIN
    await goToCreateAccountViewFromAcoountEntryView(tester);
    await createAccount(tester, b, s, l, 'Throwaway');
    await createPin(tester, b, s, l, EWTestKeys.testPIN);
    await tapNotNowButtonBiometricAuthEnable(tester);
    await choosingCid(tester, b, s, l, 0);

    // Enable dev mode
    await goToProfileViewFromNavBar(tester);
    await scrollToDevMode(tester);
    await tapDevMode(tester);

    // Switch to dev network
    await goToNetworkView(tester);
    await changeDevNetwork(tester, 'Throwaway');

    // Import Alice
    await goToHomeViewFromNavBar(tester);
    await goToAddAcoountViewFromPanel(tester);
    await importAccount(tester, b, s, l, 'Alice', '//Alice');
    await closePanel(tester);

    // Select demo community
    await changeCommunity(tester);

    // Import Bob
    await goToAddAcoountViewFromPanel(tester);
    await importAccount(tester, b, s, l, 'Bob', '//Bob');
    await closePanel(tester);

    // Switch to Alice
    await changeAccountFromPanel(tester, 'Alice');

    // Alice sends 0.1 CC to Bob
    await scrollToPanelController(tester);
    await goToTransferViewFromHomeView(tester);
    await senMoneyToAccount(tester, b, s, l, 'Bob', '0.1');

    // Verify transfer in history
    await navigateToTransferHistoryPage(tester);
    await waitForWidget(tester, find.byKey(const Key(EWTestKeys.transactionsList)));
    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();
  });
}
