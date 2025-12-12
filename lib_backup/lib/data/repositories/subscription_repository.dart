import 'dart:developer';
import '../models/subscription_model.dart';
import '../datasources/local_database.dart';
import '../datasources/api_client.dart';
import '../../features/subscription/models/subscription_plan.dart';

class SubscriptionRepository {
  final LocalDatabase _localDatabase = LocalDatabase();
  final ApiClient _apiClient = ApiClient();

  Future<Subscription> getCurrentSubscription() async {
    try {
      final subscriptionData = await _localDatabase.getMap('subscription');
      if (subscriptionData != null) {
        return Subscription.fromJson(subscriptionData);
      }
      
      // If no local data, try to fetch from server
      try {
        final response = await _apiClient.get('subscription');
        final subscription = Subscription.fromJson(response['data']);
        await _localDatabase.saveMap('subscription', subscription.toJson());
        return subscription;
      } catch (e) {
        // If server fails, return free subscription
        return Subscription(
          isActive: false,
          plan: 'free',
          expiryDate: DateTime.now(),
          price: 0.0,
        );
      }
    } catch (e) {
      log('Error getting subscription: $e', error: e);
      return Subscription(
        isActive: false,
        plan: 'free',
        expiryDate: DateTime.now(),
        price: 0.0,
      );
    }
  }

  Future<void> saveSubscription(Subscription subscription) async {
    try {
      await _localDatabase.saveMap('subscription', subscription.toJson());
      
      // Sync with server
      try {
        await _apiClient.post('subscription', subscription.toJson());
      } catch (e) {
        log('Failed to sync subscription with server: $e', error: e);
      }
    } catch (e) {
      log('Error saving subscription: $e', error: e);
      rethrow;
    }
  }

  Future<bool> activateTrial() async {
    try {
      final trialSubscription = Subscription(
        isActive: true,
        plan: 'trial',
        expiryDate: DateTime.now().add(const Duration(days: 7)),
        price: 0.0,
        isTrial: true,
        trialEndDate: DateTime.now().add(const Duration(days: 7)),
      );
      
      await saveSubscription(trialSubscription);
      return true;
    } catch (e) {
      log('Error activating trial: $e', error: e);
      return false;
    }
  }

  Future<bool> purchasePlan(SubscriptionPlanType plan) async {
    try {
      final newSubscription = Subscription(
        isActive: true,
        plan: plan.storageKey,
        expiryDate: DateTime.now().add(plan.duration),
        price: plan.price,
        isTrial: false,
      );
      
      await saveSubscription(newSubscription);
      return true;
    } catch (e) {
      log('Error purchasing subscription: $e', error: e);
      return false;
    }
  }

  Future<bool> cancelSubscription() async {
    try {
      final currentSubscription = await getCurrentSubscription();
      final cancelledSubscription = Subscription(
        isActive: false,
        plan: currentSubscription.plan,
        expiryDate: currentSubscription.expiryDate,
        price: currentSubscription.price,
        isTrial: currentSubscription.isTrial,
        trialEndDate: currentSubscription.trialEndDate,
      );
      
      await saveSubscription(cancelledSubscription);
      return true;
    } catch (e) {
      log('Error cancelling subscription: $e', error: e);
      return false;
    }
  }
}