import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../app/app.dart';
import '../helpers/screenshot_helpers.dart';
import '../helpers/test_app_launcher.dart';
import '../helpers/wait_helpers.dart';

/// Independent single-device story:
/// Launch app -> import Alice + PIN -> enable dev mode -> switch to dev network
/// -> select demo community -> disable dev mode
/// -> navigate to Bazaar -> create business with all fields + images
/// -> verify business appears in list -> open detail -> edit
/// -> verify prepopulation -> update name -> verify update.
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Bazaar business create and edit story', (tester) async {
    final launcher = TestAppLauncher();
    await launcher.launch(tester);
    final s = launcher.appSettings;
    final b = launcher.binding;
    final l = launcher.locales;

    // --- Setup: Import Alice directly as first account ---
    await waitForWidget(tester, find.byKey(const Key(EWTestKeys.importAccount)));
    await tester.ensureVisible(find.byKey(const Key(EWTestKeys.importAccount)));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key(EWTestKeys.importAccount)));
    await tester.pumpAndSettle();

    await enterAccountName(tester, 'Alice');
    await enterAccountMnemonic(tester, '//Alice');
    await tester.tap(find.byKey(const Key(EWTestKeys.accountImportNext)));
    await tester.pumpAndSettle();

    // First account → PIN creation flow
    await enterPin(tester, EWTestKeys.testPIN);
    await tester.tap(find.byKey(const Key(EWTestKeys.createAccountConfirm)));
    await tester.pumpAndSettle();
    await tapNotNowButtonBiometricAuthEnable(tester);
    await choosingCid(tester, b, s, l, 0);

    // Enable dev mode
    await goToProfileViewFromNavBar(tester);
    await scrollToDevMode(tester);
    await tapDevMode(tester);

    // Switch to dev network
    await goToNetworkView(tester);
    await changeDevNetwork(tester, 'Alice');

    await goToHomeViewFromNavBar(tester);

    // Select demo community
    await changeCommunity(tester);

    // Disable dev mode to avoid extra UI clutter
    await goToProfileViewFromNavBar(tester);
    await scrollToDevMode(tester);
    await tapDevMode(tester);

    // --- Navigate to Bazaar ---
    await goToHomeViewFromNavBar(tester);
    // Tap the bazaar tab in the bottom navigation bar
    await waitForWidget(tester, find.byKey(const Key(EWTestKeys.bazaarTab)));
    await tester.tap(find.byKey(const Key(EWTestKeys.bazaarTab)));
    await tester.pumpAndSettle();

    // Wait for businesses list to load
    await tester.pump(const Duration(seconds: 3));

    // --- Create Business ---
    await waitForWidget(tester, find.byKey(const Key(EWTestKeys.addBusiness)));
    await tester.tap(find.byKey(const Key(EWTestKeys.addBusiness)));
    await tester.pumpAndSettle();

    // Fill name
    final formListView = find.byType(ListView);
    await waitForWidget(tester, find.byKey(const Key(EWTestKeys.businessName)));
    await tester.enterText(find.byKey(const Key(EWTestKeys.businessName)), 'Alice Test Shop');
    await tester.pumpAndSettle();

    // Select category — tap the dropdown, then pick "Art & Music" from the overlay
    await tester.tap(find.byKey(const Key(EWTestKeys.businessCategory)));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Art & Music').last);
    await tester.pumpAndSettle();

    // Screenshot: top of form with name + category filled
    await takeScreenshot(b, s, Screenshots.bazaarFormTop, locales: l);

    // Fill description
    await scrollUntilVisible(tester,
        scrollable: formListView, item: find.byKey(const Key(EWTestKeys.businessDescription)));
    await tester.enterText(find.byKey(const Key(EWTestKeys.businessDescription)), 'A test business for E2E');
    await tester.pumpAndSettle();

    // Fill address
    await scrollUntilVisible(tester, scrollable: formListView, item: find.byKey(const Key(EWTestKeys.businessAddress)));
    await tester.enterText(find.byKey(const Key(EWTestKeys.businessAddress)), '123 Test St');
    await tester.pumpAndSettle();

    // Fill zipcode
    await scrollUntilVisible(tester, scrollable: formListView, item: find.byKey(const Key(EWTestKeys.businessZipcode)));
    await tester.enterText(find.byKey(const Key(EWTestKeys.businessZipcode)), '12345');
    await tester.pumpAndSettle();

    // Fill telephone
    await scrollUntilVisible(tester,
        scrollable: formListView, item: find.byKey(const Key(EWTestKeys.businessTelephone)));
    await tester.enterText(find.byKey(const Key(EWTestKeys.businessTelephone)), '+41123456789');
    await tester.pumpAndSettle();

    // Fill email
    await scrollUntilVisible(tester, scrollable: formListView, item: find.byKey(const Key(EWTestKeys.businessEmail)));
    await tester.enterText(find.byKey(const Key(EWTestKeys.businessEmail)), 'alice@test.com');
    await tester.pumpAndSettle();

    // Fill homepage
    await scrollUntilVisible(tester,
        scrollable: formListView, item: find.byKey(const Key(EWTestKeys.businessHomepage)));
    await tester.enterText(find.byKey(const Key(EWTestKeys.businessHomepage)), 'https://test.com');
    await tester.pumpAndSettle();

    // Fill opening hours
    await scrollUntilVisible(tester,
        scrollable: formListView, item: find.byKey(const Key(EWTestKeys.businessOpeningHours)));
    await tester.enterText(find.byKey(const Key(EWTestKeys.businessOpeningHours)), 'Mon-Fri 9-17');
    await tester.pumpAndSettle();

    // Fill longitude
    await scrollUntilVisible(tester,
        scrollable: formListView, item: find.byKey(const Key(EWTestKeys.businessLongitude)));
    await tester.enterText(find.byKey(const Key(EWTestKeys.businessLongitude)), '8.5417');
    await tester.pumpAndSettle();

    // Fill latitude
    await scrollUntilVisible(tester,
        scrollable: formListView, item: find.byKey(const Key(EWTestKeys.businessLatitude)));
    await tester.enterText(find.byKey(const Key(EWTestKeys.businessLatitude)), '47.3769');
    await tester.pumpAndSettle();

    // Scroll to logo pick button
    await scrollUntilVisible(
      tester,
      scrollable: formListView,
      item: find.byKey(const Key(EWTestKeys.businessPickLogo)),
    );

    // Pick logo (mocked — returns generated test image)
    await tester.tap(find.byKey(const Key(EWTestKeys.businessPickLogo)));
    await tester.pumpAndSettle();

    // Scroll to add photo button
    await scrollUntilVisible(
      tester,
      scrollable: formListView,
      item: find.byKey(const Key(EWTestKeys.businessAddPhoto)),
    );

    // Pick photos (mocked — 2 photos)
    await tester.tap(find.byKey(const Key(EWTestKeys.businessAddPhoto)));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key(EWTestKeys.businessAddPhoto)));
    await tester.pumpAndSettle();

    // Screenshot: bottom of form with images picked
    await takeScreenshot(b, s, Screenshots.bazaarFormBottom, locales: l);

    // Scroll to save button
    await scrollUntilVisible(
      tester,
      scrollable: formListView,
      item: find.byKey(const Key(EWTestKeys.businessSave)),
    );

    // Tap save — PIN dialog is skipped because cachedPin is set from createPin.
    // Use pump() not pumpAndSettle() because the progress spinner never settles.
    await tester.tap(find.byKey(const Key(EWTestKeys.businessSave)));
    await tester.pump();

    // --- Verify creation ---
    // Wait for save + list refresh — the card appearing is the definitive signal
    // that IPFS uploads, chain tx, form pop, and store refresh all completed.
    // Note: can't use the addBusiness button as a "form done" signal because
    // find.byKey finds it offstage (BazaarPage stays in the Navigator tree
    // behind the form page).
    final businessCardFinder = find.byKey(const Key('${EWTestKeys.businessCard}-Alice Test Shop'));
    await waitForWidget(tester, businessCardFinder, timeout: const Duration(seconds: 240));

    // Screenshot: businesses list with new business
    await takeScreenshot(b, s, Screenshots.bazaarBusinessesList, locales: l);

    // --- View Business Detail ---
    await tester.tap(businessCardFinder);
    await tester.pumpAndSettle();

    // Wait for detail page
    await waitForWidget(tester, find.byKey(const Key(EWTestKeys.businessEditButton)));

    // Screenshot: business detail page
    await takeScreenshot(b, s, Screenshots.bazaarBusinessDetail, locales: l);

    // --- Edit Business ---
    await tester.tap(find.byKey(const Key(EWTestKeys.businessEditButton)));
    await tester.pumpAndSettle();

    // --- Verify prepopulation ---
    await waitForWidget(tester, find.byKey(const Key(EWTestKeys.businessName)));

    // The name field should contain "Alice Test Shop"
    final nameField = tester.widget<EditableText>(
      find.descendant(
        of: find.byKey(const Key(EWTestKeys.businessName)),
        matching: find.byType(EditableText),
      ),
    );
    expect(nameField.controller.text, 'Alice Test Shop');

    // The description field should contain our text
    final descriptionField = tester.widget<EditableText>(
      find.descendant(
        of: find.byKey(const Key(EWTestKeys.businessDescription)),
        matching: find.byType(EditableText),
      ),
    );
    expect(descriptionField.controller.text, 'A test business for E2E');

    // --- Update Business ---
    // Set controller text directly — tester.enterText is unreliable on Android
    // CI emulators where widget rebuilds disrupt the text input channel.
    // See also: account_manage_helper.dart, contact_helper.dart.
    final nameEditable = tester.widget<EditableText>(
      find.descendant(of: find.byKey(const Key(EWTestKeys.businessName)), matching: find.byType(EditableText)),
    );
    nameEditable.controller.text = 'Alice Updated Shop';
    await tester.pumpAndSettle();

    // Update description
    final editFormListView = find.byType(ListView);
    await scrollUntilVisible(tester,
        scrollable: editFormListView, item: find.byKey(const Key(EWTestKeys.businessDescription)));
    final descEditable = tester.widget<EditableText>(
      find.descendant(of: find.byKey(const Key(EWTestKeys.businessDescription)), matching: find.byType(EditableText)),
    );
    descEditable.controller.text = 'Updated E2E description';
    await tester.pumpAndSettle();

    // Scroll to save button and tap
    await scrollUntilVisible(
      tester,
      scrollable: editFormListView,
      item: find.byKey(const Key(EWTestKeys.businessSave)),
    );
    await tester.tap(find.byKey(const Key(EWTestKeys.businessSave)));
    await tester.pump();

    // --- Verify detail page shows updated data ---
    // Wait for the updated name to appear — this is the definitive signal that
    // save completed, form popped, store updated, and detail page rebuilt.
    // (The previous wait on businessEditButton was wrong: that key exists
    // offstage on the detail page behind the form, so it returned immediately.)
    await waitForWidget(
      tester,
      find.text('ALICE UPDATED SHOP'),
      timeout: const Duration(seconds: 240),
    );
    await tester.pumpAndSettle();

    // AppBar title should show uppercased updated name
    expect(find.text('ALICE UPDATED SHOP'), findsOneWidget);
    // Description should be updated
    expect(find.text('Updated E2E description'), findsOneWidget);
    // Edit button confirms we're on the detail page
    expect(find.byKey(const Key(EWTestKeys.businessEditButton)), findsOneWidget);

    // --- Navigate back to businesses list ---
    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();

    // --- Verify list page shows updated business ---
    final updatedCardFinder = find.byKey(const Key('${EWTestKeys.businessCard}-Alice Updated Shop'));
    await waitForWidget(tester, updatedCardFinder, timeout: const Duration(seconds: 60));
    expect(updatedCardFinder, findsOneWidget);
    expect(find.text('Updated E2E description'), findsWidgets);
  });
}
