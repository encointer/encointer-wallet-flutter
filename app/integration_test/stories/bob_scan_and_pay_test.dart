import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../app/app.dart';
import '../helpers/test_app_launcher.dart';
import '../helpers/wait_helpers.dart';

/// Multi-device step 2:
/// Reads QR_PAYLOAD from dart-define -> launch -> import Bob
/// -> navigate to scan page -> tap "Custom QR" button
/// -> complete payment flow -> verify.
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Bob scan and pay', (tester) async {
    const qrPayload = String.fromEnvironment('QR_PAYLOAD');
    expect(qrPayload.isNotEmpty, isTrue, reason: 'QR_PAYLOAD must be provided via --dart-define');

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

    // Enable dev mode and switch to dev network
    await goToProfileViewFromNavBar(tester);
    await scrollToDevMode(tester);
    await tapDevMode(tester);
    await goToNetworkView(tester);
    await changeDevNetwork(tester, 'Throwaway');
    // Turn dev mode off to avoid "Pay Offline" button on PaymentConfirmationPage
    // (mock QR buttons use isIntegrationTest, not developerMode)
    await scrollToDevMode(tester);
    await tapDevMode(tester);

    // Import Bob
    await goToHomeViewFromNavBar(tester);
    await goToAddAcoountViewFromPanel(tester);
    await importAccount(tester, b, s, l, 'Bob', '//Bob');
    await closePanel(tester);
    await changeCommunity(tester);

    // Navigate to scan page and tap Custom QR
    await navigateToScanPage(tester);
    await waitForWidget(tester, find.byKey(const Key(EWTestKeys.mockQrDataRow)));
    await waitForWidget(tester, find.byKey(const Key(EWTestKeys.customQrScan)));
    await tester.tap(find.byKey(const Key(EWTestKeys.customQrScan)));
    await tester.pumpAndSettle();

    // Complete payment flow — QR invoice has no amount, so enter one
    await waitForWidget(tester, find.byKey(const Key(EWTestKeys.transferAmountInput)));
    await tester.enterText(find.byKey(const Key(EWTestKeys.transferAmountInput)), '0.01');
    await tester.pumpAndSettle();
    await waitForWidget(tester, find.byKey(const Key(EWTestKeys.makeTransfer)));
    await tester.tap(find.byKey(const Key(EWTestKeys.makeTransfer)));
    await tester.pumpAndSettle();
    await waitForWidget(tester, find.byKey(const Key(EWTestKeys.makeTransferSend)));
    await tester.tap(find.byKey(const Key(EWTestKeys.makeTransferSend)));
    await tester.pumpAndSettle();
    await waitForWidget(tester, find.byKey(const Key(EWTestKeys.transferDone)));
    await tester.tap(find.byKey(const Key(EWTestKeys.transferDone)));
    await tester.pumpAndSettle();
  });
}
