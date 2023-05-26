import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import 'app/voucher/voucher_integration_test.dart';
import 'helpers/helper.dart';
import 'app/app.dart';

void main() async {
  late FlutterDriver driver;
  const timeout120 = Timeout(Duration(seconds: 120));

  group('EncointerWallet App', () {
    setUpAll(() async {
      driver = await FlutterDriver.connect();
      final locales = await driver.requestData(TestCommand.locales);
      driver.locales = locales.split(',');
      await driver.waitUntilFirstFrameRasterized();
    });
  });

  test('create account by name Tom', () async {
    await checkAcoountEntryView(driver);
    await goToCreateAccountViewFromAcoountEntryView(driver);
    await createAccount(driver, 'Tom');
  }, timeout: timeout120);

  test('create PIN by text 0001', () async {
    await createPin(driver, '0001');
  }, timeout: timeout120);

  test('choosing cid', () async {
    await choosingCid(driver, 0);
  }, timeout: timeout120);

  test('home-page', () async {
    await homeInit(driver);
  }, timeout: timeout120);

  test('qr-receive page', () async {
    await goToReceiveViewFromHomeView(driver);
    await receiveView(driver);
  }, timeout: timeout120);

  test('turn on dev-mode', () async {
    await qrTurnOnDevMode(driver);
  }, timeout: timeout120);

  test('change-network', () async {
    await goToNetworkView(driver);
    await changeDevNetwork(driver, 'Tom');
  }, timeout: timeout120);

  test('change-community', () async {
    await goToHomeViewFromNavBar(driver);
    await changeCommunity(driver);
  }, timeout: timeout120);

  test('import account Alice', () async {
    await goToAddAcoountViewFromPanel(driver);
    await importAccount(driver, 'Alice', '//Alice');
    await closePanel(driver);
  }, timeout: timeout120);

  test('Register [Bootstrapper] Alice', () async {
    await scrollToCeremonyBox(driver);
    await registerAndWait(driver, ParticipantTypeTestHelper.bootstrapper);
  }, timeout: timeout120);

  group('DevMode QR Voucher test', () {
    test('turn on devMode', () async {
      await qrTurnOnDevMode(driver);
    });

    test('get voucher by QR, fund', () async {
      await getQrVoucherAndFund(driver);
    });
    test('get voucher by QR, redeem', () async {
      await getQrVoucherAndRedeem(driver);
    }, timeout: timeout120);
    test('finished, turn off dev-mode', () async {
      await qrTurnOnDevMode(driver);
    });
  });

  tearDownAll(() async => driver.close());
}
