import 'package:flutter/rendering.dart';
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

/// Returns true if [finder] matches at least one widget whose center
/// is within the screen bounds (i.e. actually hittable, not just in the tree).
bool _isVisibleOnScreen(WidgetTester tester, Finder finder) {
  final elements = finder.evaluate();
  if (elements.isEmpty) return false;
  for (final element in elements) {
    final renderObject = element.renderObject;
    if (renderObject is RenderBox && renderObject.hasSize) {
      final center = renderObject.localToGlobal(renderObject.size.center(Offset.zero));
      final screen = tester.binding.rootElement!.renderObject!;
      if (screen is RenderBox) {
        final screenSize = screen.size;
        if (center.dx >= 0 && center.dx <= screenSize.width && center.dy >= 0 && center.dy <= screenSize.height) {
          return true;
        }
      }
    }
  }
  return false;
}

/// Repeatedly drags [scrollable] by [dyScroll] until [item] is visible
/// **on screen** (not just in the widget tree), or [maxScrolls] attempts
/// are exhausted.
Future<void> scrollUntilVisible(
  WidgetTester tester, {
  required Finder scrollable,
  required Finder item,
  double dyScroll = -150,
  int maxScrolls = 50,
}) async {
  var attempts = 0;
  while (!_isVisibleOnScreen(tester, item) && attempts < maxScrolls) {
    await tester.drag(scrollable, Offset(0, dyScroll));
    await tester.pumpAndSettle();
    attempts++;
  }
  expect(item, findsWidgets);
}
