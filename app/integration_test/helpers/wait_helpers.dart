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

/// Scrolls until [item] is visible on screen.
///
/// For lazy-built lists where the widget may not yet exist in the tree,
/// drags [scrollable] by [dyScroll] until the item appears. Once the
/// item is in the tree, uses [WidgetTester.ensureVisible] to
/// programmatically scroll it into the viewport.
Future<void> scrollUntilVisible(
  WidgetTester tester, {
  required Finder scrollable,
  required Finder item,
  double dyScroll = -150,
  int maxScrolls = 50,
}) async {
  // If the item is not yet in the widget tree (lazy list), drag until it appears.
  var attempts = 0;
  while (item.evaluate().isEmpty && attempts < maxScrolls) {
    await tester.drag(scrollable, Offset(0, dyScroll));
    await tester.pumpAndSettle();
    attempts++;
  }
  expect(item, findsWidgets);
  // Programmatically scroll the item into the visible viewport.
  await tester.ensureVisible(item);
  await tester.pumpAndSettle();
}
