import 'package:expermed_test/app/ui/constants/colors.dart';
import 'package:expermed_test/app/ui/constants/spacing.dart';
import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {
  final GestureTapCallback? onTap;
  final Color backgroundColor;
  final Widget title;
  final Key? buttonKey;

  const BottomButton({
    required this.onTap,
    required this.title,
    this.backgroundColor = appBackgroundColor,
    this.buttonKey,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black38.withOpacity(0.4),
            spreadRadius: 0,
            blurRadius: 5,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(kPadding),
      child: SafeArea(
        child: FilledButton(
          key: buttonKey,
          onPressed: onTap,
          child: title,
        ),
      ),
    );
  }
}