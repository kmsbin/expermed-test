import 'package:flutter/material.dart';

class GradientPainter extends CustomPainter {
  final Gradient gradient;
  final double strokeWidth;
  final double radius;

  GradientPainter({
    required this.gradient,
    required this.strokeWidth,
    required this.radius
  });

  @override
  void paint(Canvas canvas, Size size) {
    final innerRect = RRect.fromLTRBR(
      strokeWidth,
      strokeWidth,
      size.width - strokeWidth,
      size.height - strokeWidth,
      Radius.circular(radius),
    );
    final outerRect = RRect.fromRectAndRadius(Offset.zero & size, Radius.circular(strokeWidth + radius));
    final Paint p = Paint();
    p.shader = gradient.createShader(outerRect.outerRect);
    Path borderPath = _calculateBorderPath(outerRect, innerRect);
    canvas.drawPath(borderPath, p);
  }

  Path _calculateBorderPath(RRect outerRect, RRect innerRect) {
    Path outerRectPath = Path()..addRRect(outerRect);
    Path innerRectPath = Path()..addRRect(innerRect);
    return Path.combine(PathOperation.difference, outerRectPath, innerRectPath);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}