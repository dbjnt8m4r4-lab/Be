import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/bottom_nav_bar.dart';
import '../../features/goals/pages/goals_screen.dart';
import '../../features/tasks/pages/tasks_screen.dart';
import '../../features/analytics/pages/dashboard_screen.dart';
import '../../features/habits/pages/habits_screen.dart';
import '../../features/settings/pages/settings_screen.dart';
import '../../features/leaderboard/pages/leaderboard_screen.dart';
import '../../core/widgets/motivational_quote_dialog.dart';
import '../../core/utils/motivational_quotes.dart';
import '../../services/notification_service.dart';
import '../../services/hook_model_service.dart';

/// Custom scroll physics that prevents multiple page swipes
class OnePageScrollPhysics extends PageScrollPhysics {
  const OnePageScrollPhysics({super.parent});

  @override
  OnePageScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return OnePageScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  Simulation? createBallisticSimulation(
    ScrollMetrics position,
    double velocity,
  ) {
    // Only allow scrolling to adjacent pages
    final tolerance = toleranceFor(position);
    if (velocity.abs() >= tolerance.velocity || position.outOfRange) {
      final target = _getTargetPixels(position, velocity);
      if (target != position.pixels) {
        return ScrollSpringSimulation(
          spring,
          position.pixels,
          target,
          velocity,
          tolerance: tolerance,
        );
      }
    }
    return null;
  }

  double _getTargetPixels(ScrollMetrics position, double velocity) {
    final tolerance = toleranceFor(position);
    final page = position.pixels / position.viewportDimension;
    if (velocity < -tolerance.velocity) {
      // Swipe left/up - go to previous page
      return (page.floor() * position.viewportDimension).clamp(
        position.minScrollExtent,
        position.maxScrollExtent,
      );
    } else if (velocity > tolerance.velocity) {
      // Swipe right/down - go to next page
      return (page.ceil() * position.viewportDimension).clamp(
        position.minScrollExtent,
        position.maxScrollExtent,
      );
    }
    // Snap to nearest page
    return (page.round() * position.viewportDimension).clamp(
      position.minScrollExtent,
      position.maxScrollExtent,
    );
  }
}

class MainNavigationShell extends StatefulWidget {
  const MainNavigationShell({super.key});

  @override
  State<MainNavigationShell> createState() => _MainNavigationShellState();
}

class _MainNavigationShellState extends State<MainNavigationShell> {
  int _selectedIndex = 0;
  late final PageController _pageController;

  final List<Widget> _screens = [
    const GoalsScreen(), // Index 0: Goals (left)
    const TasksScreen(), // Index 1: Tasks
    const DashboardScreen(), // Index 2: Analytics (middle)
    const HabitsScreen(), // Index 3: Habits
    const SettingsScreen(), // Index 4: Settings (right)
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
    _initializeAndShowQuote();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _initializeAndShowQuote() async {
    // Initialize notification service if not already initialized
    try {
      final notificationService = NotificationService();
      await notificationService.initialize();
    } catch (e) {
      // Ignore initialization errors
    }
    
    // Initialize hook model service
    try {
      final hookService = HookModelService();
      await hookService.handleAppOpening();
      await hookService.scheduleEngagingNotifications();
    } catch (e) {
      // Ignore errors
    }
    
    // Show motivational quote
    await _showMotivationalQuote();
  }

  Future<void> _showMotivationalQuote() async {
    // Wait for the widget to be fully built
    await Future.delayed(const Duration(milliseconds: 800));
    
    if (!mounted) return;
    
    final prefs = await SharedPreferences.getInstance();
    final hasSeenWelcome = prefs.getBool('hasSeenWelcome') ?? false;
    final hasCompletedAuthGate = prefs.getBool('hasCompletedAuthGate') ?? false;
    
    // Only show quote after user has completed initial setup (after first open)
    if (hasSeenWelcome && hasCompletedAuthGate) {
      _showQuoteIfNeeded();
    }
  }
  
  Future<void> _showQuoteIfNeeded() async {
    if (!mounted) return;
    
    final prefs = await SharedPreferences.getInstance();
    final sessionQuoteShown = prefs.getBool('motivationalQuoteShownThisSession') ?? false;
    
    if (!sessionQuoteShown) {
      await prefs.setBool('motivationalQuoteShownThisSession', true);
      
      final quoteObj = MotivationalQuotes.getRandomQuote();
      final quoteText = '${quoteObj.emoji} ${quoteObj.quote}';
      
      // Send notification with the quote
      try {
        final notificationService = NotificationService();
        // Make sure service is initialized
        await notificationService.initialize();
        await notificationService.showMotivationalQuote(quote: quoteText);
      } catch (e) {
        // Ignore notification errors
      }
      
      // Also show dialog
      if (mounted) {
        MotivationalQuoteDialog.show(context);
      }
      
      // Schedule next daily notification (for tomorrow at 8 AM)
      _scheduleDailyMotivationalNotification();
      
      // Schedule engaging motivational notifications
      _scheduleMotivationalNotifications();
    }
  }

  Future<void> _scheduleDailyMotivationalNotification() async {
    try {
      final notificationService = NotificationService();
      // Make sure service is initialized
      await notificationService.initialize();
      
      // Use the existing method that doesn't require parameters
      await notificationService.scheduleDailyMotivationalQuote();
    } catch (e) {
      // Ignore notification errors
    }
  }

  Future<void> _scheduleMotivationalNotifications() async {
    try {
      final notificationService = NotificationService();
      await notificationService.initialize();
      await notificationService.scheduleMotivationalNotifications();
    } catch (e) {
      // Ignore notification errors
    }
  }

  @override
  Widget build(BuildContext context) {
    // Check if current locale is RTL (Arabic)
    final isRTL = Localizations.localeOf(context).languageCode == 'ar';
    
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          elevation: 0,
          actions: [
            // Leaderboard button in top corner (bigger, aligned with title)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                icon: const Icon(Icons.leaderboard, size: 28),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LeaderboardScreen()),
                  );
                },
                tooltip: 'Leaderboard',
              ),
            ),
          ],
        ),
        body: PageView.builder(
          controller: _pageController,
          physics: const OnePageScrollPhysics(), // Strict one-by-one sliding
          reverse: isRTL, // Reverse direction for RTL languages
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          itemCount: _screens.length,
          itemBuilder: (context, index) => _screens[index],
        ),
        bottomNavigationBar: BottomNavBar(
          key: ValueKey(_selectedIndex), // Force rebuild when page changes
          currentIndex: _selectedIndex,
          onTap: (index) {
            // Jump directly to page without animation when tapping
            _pageController.jumpToPage(index);
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
    );
  }
}