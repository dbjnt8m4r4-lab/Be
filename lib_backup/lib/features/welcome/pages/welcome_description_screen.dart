import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../l10n/app_localizations.dart';

class WelcomeDescriptionScreen extends StatelessWidget {
  const WelcomeDescriptionScreen({super.key});

  Future<void> _completeWelcome(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenWelcomeDescription', true);
    if (context.mounted) {
      Navigator.pushReplacementNamed(context, '/main');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center, // Changed to center
              children: [
                // Header with icon
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: colorScheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      Icons.rocket_launch,
                      size: 56,
                      color: colorScheme.primary,
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // Main title
                Text(
                  loc.toBeTitle,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                    fontSize: 36,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 16),

                // Main description
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: colorScheme.primary.withOpacity(0.2),
                      width: 1.5,
                    ),
                  ),
                  child: Text(
                    loc.welcomeDescriptionMain,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      height: 1.6,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 28),

                // Features section
                Text(
                  loc.featureKeyFeatures,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 16),

                // Feature items
                _buildFeatureItem(
                  context,
                  Icons.check_circle,
                  loc.featureLockIn,
                  loc.featureLockInDesc,
                  colorScheme,
                ),
                _buildFeatureItem(
                  context,
                  Icons.block,
                  loc.featureDestroy,
                  loc.featureDestroyDesc,
                  colorScheme,
                ),
                _buildFeatureItem(
                  context,
                  Icons.trending_up,
                  loc.featureLevelUp,
                  loc.featureLevelUpDesc,
                  colorScheme,
                ),
                _buildFeatureItem(
                  context,
                  Icons.groups,
                  loc.featureCommunity,
                  loc.featureCommunityDesc,
                  colorScheme,
                ),

                const SizedBox(height: 28),

                // Warning section
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.orange.withOpacity(0.3),
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.warning_rounded,
                        color: Colors.orange[700],
                        size: 28,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                      child: Text(
                        loc.warningMessage,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                            color: isDark
                                ? Colors.orange[300]
                                : Colors.orange[800],
                          ),
                          textAlign: TextAlign.center, // Centered text
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 36),

                // CTA Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () => _completeWelcome(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                    ),
                    child: Text(
                      loc.agreeToLockIn,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Skip button
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: OutlinedButton(
                    onPressed: () => _completeWelcome(context),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: colorScheme.primary,
                      side: BorderSide(
                        color: colorScheme.primary.withOpacity(0.5),
                        width: 1.5,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      loc.skipForNow,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: colorScheme.primary,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem(
    BuildContext context,
    IconData icon,
    String title,
    String description,
    ColorScheme colorScheme,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: colorScheme.primary.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              size: 24,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
