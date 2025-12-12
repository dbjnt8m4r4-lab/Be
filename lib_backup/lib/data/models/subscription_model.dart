class Subscription {
  final bool isActive;
  final String plan;
  final DateTime expiryDate;
  final double price;
  final bool isTrial;
  final DateTime? trialEndDate;

  Subscription({
    required this.isActive,
    required this.plan,
    required this.expiryDate,
    required this.price,
    this.isTrial = false,
    this.trialEndDate,
  });

  bool get isExpired => expiryDate.isBefore(DateTime.now());
  bool get hasActiveTrial => isTrial && trialEndDate!.isAfter(DateTime.now());

  Map<String, dynamic> toJson() {
    return {
      'isActive': isActive,
      'plan': plan,
      'expiryDate': expiryDate.toIso8601String(),
      'price': price,
      'isTrial': isTrial,
      'trialEndDate': trialEndDate?.toIso8601String(),
    };
  }

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      isActive: json['isActive'],
      plan: json['plan'],
      expiryDate: DateTime.parse(json['expiryDate']),
      price: (json['price'] as num).toDouble(),
      isTrial: json['isTrial'],
      trialEndDate: json['trialEndDate'] != null 
          ? DateTime.parse(json['trialEndDate']) 
          : null,
    );
  }
}