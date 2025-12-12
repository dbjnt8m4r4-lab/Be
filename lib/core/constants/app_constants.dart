class AppConstants {
  static const String appName = 'To Be';
  static const String appVersion = '1.0.0';
  
  static const int totalDailyPoints = 100;
  static const int successThreshold = 50;
  
  static const double highPriorityWeight = 1.5;
  static const double normalPriorityWeight = 1.0;
  static const double lowPriorityWeight = 0.5;
  
  static const int defaultTaskDuration = 60;
  static const double subscriptionPrice = 15.0;
  static const int freeTrialDays = 7;
}

class Priority {
  static const String high = 'high';
  static const String normal = 'normal';
  static const String low = 'low';
  
  static double getWeight(String priority) {
    switch (priority) {
      case high: return AppConstants.highPriorityWeight;
      case normal: return AppConstants.normalPriorityWeight;
      case low: return AppConstants.lowPriorityWeight;
      default: return 1.0;
    }
  }
  
}