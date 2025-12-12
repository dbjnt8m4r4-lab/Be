import 'package:flutter/material.dart';
import '../../../core/widgets/animated_text_reveal.dart';
import '../../../l10n/app_localizations.dart';

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  late PageController _pageController;
  int _currentPage = 0;

  late List<TutorialPage> tutorialPages;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    // Initialize tutorial pages with context
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _buildTutorialPages();
    });
  }

  void _buildTutorialPages() {
    final loc = AppLocalizations.of(context)!;
    tutorialPages = [
      TutorialPage(
        title: loc.tutorialWelcomeTitle,
        description: loc.tutorialWelcomeDesc,
        icon: Icons.rocket_launch,
        color: Colors.blue,
        isAggressiveStyle: true,
        hasAnimatedText: true,
      ),
      TutorialPage(
        title: loc.tutorialLockInTitle,
        description: loc.tutorialLockInDesc,
        icon: Icons.check_circle,
        color: Colors.green,
        tips: [
          loc.tutorialLockInTip1,
          loc.tutorialLockInTip2,
          loc.tutorialLockInTip3,
          loc.tutorialLockInTip4,
        ],
        isAggressiveStyle: true,
        hasAnimatedText: true,
      ),
      TutorialPage(
        title: loc.tutorialDestroyTitle,
        description: loc.tutorialDestroyDesc,
        icon: Icons.block,
        color: Colors.red,
        tips: [
          loc.tutorialDestroyTip1,
          loc.tutorialDestroyTip2,
          loc.tutorialDestroyTip3,
          loc.tutorialDestroyTip4,
        ],
      ),
      TutorialPage(
        title: loc.tutorialProgressTitle,
        description: loc.tutorialProgressDesc,
        icon: Icons.trending_up,
        color: Colors.purple,
        tips: [
          loc.tutorialProgressTip1,
          loc.tutorialProgressTip2,
          loc.tutorialProgressTip3,
          loc.tutorialProgressTip4,
        ],
      ),
      TutorialPage(
        title: loc.tutorialTasksTitle,
        description: loc.tutorialTasksDesc,
        icon: Icons.check_box,
        color: Colors.orange,
        tips: [
          loc.tutorialTasksTip1,
          loc.tutorialTasksTip2,
          loc.tutorialTasksTip3,
          loc.tutorialTasksTip4,
        ],
      ),
      TutorialPage(
        title: loc.tutorialCommunityTitle,
        description: loc.tutorialCommunityDesc,
        icon: Icons.groups,
        color: Colors.teal,
        tips: [
          loc.tutorialCommunityTip1,
          loc.tutorialCommunityTip2,
          loc.tutorialCommunityTip3,
          loc.tutorialCommunityTip4,
        ],
      ),
      TutorialPage(
        title: loc.tutorialAnalyticsTitle,
        description: loc.tutorialAnalyticsDesc,
        icon: Icons.analytics,
        color: Colors.indigo,
        tips: [
          loc.tutorialAnalyticsTip1,
          loc.tutorialAnalyticsTip2,
          loc.tutorialAnalyticsTip3,
          loc.tutorialAnalyticsTip4,
        ],
      ),
      TutorialPage(
        title: loc.tutorialSettingsTitle,
        description: loc.tutorialSettingsDesc,
        icon: Icons.settings,
        color: Colors.grey,
        tips: [
          loc.tutorialSettingsTip1,
          loc.tutorialSettingsTip2,
          loc.tutorialSettingsTip3,
          loc.tutorialSettingsTip4,
        ],
      ),
    ];
    setState(() {});
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final loc = AppLocalizations.of(context)!;
    
    if (tutorialPages.isEmpty) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.howToUseToBe),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: colorScheme.primary,
      ),
      body: Column(
        children: [
          // Page Indicator
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Step ${_currentPage + 1}/${tutorialPages.length}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.primary,
                    fontSize: 14,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: (_currentPage + 1) / tutorialPages.length,
                        minHeight: 4,
                        backgroundColor: colorScheme.primary.withOpacity(0.2),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Page View
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: tutorialPages.length,
              itemBuilder: (context, index) {
                return _buildTutorialPage(
                  context,
                  tutorialPages[index],
                  colorScheme,
                );
              },
            ),
          ),

          // Bottom Navigation
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // Dots indicator
                Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      tutorialPages.length,
                      (index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Container(
                          width: _currentPage == index ? 24 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: _currentPage == index
                                ? tutorialPages[_currentPage].color
                                : colorScheme.primary.withOpacity(0.2),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // Action buttons
                Row(
                  children: [
                    if (_currentPage > 0)
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            _pageController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            side: BorderSide(
                              color: colorScheme.primary.withOpacity(0.5),
                            ),
                          ),
                          child: Text(
                            loc.previous,
                            style: TextStyle(color: colorScheme.primary),
                          ),
                        ),
                      ),
                    if (_currentPage > 0) const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_currentPage < tutorialPages.length - 1) {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          } else {
                            Navigator.pop(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          backgroundColor: tutorialPages[_currentPage].color,
                        ),
                          child: Text(
                            _currentPage == tutorialPages.length - 1 ? loc.done : loc.next,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTutorialPage(
    BuildContext context,
    TutorialPage page,
    ColorScheme colorScheme,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // Icon - Bigger for aggressive style
          Container(
            width: page.isAggressiveStyle ? 130 : 100,
            height: page.isAggressiveStyle ? 130 : 100,
            decoration: BoxDecoration(
              color: page.color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              page.icon,
              size: page.isAggressiveStyle ? 72 : 56,
              color: page.color,
            ),
          ),

          const SizedBox(height: 32),

          // Title and Description - Animated for first 2 pages
          if (page.isAggressiveStyle && page.hasAnimatedText)
            AnimatedTextReveal(
              title: page.title,
              description: page.description,
              titleStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w900,
                fontSize: 52,
                letterSpacing: 1.2,
                height: 1.2,
                fontFamily: 'SFProDisplay',
              ),
              descriptionStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: 22,
                height: 1.8,
                color: Colors.grey[700],
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
                fontFamily: 'SFProDisplay',
              ),
            )
          else if (page.isAggressiveStyle)
            Column(
              children: [
                Text(
                  page.title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w900,
                    fontSize: 52,
                    letterSpacing: 1.2,
                    height: 1.2,
                    fontFamily: 'SFProDisplay',
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Text(
                  page.description,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 22,
                    height: 1.8,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.3,
                    fontFamily: 'SFProDisplay',
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            )
          else
            Column(
              children: [
                Text(
                  page.title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                    fontFamily: 'SFProDisplay',
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  page.description,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 18,
                    height: 1.6,
                    color: Colors.grey[600],
                    fontFamily: 'SFProDisplay',
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),

          // Tips section
          if (page.tips.isNotEmpty) ...[
            const SizedBox(height: 32),
            Container(
              decoration: BoxDecoration(
                color: page.color.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: page.color.withOpacity(0.2),
                  width: 1.5,
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Quick Tips',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: page.color,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...page.tips.map((tip) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: page.color.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Icon(
                              Icons.check,
                              size: 14,
                              color: page.color,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              tip,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontSize: 13,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

}

class TutorialPage {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final List<String> tips;
  final bool isAggressiveStyle;
  final bool hasAnimatedText;

  TutorialPage({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    this.tips = const [],
    this.isAggressiveStyle = false,
    this.hasAnimatedText = false,
  });
}