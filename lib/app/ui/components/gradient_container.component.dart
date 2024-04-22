import 'package:expermed_test/app/ui/components/gradient_painter.dart';
import 'package:flutter/material.dart';

class GradientContainer extends StatelessWidget {
  final Widget child;
  final double strokeWidth;
  final Gradient gradient;
  final double? radius;

  const GradientContainer({
    required this.gradient,
    required this.child,
    this.strokeWidth = 0,
    this.radius,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: GradientPainter(
        gradient: gradient,
        strokeWidth: strokeWidth,
        radius: radius ?? 10,
      ),
      child: child,
    );
  }
}