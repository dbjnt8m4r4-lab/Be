import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/widgets/shared/app_logo.dart';
import '../../../l10n/app_localizations.dart';
import '../providers/auth_provider.dart';
import 'login_screen.dart';
import 'signup_screen.dart';

class AuthGatewayScreen extends StatelessWidget {
  const AuthGatewayScreen({super.key});

  Future<void> _completeOnboarding(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenWelcome', true);
    await prefs.setBool('hasCompletedAuthGate', true);
    if (context.mounted) {
      Navigator.pushReplacementNamed(context, '/main');
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final authProvider = Provider.of<AuthProvider>(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () => _completeOnboarding(context),
                  child: Text(
                    loc.skipForNow,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurface,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              const Hero(
                tag: 'brand-logo',
                child: AppLogo(
                  size: 120,
                  showWordmark: false,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                loc.authGatewayTitle,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                loc.authGatewaySubtitle,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              
              // Login Button
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    loc.login,
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              
              // Signup Button
              SizedBox(
                height: 50,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SignupScreen()),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: colorScheme.onSurface,
                    side: BorderSide(color: theme.dividerColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    loc.signup,
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              
              // Divider with OR
              Row(
                children: [
                  const Expanded(child: Divider(color: Colors.grey)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      loc.or,
                    style: theme.textTheme.bodySmall?.copyWith(fontSize: 14),
                    ),
                  ),
                  const Expanded(child: Divider(color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 12),
              
              // Google Button
              SizedBox(
                height: 50,
                child: OutlinedButton.icon(
                  onPressed: authProvider.isLoading
                      ? null
                      : () async {
                          final success = await authProvider.loginWithGoogle();
                          if (context.mounted && success) {
                            _completeOnboarding(context);
                          }
                        },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: colorScheme.onSurface,
                    side: BorderSide(color: theme.dividerColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  icon: const Icon(Icons.g_mobiledata, size: 24),
                  label: Text(
                    loc.continueWithGoogle,
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              
              // Apple Button
              SizedBox(
                height: 50,
                child: OutlinedButton.icon(
                  onPressed: authProvider.isLoading
                      ? null
                      : () async {
                          final success = await authProvider.loginWithApple();
                          if (context.mounted && success) {
                            _completeOnboarding(context);
                          }
                        },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: colorScheme.onSurface,
                    side: BorderSide(color: theme.dividerColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  icon: const Icon(Icons.apple, size: 24),
                  label: Text(
                    loc.continueWithApple,
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              
              // Skip hint
              Text(
                loc.skipHint,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}