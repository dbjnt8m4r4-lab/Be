import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../services/permission_service.dart';
import '../../../core/widgets/shared/animated_container.dart';
import '../../../core/widgets/shared/app_logo.dart';
import '../../../l10n/app_localizations.dart';
import '../../../core/constants/color_constants.dart';
import '../../settings/providers/settings_provider.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  late PageController _pageController;
  int _currentIndex = 0;
  String _selectedProgram = 'standard';

  // Icons for the welcome pages; titles/descriptions are localized at runtime
  final List<String> _icons = ['done_all', 'show_chart', 'stars'];

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _pageController = PageController();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _animationController.forward();
  }

  Future<void> _markWelcomeComplete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenWelcome', true);
    if (mounted) {
      final settings = Provider.of<SettingsProvider>(context, listen: false);
      settings.setDisciplineProgram(_selectedProgram);
    }
    if (mounted) {
      Navigator.of(context).pushReplacementNamed('/auth-gateway');
    }
  }

  void _skipOrNext(int lastIndex) {
    if (_currentIndex == lastIndex) {
      _markWelcomeComplete();
    } else {
      _pageController.nextPage(
          duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  IconData _mapIconName(String name) {
    switch (name) {
      case 'done_all':
        return Icons.done_all;
      case 'show_chart':
        return Icons.show_chart;
      case 'stars':
        return Icons.stars;
      default:
        return Icons.star;
    }
  }

  String _titleFor(int index, BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    switch (index) {
      case 0:
        return loc.welcomePageTitle1;
      case 1:
        return loc.welcomePageTitle2;
      case 2:
      default:
        return loc.welcomePageTitle3;
    }
  }

  Widget _buildProgramSelection(AppLocalizations loc) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            loc.disciplineProgramTitle,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 12),
          Text(
            loc.disciplineProgramDescription,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          _ProgramOptionCard(
            title: loc.standardProgramName,
            description: loc.standardProgramDescription,
            selected: _selectedProgram == 'standard',
            onTap: () => setState(() => _selectedProgram = 'standard'),
          ),
          const SizedBox(height: 16),
          _ProgramOptionCard(
            title: loc.extraProgramName,
            description: loc.extraProgramDescription,
            selected: _selectedProgram == 'extra',
            badge: loc.extraProgramBadge,
            onTap: () => setState(() => _selectedProgram = 'extra'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final loc = AppLocalizations.of(context)!;
    final totalPages = _icons.length + 2;
    final selectionPageIndex = _icons.length;
    final lastIndex = totalPages - 1;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              ColorConstants.darkGrey,
              ColorConstants.blackColor,
              ColorConstants.darkGrey.withOpacity(0.8),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 12.0, bottom: 4),
                    child: Hero(
                      tag: 'brand-logo',
                      child: AppLogo(
                        size: 96,
                        showWordmark: false,
                      ),
                    ),
                  ),
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: totalPages,
                      onPageChanged: (i) => setState(() => _currentIndex = i),
                      itemBuilder: (context, index) {
                        if (index < _icons.length) {
                          final selected = index == _currentIndex;
                          final title = _titleFor(index, context);
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 24),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Spacer(flex: 2),
                                AnimatedScale(
                                  scale: selected ? 1.2 : 1.0,
                                  duration: const Duration(milliseconds: 600),
                                  curve: Curves.elasticOut,
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 700),
                                    width: 160,
                                    height: 160,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: selected
                                          ? LinearGradient(
                                              colors: [
                                                ColorConstants.priorityHigh
                                                    .withOpacity(0.8),
                                                ColorConstants.priorityHigh
                                                    .withOpacity(0.6),
                                                ColorConstants.blueAccent
                                                    .withOpacity(0.4),
                                              ],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            )
                                          : LinearGradient(
                                              colors: [
                                                (isDark
                                                            ? Colors.white
                                                            : Colors.black)
                                                        .withOpacity(0.1),
                                                (isDark
                                                            ? Colors.white
                                                            : Colors.black)
                                                        .withOpacity(0.05),
                                              ],
                                            ),
                                      border: Border.all(
                                        color: selected
                                            ? ColorConstants.priorityHigh
                                            : (isDark
                                                ? Colors.white30
                                                : Colors.black26),
                                        width: selected ? 4 : 2,
                                      ),
                                      boxShadow: selected
                                          ? [
                                              BoxShadow(
                                                color: ColorConstants
                                                    .priorityHigh
                                                    .withOpacity(0.4),
                                                blurRadius: 30,
                                                spreadRadius: 8,
                                                offset: const Offset(0, 8),
                                              ),
                                              BoxShadow(
                                                color: ColorConstants.blueAccent
                                                    .withOpacity(0.2),
                                                blurRadius: 20,
                                                spreadRadius: 4,
                                                offset: const Offset(0, 4),
                                              ),
                                            ]
                                          : [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.1),
                                                blurRadius: 10,
                                                spreadRadius: 2,
                                                offset: const Offset(0, 4),
                                              ),
                                            ],
                                    ),
                                    child: Center(
                                      child: AnimatedSwitcher(
                                        duration:
                                            const Duration(milliseconds: 500),
                                        transitionBuilder:
                                            (child, animation) {
                                          return ScaleTransition(
                                            scale: animation,
                                            child: FadeTransition(
                                              opacity: animation,
                                              child: child,
                                            ),
                                          );
                                        },
                                        child: Icon(
                                          _mapIconName(_icons[index]),
                                          key: ValueKey<String>(_icons[index]),
                                          size: selected ? 90 : 80,
                                          color: selected
                                              ? Colors.white
                                              : (isDark
                                                  ? Colors.white70
                                                  : Colors.black87),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const Spacer(flex: 2),
                                AnimatedScale(
                                  scale: selected ? 1.0 : 0.96,
                                  duration: const Duration(milliseconds: 300),
                                  child: Text(
                                    title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.copyWith(
                                          fontSize: 32,
                                          fontWeight: FontWeight.w700,
                                          height: 1.2,
                                          color: selected
                                              ? ColorConstants.priorityHigh
                                              : null,
                                        ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const Spacer(flex: 3),
                              ],
                            ),
                          );
                        } else if (index == selectionPageIndex) {
                          return _buildProgramSelection(loc);
                        }

                        // Permissions / final acknowledgement page
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 36),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.permissionsTitle,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(fontSize: 28),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                AppLocalizations.of(context)!.permissionsDesc,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 18),
                              ElevatedButton(
                                onPressed: () async {
                                  final loc = AppLocalizations.of(context)!;
                                  final granted = await PermissionService()
                                      .requestLocationPermission();
                                  if (mounted) {
                                    // ignore: use_build_context_synchronously
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(granted
                                                ? loc.locationPermissionGranted
                                                : loc.locationPermissionDenied)));
                                  }
                                },
                                child: Text(
                                    AppLocalizations.of(context)!.allowLocalization),
                              ),
                              const SizedBox(height: 12),
                              ElevatedButton(
                                onPressed: () async {
                                  final loc = AppLocalizations.of(context)!;
                                  final granted = await PermissionService()
                                      .requestPhonePermission();
                                  if (mounted) {
                                    // ignore: use_build_context_synchronously
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(granted
                                                ? loc.phonePermissionGranted
                                                : loc.phonePermissionDenied)));
                                  }
                                },
                                child: Text(AppLocalizations.of(context)!
                                    .allowPhoneAccess),
                              ),
                              const SizedBox(height: 28),
                              Text(
                                AppLocalizations.of(context)!.goalGoat,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 18),
                              ElevatedButton(
                                onPressed: _markWelcomeComplete,
                                child: Text(AppLocalizations.of(context)!
                                    .iUnderstandGetStarted),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  // Indicators + actions
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 20),
                    child: Row(
                      children: [
                        // Dots
                        Row(
                          children: List.generate(totalPages, (i) {
                            final active = i == _currentIndex;
                            return SimpleAnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              height: 8,
                              width: active ? 20 : 8,
                              padding: EdgeInsets.zero,
                              color: active
                                  ? (isDark ? Colors.white : Colors.black)
                                  : (isDark ? Colors.white30 : Colors.black26),
                              borderRadius: BorderRadius.circular(8),
                              child: const SizedBox.shrink(),
                            );
                          }),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            if (_currentIndex < _icons.length - 1) {
                              _pageController.animateToPage(_icons.length - 1,
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.easeInOut);
                            } else {
                              _markWelcomeComplete();
                            }
                          },
                          child: Text(_currentIndex < lastIndex
                              ? loc.skip
                              : loc.finish),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () => _skipOrNext(lastIndex),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            _currentIndex == lastIndex
                                ? loc.getStarted
                                : loc.next,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProgramOptionCard extends StatelessWidget {
  final String title;
  final String description;
  final bool selected;
  final VoidCallback onTap;
  final String? badge;

  const _ProgramOptionCard({
    required this.title,
    required this.description,
    required this.selected,
    required this.onTap,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: selected ? Colors.black : Colors.black26,
            width: selected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (badge != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  badge!,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Icon(
                  selected ? Icons.check_circle : Icons.circle_outlined,
                  color: Colors.black,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}