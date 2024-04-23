import 'package:flutter/material.dart';

import '../constants/spacing.dart';

class LinearGradientButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  
  const LinearGradientButton({
    required this.onPressed,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      key: const Key('sign_in_button'),
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kPadding),
      ),
      child: IntrinsicHeight(
        child: Ink(
          padding: const EdgeInsets.all(kPadding),
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kPadding),
              gradient: const LinearGradient(colors: [Color(0xff1b2c3b), Color(0xff0B1C2B)])
          ),
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }
}
