import 'package:flutter/material.dart';

class GradientCard extends StatelessWidget {
  final Widget child;
  final Gradient? gradient;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final VoidCallback? onTap;

  const GradientCard({super.key, 
    required this.child,
    this.gradient,
    this.borderRadius,
    this.padding,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(16),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: gradient ??
              LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).primaryColor.withAlpha((0.1 * 255).round()),
                  Theme.of(context).primaryColor.withAlpha((0.05 * 255).round()),
                ],
              ),
          borderRadius: borderRadius ?? BorderRadius.circular(16),
        ),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: onTap,
            borderRadius: borderRadius ?? BorderRadius.circular(16),
            child: Padding(
              padding: padding ?? const EdgeInsets.all(16),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}