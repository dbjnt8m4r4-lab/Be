import 'package:flutter/material.dart';

class SimpleAnimatedContainer extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;
  final double? height;
  final double? width;
  final EdgeInsets? padding;
  final Color? color;
  final BorderRadius? borderRadius;

  const SimpleAnimatedContainer({
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
    this.height,
    this.width,
    this.padding,
    this.color,
    this.borderRadius,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: duration,
      curve: curve,
      height: height,
      width: width,
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius,
      ),
      child: child,
    );
  }
}