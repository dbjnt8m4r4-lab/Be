enum SubscriptionPlanType { annual, extraDiscipline }

extension SubscriptionPlanDetails on SubscriptionPlanType {
  double get price => switch (this) {
        SubscriptionPlanType.annual => 15.0,
        SubscriptionPlanType.extraDiscipline => 25.0,
      };

  Duration get duration => switch (this) {
        SubscriptionPlanType.annual => const Duration(days: 365),
        SubscriptionPlanType.extraDiscipline => const Duration(days: 210),
      };

  String get storageKey => switch (this) {
        SubscriptionPlanType.annual => 'annual',
        SubscriptionPlanType.extraDiscipline => 'extra_discipline',
      };

  String get titleLocalizationKey => switch (this) {
        SubscriptionPlanType.annual => 'subscriptionAnnual',
        SubscriptionPlanType.extraDiscipline => 'extraProgramName',
      };
}

