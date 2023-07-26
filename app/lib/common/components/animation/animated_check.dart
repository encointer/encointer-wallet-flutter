import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:encointer_wallet/theme/theme.dart';

class AnimatedCheck extends StatefulWidget {
  const AnimatedCheck({
    this.size = 100,
    this.animate = true,
    this.color = Colors.white,
    super.key,
  });

  final bool animate;
  final double size;
  final Color? color;

  @override
  State<AnimatedCheck> createState() => _AnimatedCheckState();
}

class _AnimatedCheckState extends State<AnimatedCheck> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _animation;
  late final Timer _timer;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 1))..forward();
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOutCirc),
    );
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) => _animateTick());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: AnimatedPathPainter(_animation, widget.color ?? context.colorScheme.primary),
      child: SizedBox(width: widget.size, height: widget.size),
    );
  }

  void _animateTick() {
    if (widget.animate && context.mounted) {
      _animationController.repeat(period: const Duration(milliseconds: 1500));
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _timer.cancel();
    super.dispose();
  }
}

class AnimatedPathPainter extends CustomPainter {
  const AnimatedPathPainter(this.animation, this.color) : super(repaint: animation);

  final Animation<double> animation;
  final Color color;

  Path _createAnyPath(Size size) {
    return Path()
      ..moveTo(0.27083 * size.width, 0.54167 * size.height)
      ..lineTo(0.41667 * size.width, 0.68750 * size.height)
      ..lineTo(0.75000 * size.width, 0.35417 * size.height);
  }

  Path createAnimatedPath(Path originalPath, double animationPercent) {
    final totalLength =
        // ignore: prefer_int_literals
        originalPath.computeMetrics().fold(0.0, (double prev, PathMetric metric) => prev + metric.length);
    final currentLength = totalLength * animationPercent;

    return extractPathUntilLength(originalPath, currentLength);
  }

  Path extractPathUntilLength(Path originalPath, double length) {
    var currentLength = 0.0;
    final path = Path();
    final metricsIterator = originalPath.computeMetrics().iterator;

    while (metricsIterator.moveNext()) {
      final metric = metricsIterator.current;
      final nextLength = currentLength + metric.length;
      final isLastSegment = nextLength > length;
      if (isLastSegment) {
        final remainingLength = length - currentLength;
        final pathSegment = metric.extractPath(0, remainingLength);
        path.addPath(pathSegment, Offset.zero);
        break;
      } else {
        final pathSegment = metric.extractPath(0, metric.length);
        path.addPath(pathSegment, Offset.zero);
      }
      currentLength = nextLength;
    }
    return path;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final animationPercent = animation.value;
    final path = createAnimatedPath(_createAnyPath(size), animationPercent);
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.06;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
