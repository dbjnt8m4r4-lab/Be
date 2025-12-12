import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/widgets/animated_text_reveal.dart';
import '../../../core/widgets/shared/app_logo.dart';
import '../../../core/constants/color_constants.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  int _currentIndex = 0;
  bool _agreedToPrivacy = false;

  final List<OnboardingPageData> _pages = [
    const OnboardingPageData(
      title: "Tired of being a mess\nand always wasting time?",
      subtitle: "We've got your back",
      showLogo: true,
    ),
    const OnboardingPageData(
      title: "Our goal is to make you\nGOAT",
      subtitle: "(GREATEST OF ALL TIME)",
      showLogo: true,
    ),
    const OnboardingPageData(
      title: "discover your authentic self",
      subtitle: "and achieve your goals",
      showLogo: false,
    ),
    const OnboardingPageData(
      title: "To Be",
      subtitle: "To Be is an app that transforms lazy procrastinators into unstoppable force of nature. No more excuses, no more delays - this app will whip you into shape and make you the disciplined machine you've always wanted to be. Daily use guaranteed to turn you into a productivity beast.",
      showLogo: false,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenOnboarding', true);
    if (mounted) {
      Navigator.of(context).pushReplacementNamed('/auth-gateway');
    }
  }

  void _nextPage() {
    if (_currentIndex < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _previousPage() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // Use normal scaffold background and let pages paint their own backgrounds
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: _pages.length,
              onPageChanged: (index) => setState(() => _currentIndex = index),
              itemBuilder: (context, index) {
                final page = _pages[index];
                // Build content per page and ensure it scrolls to avoid overlap
                final bool isDark = Theme.of(context).brightness == Brightness.dark;

                // Shared visual spacing and layout
                const EdgeInsets contentPadding = EdgeInsets.symmetric(horizontal: 24, vertical: 48);

                // Animated reveal on first three pages (0..2)
                if (index <= 2) {
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      return Container(
                        color: isDark ? Colors.black : Colors.white,
                        child: SafeArea(
                          child: SingleChildScrollView(
                            padding: contentPadding,
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                minHeight: constraints.maxHeight - contentPadding.vertical,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  if (page.showLogo) ...[
                                    const SizedBox(height: 8),
                                    const Hero(tag: 'brand-logo', child: AppLogo(size: 100, showWordmark: false)),
                                    const SizedBox(height: 28),
                                  ],

                                  // Animated text reveal (title then description)
                                  AnimatedTextReveal(
                                    title: page.title,
                                    description: page.subtitle,
                                    titleStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                      fontSize: 40,
                                      fontWeight: FontWeight.w900,
                                      height: 1.05,
                                      color: isDark ? Colors.white : Colors.black,
                                    ),
                                    descriptionStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                      height: 1.4,
                                      color: isDark ? Colors.white70 : Colors.black87,
                                    ),
                                    // Make animation faster and bouncier
                                    duration: const Duration(milliseconds: 600),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }

                // Last page: description, warning, agree + privacy
                return LayoutBuilder(
                  builder: (context, constraints) {
                    return Container(
                      color: isDark ? Colors.black : Colors.white,
                      child: SafeArea(
                        child: SingleChildScrollView(
                          padding: contentPadding.copyWith(top: 20), // Reduced top padding
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: constraints.maxHeight - contentPadding.vertical - 20, // Adjust for padding
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  page.title,
                                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                    fontSize: 32, // Increased size
                                    fontWeight: FontWeight.w900,
                                    color: isDark ? Colors.white : Colors.black,
                                    height: 1.25,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 20),
                                Card(
                                  color: isDark ? const Color(0xFF121212) : Colors.white,
                                  elevation: 8,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      children: [
                                        Text(
                                          page.subtitle,
                                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: isDark ? Colors.white70 : Colors.black87,
                                            height: 1.4,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 18),
                                        Container(
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color: Colors.red.withOpacity(0.12), // Red background
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: const Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(Icons.warning, color: Colors.red), // Red icon
                                              SizedBox(width: 8),
                                              Flexible(
                                                child: Text('Warning: daily use of this app can make you unstoppable!',
                                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)), // Red text
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 18),
                                        ElevatedButton(
                                          onPressed: _agreedToPrivacy ? _completeOnboarding : null,
                                          style: ElevatedButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                            backgroundColor: const Color(0xFF4A90E2),
                                            foregroundColor: Colors.white,
                                          ),
                                          child: const Text('Agree to be Unstoppable'),
                                        ),
                                        const SizedBox(height: 12),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Checkbox(
                                              value: _agreedToPrivacy,
                                              onChanged: (value) {
                                                setState(() {
                                                  _agreedToPrivacy = value ?? false;
                                                });
                                              },
                                              fillColor: WidgetStateProperty.all(const Color(0xFF4A90E2)),
                                              checkColor: Colors.white,
                                            ),
                                            Text(
                                              'I agree to the Privacy Policy',
                                              style: TextStyle(color: isDark ? Colors.white70 : Colors.black87),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),

            // small page progress indicator at top
            Positioned(
              top: 12,
              left: 0,
              right: 0,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(_pages.length, (i) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: _currentIndex == i ? 28 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: _currentIndex == i ? const Color(0xFF4A90E2) : Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),

            // Floating navigation buttons
            if (_currentIndex > 0)
              Positioned(
                left: 24,
                bottom: 48,
                child: FloatingActionButton(
                  onPressed: _previousPage,
                  backgroundColor: ColorConstants.blueAccent.withOpacity(0.9),
                  foregroundColor: Colors.white,
                  child: const Icon(Icons.arrow_back),
                ),
              ),

            if (_currentIndex < _pages.length - 1)
              Positioned(
                right: 24,
                bottom: 48,
                child: FloatingActionButton(
                  onPressed: _nextPage,
                  backgroundColor: ColorConstants.blueAccent.withOpacity(0.9),
                  foregroundColor: Colors.white,
                  child: const Icon(Icons.arrow_forward),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class OnboardingPageData {
  final String title;
  final String subtitle;
  final bool showLogo;

  const OnboardingPageData({
    required this.title,
    required this.subtitle,
    this.showLogo = false,
  });
}
