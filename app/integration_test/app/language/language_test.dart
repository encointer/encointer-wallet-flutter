import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/wait_helpers.dart';

Future<void> changeLanguage(WidgetTester tester) async {
  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.settingsLanguage)));
  await tester.tap(find.byKey(const Key(EWTestKeys.settingsLanguage)));
  await tester.pumpAndSettle();
  await waitForWidget(tester, find.text('Language'));
  await tester.tap(find.byKey(const Key('locale-de')));
  await tester.pumpAndSettle();
  await waitForWidget(tester, find.text('Sprache'));
  await tester.tap(find.byKey(const Key('locale-fr')));
  await tester.pumpAndSettle();
  await waitForWidget(tester, find.text('Langue'));
  await tester.tap(find.byKey(const Key('locale-ru')));
  await tester.pumpAndSettle();
  await waitForWidget(tester, find.text('Язык'));
  await tester.tap(find.byKey(const Key('locale-en')));
  await tester.pumpAndSettle();
  await waitForWidget(tester, find.text('Language'));
  await tester.tap(find.byTooltip('Back'));
  await tester.pumpAndSettle();
}
