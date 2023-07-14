import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:encointer_wallet/theme/theme.dart';

class AnimatedCheck extends StatelessWidget {
  const AnimatedCheck({
    required this.progress,
    required this.size,
    this.color,
    super.key,
  });

  final Animation<double> progress;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: AnimatedPathPainter(progress, color ?? context.colorScheme.primary),
      child: SizedBox(width: size, height: size),
    );
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
