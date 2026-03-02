import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../app/app.dart';
import '../helpers/test_app_launcher.dart';
import '../helpers/wait_helpers.dart';

/// Independent single-device story:
/// Launch app -> create account + PIN -> enable dev mode -> switch to dev network
/// -> import Alice -> select demo community -> disable dev mode
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

    // --- Setup: Create throwaway account + PIN ---
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

    // Import Alice (has CC balance for IPFS uploads)
    await goToHomeViewFromNavBar(tester);
    await goToAddAcoountViewFromPanel(tester);
    await importAccount(tester, b, s, l, 'Alice', '//Alice');
    await closePanel(tester);

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
    await waitForWidget(tester, find.byKey(const Key(EWTestKeys.businessName)));
    await tester.enterText(find.byKey(const Key(EWTestKeys.businessName)), 'Alice Test Shop');
    await tester.pumpAndSettle();

    // Select category — tap the dropdown, then pick "Art & Music" from the overlay
    await tester.tap(find.byKey(const Key(EWTestKeys.businessCategory)));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Art & Music').last);
    await tester.pumpAndSettle();

    // Fill description
    await tester.enterText(find.byKey(const Key(EWTestKeys.businessDescription)), 'A test business for E2E');
    await tester.pumpAndSettle();

    // Fill address
    await tester.enterText(find.byKey(const Key(EWTestKeys.businessAddress)), '123 Test St');
    await tester.pumpAndSettle();

    // Fill zipcode
    await tester.enterText(find.byKey(const Key(EWTestKeys.businessZipcode)), '12345');
    await tester.pumpAndSettle();

    // Fill telephone
    await tester.enterText(find.byKey(const Key(EWTestKeys.businessTelephone)), '+41123456789');
    await tester.pumpAndSettle();

    // Fill email
    await tester.enterText(find.byKey(const Key(EWTestKeys.businessEmail)), 'alice@test.com');
    await tester.pumpAndSettle();

    // Scroll down to opening hours
    final formListView = find.byType(ListView);
    await scrollUntilVisible(
      tester,
      scrollable: formListView,
      item: find.byKey(const Key(EWTestKeys.businessOpeningHours)),
    );

    // Fill opening hours
    await tester.enterText(find.byKey(const Key(EWTestKeys.businessOpeningHours)), 'Mon-Fri 9-17');
    await tester.pumpAndSettle();

    // Scroll to longitude/latitude
    await scrollUntilVisible(
      tester,
      scrollable: formListView,
      item: find.byKey(const Key(EWTestKeys.businessLongitude)),
    );

    // Fill longitude
    await tester.enterText(find.byKey(const Key(EWTestKeys.businessLongitude)), '8.5417');
    await tester.pumpAndSettle();

    // Fill latitude
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

    // Scroll to save button
    await scrollUntilVisible(
      tester,
      scrollable: formListView,
      item: find.byKey(const Key(EWTestKeys.businessSave)),
    );

    // Tap save
    await tester.tap(find.byKey(const Key(EWTestKeys.businessSave)));

    // Wait for save to complete (IPFS upload + chain tx — may take a while)
    await waitForWidget(
      tester,
      find.byKey(const Key(EWTestKeys.addBusiness)),
      timeout: const Duration(seconds: 120),
    );

    // --- Verify creation ---
    // Wait for bazaar list to reload and show the new business card
    final businessCardFinder = find.byKey(Key('${EWTestKeys.businessCard}-Alice Test Shop'));
    await waitForWidget(tester, businessCardFinder, timeout: const Duration(seconds: 30));

    // --- Edit Business ---
    await tester.tap(businessCardFinder);
    await tester.pumpAndSettle();

    // Wait for detail page, then tap edit button
    await waitForWidget(tester, find.byKey(const Key(EWTestKeys.businessEditButton)));
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
    // Clear name and enter new name
    await tester.enterText(find.byKey(const Key(EWTestKeys.businessName)), '');
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key(EWTestKeys.businessName)), 'Alice Updated Shop');
    await tester.pumpAndSettle();

    // Scroll to save button
    final editFormListView = find.byType(ListView);
    await scrollUntilVisible(
      tester,
      scrollable: editFormListView,
      item: find.byKey(const Key(EWTestKeys.businessSave)),
    );

    // Tap save
    await tester.tap(find.byKey(const Key(EWTestKeys.businessSave)));

    // Wait for navigation back (detail page or bazaar list)
    await tester.pump(const Duration(seconds: 3));
    await waitForWidget(
      tester,
      find.text('Alice Updated Shop'),
      timeout: const Duration(seconds: 120),
    );

    // --- Verify update ---
    expect(find.text('Alice Updated Shop'), findsWidgets);
  });
}
