import 'package:flutter_test/flutter_test.dart';

/// Polls [tester.pump] until [finder] matches at least one widget,
/// or [timeout] is exceeded.
Future<void> waitForWidget(
  WidgetTester tester,
  Finder finder, {
  Duration timeout = const Duration(seconds: 30),
}) async {
  final end = DateTime.now().add(timeout);
  while (DateTime.now().isBefore(end)) {
    await tester.pump(const Duration(milliseconds: 100));
    if (finder.evaluate().isNotEmpty) return;
  }
  // Final pump + settle before asserting (gives a clear error).
  await tester.pumpAndSettle();
  expect(finder, findsWidgets);
}

/// Repeatedly drags [scrollable] by [dyScroll] until [item] is visible,
/// or [maxScrolls] attempts are exhausted.
Future<void> scrollUntilVisible(
  WidgetTester tester, {
  required Finder scrollable,
  required Finder item,
  double dyScroll = -150,
  int maxScrolls = 50,
}) async {
  var attempts = 0;
  while (item.evaluate().isEmpty && attempts < maxScrolls) {
    await tester.drag(scrollable, Offset(0, dyScroll));
    await tester.pumpAndSettle();
    attempts++;
  }
  expect(item, findsWidgets);
}
