import 'package:flutter/material.dart';
import '../../../core/constants/color_constants.dart';
import 'package:provider/provider.dart';
import '../providers/subscription_provider.dart';
import '../widgets/plan_card.dart';
import '../widgets/feature_list.dart';
import '../widgets/trial_banner.dart';
import '../../../data/models/subscription_model.dart';
import 'payment_screen.dart';
import '../models/subscription_plan.dart';
import '../../../l10n/app_localizations.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(loc.subscription),
      ),
      body: Consumer<SubscriptionProvider>(
        builder: (context, subscriptionProvider, child) {
          if (subscriptionProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final subscription = subscriptionProvider.subscription;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (subscriptionProvider.canActivateTrial)
                TrialBanner(
                  onActivate: () {
                    subscriptionProvider.activateTrial();
                  },
                ),
              
              const SizedBox(height: 24),
              
              Text(
                loc.planSelectionTitle,
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 16),
              
              if (subscriptionProvider.hasActiveTrial)
                _buildActiveTrialCard(context, subscription!),

              if (subscriptionProvider.hasActiveSubscription)
                _buildActiveSubscriptionCard(context, subscription!),
              
              if (subscription?.isActive != true) ...[
                PlanCard(
                  title: loc.subscriptionAnnual,
                  price: '\$15',
                  period: loc.perYear,
                  features: [
                    loc.featureAdvancedAnalytics,
                    loc.featureLeaderboard,
                    loc.featureAiManager,
                    loc.featureCustomNotifications,
                    loc.featureUnlimitedTasks,
                    loc.featurePremiumSupport,
                  ],
                  isRecommended: true,
                  badgeText: loc.recommendedLabel,
                  ctaLabel: loc.joinProgramButton,
                  onSubscribe: () {
                    _showPaymentScreen(context, plan: SubscriptionPlanType.annual);
                  },
                ),
                const SizedBox(height: 16),
                PlanCard(
                  title: loc.extraProgramName,
                  price: '\$25',
                  period: loc.perYear,
                  features: [
                    loc.extraProgramDescription,
                    loc.extraProgramPaymentDescription,
                    loc.featureAppBlocking,
                    loc.featurePremiumSupport,
                  ],
                  isRecommended: false,
                  ctaLabel: loc.joinProgramButton,
                  onSubscribe: () {
                    _showPaymentScreen(context, plan: SubscriptionPlanType.extraDiscipline);
                  },
                ),
              ],
              
              const SizedBox(height: 24),
              
              const FeatureList(),
              
              const SizedBox(height: 24),
              
              if (subscriptionProvider.error != null)
                Text(
                  subscriptionProvider.error!,
                  style: const TextStyle(color: ColorConstants.accentLight),
                  textAlign: TextAlign.center,
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildActiveTrialCard(BuildContext context, Subscription subscription) {
    final loc = AppLocalizations.of(context)!;
    return Card(
      color: ColorConstants.accentLight.withAlpha((0.06 * 255).round()),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Icon(Icons.celebration, size: 48, color: ColorConstants.accentDark),
            const SizedBox(height: 16),
            Text(
              loc.trialActiveLabel,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: ColorConstants.accentDark,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${loc.expiresOnLabel} ${_formatDate(subscription.trialEndDate!)}',
              style: const TextStyle(color: ColorConstants.accentDark),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveSubscriptionCard(BuildContext context, Subscription subscription) {
    final loc = AppLocalizations.of(context)!;
    return Card(
      color: ColorConstants.accentLight.withAlpha((0.06 * 255).round()),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Icon(Icons.verified, size: 48, color: ColorConstants.secondaryColor),
            const SizedBox(height: 16),
            Text(
              loc.subscriptionActiveLabel,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: ColorConstants.secondaryColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${loc.expiresOnLabel} ${_formatDate(subscription.expiryDate)}',
              style: const TextStyle(color: ColorConstants.secondaryColor),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Show cancel subscription dialog
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstants.accentDark,
                foregroundColor: ColorConstants.surfaceColor,
              ),
              child: Text(loc.cancelSubscription),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _showPaymentScreen(BuildContext context, {SubscriptionPlanType plan = SubscriptionPlanType.annual}) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PaymentScreen(initialPlan: plan)),
    );
  }
}