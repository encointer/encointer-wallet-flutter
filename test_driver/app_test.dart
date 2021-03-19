import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/store/encointer/types/encointerBalanceData.dart';
import 'package:encointer_wallet/utils/screenshot.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import 'package:encointer_wallet/mocks/data/MockAccountData.dart';
import 'package:encointer_wallet/mocks/data/mockEncointerData.dart';

void main() {
  FlutterDriver driver;
  group('EncointerWallet App', () {

    setUpAll(() async {
      driver = await FlutterDriver.connect();
      // waits until the firs frame after ft startup stabilized
      await driver.waitUntilFirstFrameRasterized();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('screenshot test', () async {
      final config = Config();
      await screenshot(driver, config, 'myscreenshot1');
    });
  });
}


AppStore setupLocalStorage(AppStore store) {
  store.account.setCurrentAccount(currentAccountPubKey);
  store.encointer.addBalanceEntry(cid, BalanceEntry.fromJson(balanceEntry));

  return store;
}