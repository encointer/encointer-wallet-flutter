import 'package:flutter_driver/flutter_driver.dart';

// home(wallet)-view
Future<void> scrollToCeremonyBox(FlutterDriver driver) async {
  await driver.scrollUntilVisible(
    find.byValueKey('list-view-wallet'),
    find.byValueKey('ceremony-box-wallet'),
    dyScroll: -300,
  );
}

Future<void> scrollToPanelController(FlutterDriver driver) async {
  await driver.scrollUntilVisible(
    find.byValueKey('list-view-wallet'),
    find.byValueKey('panel-controller'),
    dyScroll: 300,
  );
}

// profile-view
Future<void> scrollToDevMode(FlutterDriver driver) async {
  await driver.scrollUntilVisible(
    find.byValueKey('profile-list-view'),
    find.byValueKey('dev-mode'),
    dyScroll: -300,
  );
}

Future<void> scrollToNextPhaseButton(FlutterDriver driver) async {
  await driver.scrollUntilVisible(
    find.byValueKey('profile-list-view'),
    find.byValueKey('next-phase-button'),
    dyScroll: -300,
  );
}

// transfer-view
Future<void> scrollToSendAddress(FlutterDriver driver) async {
  await driver.scrollUntilVisible(
    find.byValueKey('transfer-listview'),
    find.byValueKey('send-to-address'),
    dyScroll: -300,
  );
}
