import 'dart:convert';

import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:encointer_wallet/page/assets/qr_code_printing/pages/qr_code_share_or_print_view.dart';

import '../app/app.dart';
import '../helpers/test_app_launcher.dart';
import '../helpers/wait_helpers.dart';

/// Multi-device step 1:
/// Launch -> import Alice -> navigate to receive page
/// -> extract QR payload from widget tree -> report data via binding.
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Alice show QR', (tester) async {
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

    // Import Alice
    await goToHomeViewFromNavBar(tester);
    await goToAddAcoountViewFromPanel(tester);
    await importAccount(tester, b, s, l, 'Alice', '//Alice');
    await closePanel(tester);
    await changeCommunity(tester);

    // Navigate to receive page and extract QR payload
    await goToReceiveViewFromHomeView(tester);
    await waitForWidget(tester, find.byKey(const Key(EWTestKeys.closeReceivePage)));

    // Extract QR data from the QrCodeShareOrPrintView widget
    final qrFinder = find.byType(QrCodeShareOrPrintView);
    await waitForWidget(tester, qrFinder);
    expect(qrFinder, findsOneWidget);
    final qrWidget = tester.widget<QrCodeShareOrPrintView>(qrFinder);
    final qrData = qrWidget.qrCode;

    // Report QR payload via binding so the driver can write it to a file
    b.reportData = <String, String>{'qr_payload': base64Encode(utf8.encode(qrData))};
  });
}
