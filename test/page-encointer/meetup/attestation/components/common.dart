import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:polka_wallet/common/components/activityIndicator.dart';
import 'package:polka_wallet/common/components/roundedButton.dart';
import 'package:polka_wallet/page-encointer/meetup/attestation/components/qrCode.dart';
import 'package:polka_wallet/page-encointer/meetup/attestation/components/scanQrCode.dart';

Future<void> goBackOnePage(WidgetTester tester) async {
  Finder backButton = find.byTooltip('Back');
  if (backButton.evaluate().isEmpty) {
    backButton = find.byType(CupertinoNavigationBarBackButton);
  }

  expect(backButton, findsOneWidget, reason: 'One back button expected on screen');
  await tester.tap(backButton);
  await tester.pumpAndSettle();
}

Future<ScanQrCode> verifyNavigateToScanner(
  WidgetTester tester,
) async {
  var scanQrCodeFinder = find.byType(ScanQrCode);
  expect(scanQrCodeFinder, findsOneWidget);

  ScanQrCode scanner = scanQrCodeFinder.evaluate().first.widget;
  return Future.value(scanner);
}

Future<void> verifyScanResult(WidgetTester tester, ScanQrCode scanner, String scanResult,
    {bool activityIndicatorShown = true}) async {
  // Fixme: This is currently a hack. We cannot open the camera, hence we never build the
  // QrCodeReader view. In order to do that we would need to Mock the scanQrCode reader. And inject it
  // in the StateMachine. Which we should eventually do to do a proper integration test on the emulator.
  //
  // Now we simply go back one page and call then the onScan method programmatically.
  await goBackOnePage(tester);
  scanner.onScan(scanResult);
  await tester.pumpAndSettle();

  if (activityIndicatorShown) {
    // tap ok, when the claim has been verified on js side
    expect(find.byType(ActivityIndicator), findsOneWidget);
    expect(find.byType(CupertinoButton), findsOneWidget);
    CupertinoButton cButton = find.byType(CupertinoButton).evaluate().first.widget;
    cButton.onPressed();
  }
  await tester.pumpAndSettle();
}

Future<void> verifyNavigateToQrCodeAndTapConfirmButton(WidgetTester tester) async {
  var qrCodeFinder = find.byType(QrCode);
  expect(qrCodeFinder, findsOneWidget);
  // make sure that the rounded button, we find is in the QrCode widget
  var strictButtonMatcher = find.descendant(of: qrCodeFinder, matching: find.byType(RoundedButton));
  expect(strictButtonMatcher, findsOneWidget);

  // tap done and return to stateMachinePartyA widget
  // await tester.tap(strictButtonMatcher); for some reason this does not work
  // the reason is unknown yet: see https://github.com/flutter/flutter/issues/31066
  RoundedButton button = strictButtonMatcher.evaluate().first.widget;
  button.onPressed();
  await tester.pumpAndSettle();
}
