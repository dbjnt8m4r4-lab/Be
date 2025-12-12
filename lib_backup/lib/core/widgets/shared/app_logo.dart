import 'package:flutter/material.dart';

/// A simple monochrome logo mark used across splash/login/onboarding screens.
class AppLogo extends StatelessWidget {
  final double size;
  final bool showWordmark;
  final String wordmark;
  final bool emphasizeContrast;

  const AppLogo({
    super.key,
    this.size = 96,
    this.showWordmark = true,
    this.wordmark = 'TO BE',
    this.emphasizeContrast = true,
  });

  @override
  Widget build(BuildContext context) {
    // Logo visuals have been intentionally removed.
    return const SizedBox.shrink();
  }
}

