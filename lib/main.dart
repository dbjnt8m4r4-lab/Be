import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_preview/device_preview.dart';
import 'firebase_options.dart';
import 'l10n/app_localizations.dart';
import 'core/themes/light_theme.dart' as light_theme;
import 'core/themes/dark_theme.dart' as dark_theme;
import 'features/auth/providers/auth_provider.dart';
import 'features/settings/providers/settings_provider.dart';
import 'features/subscription/providers/subscription_provider.dart';
import 'features/leaderboard/providers/leaderboard_provider.dart';
import 'features/habits/providers/habit_provider.dart';
import 'features/analytics/providers/analytics_provider.dart';
import 'features/tasks/providers/task_provider.dart';
import 'features/goals/providers/goal_provider.dart';
import 'features/onboarding/pages/onboarding_screen.dart';
import 'features/welcome/pages/welcome_screen.dart';
import 'features/welcome/pages/welcome_description_screen.dart';
import 'features/auth/pages/auth_gateway_screen.dart';
import 'core/shells/main_navigation_shell.dart';
import 'features/settings/pages/settings_screen.dart';
import 'features/splash/pages/splash_screen.dart';
import 'services/notification_service.dart';
import 'services/auth_service.dart';
import 'services/leaderboard_service.dart';
import 'features/auth/providers/user_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    // allow offline mode if Firebase fails to init
  }

  await NotificationService().init();

  final prefs = await SharedPreferences.getInstance();

  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => MultiProvider(
        providers: [
          Provider(create: (_) => AuthService()),
          Provider(create: (_) => LeaderboardService()),
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => SettingsProvider()),
          ChangeNotifierProvider(create: (_) => SubscriptionProvider()),
          ChangeNotifierProvider(create: (_) => LeaderboardProvider()),
          ChangeNotifierProvider(create: (_) => TaskProvider()),
          ChangeNotifierProvider(create: (_) => GoalProvider()),
          ChangeNotifierProvider(create: (_) => HabitProvider()),
          ChangeNotifierProxyProvider2<TaskProvider, HabitProvider, AnalyticsProvider>(
            create: (_) => AnalyticsProvider(),
            update: (_, taskProvider, habitProvider, analyticsProvider) {
              final provider = analyticsProvider ?? AnalyticsProvider();
              provider.updateData(
                tasks: taskProvider.tasks,
                habits: habitProvider.habits,
              );
              return provider;
            },
          ),
          ChangeNotifierProxyProvider<AuthService, UserProvider>(
            create: (context) => UserProvider(
              context.read<AuthService>(),
              context.read<LeaderboardService>(),
            ),
            update: (context, authService, previous) =>
                previous ?? UserProvider(authService, context.read<LeaderboardService>()),
          ),
        ],
        child: MyApp(sharedPreferences: prefs),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final SharedPreferences? sharedPreferences;

  const MyApp({
    super.key,
    required this.sharedPreferences,
  });

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context);
    final themeMode = settings.theme == 'dark' ? ThemeMode.dark : ThemeMode.light;
    final locale = Locale(settings.language);

    return MaterialApp(
      title: 'To Be',
      debugShowCheckedModeBanner: false,

      // DevicePreview configuration
      locale: DevicePreview.locale(context) ?? locale,
      builder: DevicePreview.appBuilder,

      // Theme configuration
      theme: light_theme.lightThemeData,
      darkTheme: dark_theme.darkThemeData,
      themeMode: themeMode,

      // Localization configuration
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,

      routes: {
        '/onboarding': (context) => const OnboardingScreen(),
        '/welcome': (context) => const WelcomeScreen(),
        '/welcome-description': (context) => const WelcomeDescriptionScreen(),
        '/auth-gateway': (context) => const AuthGatewayScreen(),
        '/main': (context) => const MainNavigationShell(),
        '/settings': (context) => const SettingsScreen(),
      },
      home: sharedPreferences != null
          ? AppInitializer(sharedPreferences: sharedPreferences!)
          : const SplashScreen(),
    );
  }
}

class AppInitializer extends StatefulWidget {
  final SharedPreferences sharedPreferences;

  const AppInitializer({
    super.key,
    required this.sharedPreferences,
  });

  @override
  State<AppInitializer> createState() => _AppInitializerState();
}

class _AppInitializerState extends State<AppInitializer> {
  bool _showSplash = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _showSplash = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_showSplash) {
      return const SplashScreen();
    }

    final hasSeenOnboarding = widget.sharedPreferences.getBool('hasSeenOnboarding') ?? false;
    final hasSeenWelcome = widget.sharedPreferences.getBool('hasSeenWelcome') ?? false;
    final hasSeenWelcomeDescription = widget.sharedPreferences.getBool('hasSeenWelcomeDescription') ?? false;
    final hasCompletedAuthGate = widget.sharedPreferences.getBool('hasCompletedAuthGate') ?? false;

    if (!hasSeenOnboarding) {
      return const OnboardingScreen();
    } else if (!hasSeenWelcome) {
      return const WelcomeScreen();
    } else if (!hasCompletedAuthGate) {
      return const AuthGatewayScreen();
    } else if (!hasSeenWelcomeDescription) {
      return const WelcomeDescriptionScreen();
    } else {
      return const MainNavigationShell();
    }
  }
}