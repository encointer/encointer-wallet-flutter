// ignore_for_file: avoid_print

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import '../helpers/command/real_app_command.dart';
import '../helpers/extension/screenshot_driver_extension.dart';
import '../helpers/real_app_helper.dart';
import '../helpers/screenshots.dart';
import '../helpers/add_delay.dart';
import '../helpers/other_test.dart';

void main() {
  late FlutterDriver driver;

  group('EncointerWallet Dev QR Code testing', () {
    setUpAll(() async {
      driver = await FlutterDriver.connect();
      final val = await driver.requestData(RealAppTestCommand.shouldTakeScreenshot);
      driver.shouldTakeScreenshot = val == 'true';
      await driver.waitUntilFirstFrameRasterized();
    });

    test('create account by name Tom', () async {
      await driver.takeScreenshot(Screenshots.splashView);
      await driver.waitFor(find.byValueKey('create-account'));
      await driver.takeScreenshot(Screenshots.accountEntryView);
      await createAccountAndSetPin(driver, 'Tom');
    });

    test('choosing cid', () async {
      await driver.waitFor(find.byValueKey('cid-0-marker-icon'));
      await driver.tap(find.byValueKey('cid-0-marker-icon'));
      await driver.waitFor(find.byValueKey('cid-0-marker-description'));
      await driver.takeScreenshot(Screenshots.chooseCommunityMap);
      await driver.tap(find.byValueKey('cid-0-marker-description'));
    }, timeout: const Timeout(Duration(seconds: 120)));

    test('home-page', () async {
      await refreshWalletPage(driver);

      await dismissUpgradeDialogOnAndroid(driver);
      await driver.takeScreenshot(Screenshots.homeWithRegisterButton);
      await addDelay(1000);
    });

    test('turn on dev-mode', () async {
      await driver.tap(find.byValueKey('profile'));
      await driver.takeScreenshot(Screenshots.profileView);
      await turnDevModeToTestQrScan(driver);
      await addDelay(1000);
    });

    test('change-network', () async {
      await driver.tap(find.byValueKey('choose-network'));
      await driver.tap(find.byValueKey('nctr-gsl-dev'));
      await driver.tap(find.text('Tom'));

      await driver.waitFor(find.byValueKey('profile-list-view'));
      await driver.tap(find.byValueKey('wallet'));
      await addDelay(1000);
    }, timeout: const Timeout(Duration(seconds: 90)));

    test('change-community', () async {
      await driver.runUnsynchronized(() async {
        await driver.tap(find.byValueKey('panel-controller'));
        await driver.tap(find.byValueKey('add-community'));
        await addDelay(1000);

        await driver.tap(find.byValueKey('cid-0-marker-icon'));
        await driver.tap(find.byValueKey('cid-0-marker-description'));
        await addDelay(1000);

        await driver.waitFor(find.byValueKey('add-community'));
        await addDelay(1000);
        await closePanel(driver);
        await addDelay(1000);

        await refreshWalletPage(driver);
        await addDelay(1000);
      });
    });

    test('import account Alice', () async {
      await importAccount(driver, 'Alice', '//Alice');
    }, timeout: const Timeout(Duration(seconds: 60)));

    test('qr code from HomePage: test and save the contact from qr', () async {
      // scan
      await driver.waitFor(find.byValueKey('bottom-nav'));
      await driver.tap(find.byValueKey('scan'));
      await saveContactFromQrContact(driver);
    }, timeout: const Timeout(Duration(seconds: 60)));

    test('qr code from HomePage: test and send money with amount from qr', () async {
      // scan
      await driver.waitFor(find.byValueKey('bottom-nav'));
      await driver.tap(find.byValueKey('scan'));
      await sendFromQrWithAmount(driver);
    }, timeout: const Timeout(Duration(seconds: 60)));

    test('qr code from HomePage: test and send money without amount from qr', () async {
      // scan
      await driver.waitFor(find.byValueKey('bottom-nav'));
      await driver.tap(find.byValueKey('scan'));
      await sendFromQrWithoutAmount(driver);
    }, timeout: const Timeout(Duration(seconds: 60)));
  });

  test('qr code from SendPage: test and send money with amount from qr', () async {
    // scan
    await driver.tap(find.byValueKey('transfer'));
    await driver.waitFor(find.byValueKey('transfer-listview'));
    await driver.tap(find.byValueKey('transfer_send'));
    await sendFromQrWithAmount(driver);
  }, timeout: const Timeout(Duration(seconds: 60)));

  test('qr code from SendPage: test and send money without amount from qr', () async {
    // scan
    await driver.tap(find.byValueKey('transfer'));
    await driver.waitFor(find.byValueKey('transfer-listview'));
    await driver.tap(find.byValueKey('transfer_send'));
    await sendFromQrWithoutAmount(driver);
  }, timeout: const Timeout(Duration(seconds: 60)));

  test('qr code from ContactPage: add contact from contact-qr', () async {
    await driver.tap(find.byValueKey('contacts'));
    await driver.takeScreenshot(Screenshots.contactsOverviewEmpty);
    await driver.tap(find.byValueKey('add-contact'));
    await driver.tap(find.byValueKey('scan-barcode'));
    await saveContactFromQrContact(driver, true);
    await driver.tap(find.byValueKey('back-to-contacts-page'));
    await addDelay(1000);
  }, timeout: const Timeout(Duration(seconds: 120)));

  test('qr code from ContactPage: add contact from invoice-qr', () async {
    await driver.tap(find.byValueKey('contacts'));
    await driver.takeScreenshot(Screenshots.contactsOverviewEmpty);
    await driver.tap(find.byValueKey('add-contact'));
    await driver.tap(find.byValueKey('scan-barcode'));
    await saveContactFromQrInvoice(driver);
    await driver.tap(find.byValueKey('back-to-contacts-page'));
    await addDelay(1000);
  }, timeout: const Timeout(Duration(seconds: 120)));

  test('delete all account ad show create account page', () async {
    await driver.waitFor(find.byValueKey('bottom-nav'));
    await driver.tap(find.byValueKey('profile'));
    await driver.waitFor(find.byValueKey('remove-all-accounts'));
    await rmAllAccountsFromProfilePage(driver);
    await addDelay(2000);
  });

  tearDownAll(() async {
    await driver.close();
  });
}

void log(String msg) {
  print('[test_driver] $msg');
}

Future<void> dismissUpgradeDialogOnAndroid(FlutterDriver driver) async {
  final operationSystem = await driver.requestData('getPlatform');
  log('operationSystem ==================> $operationSystem');

  if (operationSystem != 'android') return;

  try {
    log('Waiting for upgrader alert dialog');
    await driver.waitFor(find.byType('AlertDialog'));

    log('Tapping ignore button');
    await driver.tap(find.text('IGNORE'));
  } catch (e) {
    log(e.toString());
  }
}
