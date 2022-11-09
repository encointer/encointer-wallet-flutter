// import 'package:encointer_wallet/main.dart' as app;
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:integration_test/integration_test.dart';

// import 'helpers/add_delay.dart';
// import 'helpers/pump_app.dart';

// flutter test integration_test/app_test.dart --flavor dev

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() async {
  FlutterDriver? driver;

  group('EncointerWallet App', () {
    setUpAll(() async {
      driver = await FlutterDriver.connect();

      // waits until the firs frame after ft startup stabilized
      await driver!.waitUntilFirstFrameRasterized();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver!.close();
      }
    });
    
  });
}


// void main() async {
//   IntegrationTestWidgetsFlutterBinding.ensureInitialized();

//   setUpAll(() async {
//     await app.main();
//   });

//   group('start projetct', () {
//     testWidgets('metaApp and splash view', (tester) async {
//       await tester.pumpApp();

//       expect(find.byType(MaterialApp), findsOneWidget);

//       expect(find.byKey(const Key('splashview')), findsOneWidget);
//       await addDelay(2000);
//       await tester.pumpAndSettle();
//       await addDelay(2000);
//     });

//     testWidgets('import account', (tester) async {
//       expect(find.byKey(const Key('import-account')), findsOneWidget);
//       await tester.tap(find.byKey(const Key('import-account')));
//       await tester.pumpAndSettle();
//     });
//   });
// }
