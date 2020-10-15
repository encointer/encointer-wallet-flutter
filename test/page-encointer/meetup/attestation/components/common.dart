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

Future<ScanQrCode> navigateToScanner(
  WidgetTester tester,
) async {
  var scanQrCodeFinder = find.byType(ScanQrCode);
  expect(scanQrCodeFinder, findsOneWidget);

  ScanQrCode scanner = scanQrCodeFinder.evaluate().first.widget;
  return Future.value(scanner);
}

Future<void> mockQrCodeScan(WidgetTester tester, ScanQrCode scanner, String mockResult,
    {bool activityIndicatorShown = true}) async {
  // Fixme: This is currently a hack. We cannot open the camera, hence we never build the
  // QrCodeReader view. In order to do that, we would need to mock the scanQrCode reader and inject it
  // into the StateMachine. This we could eventually do in order to se through a 'Mock-Meetup', which can be
  // performed by only on cellphone.
  //
  // Now we simply go back one page and call then the onScan method programmatically.
  await goBackOnePage(tester);
  scanner.onScan(mockResult);
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

Future<void> navigateToQrCodeAndTapConfirmButton(WidgetTester tester) async {
  var qrCodeFinder = find.byType(QrCode);
  expect(qrCodeFinder, findsOneWidget);
  // make sure that the rounded button, we find is in the QrCode widget
  var strictButtonMatcher = find.descendant(of: qrCodeFinder, matching: find.byType(RoundedButton));
  expect(strictButtonMatcher, findsOneWidget);
  RoundedButton button = strictButtonMatcher.evaluate().first.widget;
  button.onPressed();
  await tester.pumpAndSettle();
}

Future<void> goBackOneAttestationStep(WidgetTester tester) async {
  var backButtonFinder = find.text("Go Back");
  expect(backButtonFinder, findsOneWidget);
  await tester.tap(backButtonFinder);
  await tester.pumpAndSettle();
}
