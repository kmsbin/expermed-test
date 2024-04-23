import 'dart:ui';

import 'package:expermed_test/app/ui/constants/spacing.dart';
import 'package:flutter/material.dart';

class TopSnackBar extends StatefulWidget {
  final String message;
  const TopSnackBar({required this.message, super.key});

  @override
  State<TopSnackBar> createState() => _TopSnackBarState();
}

class _TopSnackBarState extends State<TopSnackBar> with TickerProviderStateMixin {
  static const _iconSize = 30.0;
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
    _scaleAnimation = Tween<double>(begin: 0.6, end: 3).animate(_controller);
    _fadeAnimation = Tween<double>(begin: 1, end: 0.5).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SizedBox(
        width: 50,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 400,
          ),
          child: Container(
            padding: const EdgeInsets.all(kPadding),
            width: 1,
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: const Color(0xff1b2c3b),
                borderRadius: BorderRadius.circular(kPadding / 2),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 8),
                    spreadRadius: 1,
                    blurRadius: 30,
                  ),
                ],
              ),
              // width: double.infinity,
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                          radius: 1.3,
                          focalRadius: 0.7,
                          focal: const Alignment(-0.9, 0),
                          colors: [
                            Colors.red.withOpacity(0.3),
                            Colors.transparent,
                          ],
                        ),
                      ),
                      alignment:  Alignment.centerLeft,
                      child: const Padding(
                        padding: EdgeInsets.all(kPadding),
                        child: Icon(
                          Icons.cancel,
                          color: Colors.red,
                          size: _iconSize,
                        ),
                      ),
                    ),
                  ),
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: ScaleTransition(
                      scale: _scaleAnimation,
                      child: Padding(
                        padding: const EdgeInsets.all(kPadding),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                          child: Container(
                            width: _iconSize,
                            height: _iconSize,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red.withOpacity(0.3),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: kPadding * 2 + _iconSize,
                    child: Padding(
                      padding: const EdgeInsets.only(left: kPadding*2 + _iconSize, right: kPadding),
                      child: SizedBox(
                        height: _iconSize,
                        child: Center(
                          child: Text(
                            widget.message,
                            style: const TextStyle(fontSize: 15),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
