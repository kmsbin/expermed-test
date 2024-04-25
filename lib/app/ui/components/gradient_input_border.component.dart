import 'package:flutter/material.dart';

import 'gradient_container.component.dart';

class GradientBorder extends StatelessWidget {
  final Widget child;
  final Color contentStartGradient;

  const GradientBorder({
    required this.child,
    this.contentStartGradient = Colors.white24,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: GradientContainer(
        gradient: _getGradientConfig([Colors.white, Colors.transparent]),
        child: Container(
          decoration: BoxDecoration(
            gradient: _getGradientConfig([contentStartGradient, Colors.transparent]),
            borderRadius: BorderRadius.circular(10),
          ),
          child: child,
        ),
      ),
    );
  }
  
  Gradient _getGradientConfig(List<Color> colors) {
    return RadialGradient(
      colors: colors,
      radius: 7,
      focal: const Alignment(-0.55, -2.6),
    );
  }
}
