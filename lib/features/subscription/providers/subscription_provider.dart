import 'package:flutter/material.dart';
import '../../../data/models/subscription_model.dart';
import '../../../data/repositories/subscription_repository.dart';
import '../../auth/providers/auth_provider.dart';
import '../models/subscription_plan.dart';

class SubscriptionProvider with ChangeNotifier {
  final SubscriptionRepository _repository = SubscriptionRepository();
  AuthProvider? _authProvider; // Make it nullable
  Subscription? _subscription;
  bool _isLoading = false;
  String? _error;

  Subscription? get subscription => _subscription;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Make constructor parameter optional
  SubscriptionProvider([this._authProvider]) {
    loadSubscription();
  }

  // Method to set auth provider later if needed
  void setAuthProvider(AuthProvider authProvider) {
    _authProvider = authProvider;
  }

  Future<void> loadSubscription() async {
    _isLoading = true;
    notifyListeners();

    try {
      _subscription = await _repository.getCurrentSubscription();
    } catch (e) {
      _error = 'فشل في تحميل بيانات الاشتراك';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> purchasePlan(SubscriptionPlanType plan) async {
    // Check if user is logged in - now handles null case
    if (_authProvider?.currentUser == null) {
      _error = 'Payment requires login';
      notifyListeners();
      return false;
    }

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final success = await _repository.purchasePlan(plan);
      if (success) {
        await loadSubscription();
      }
      return success;
    } catch (e) {
      _error = 'Failed to purchase subscription';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> purchaseAnnualSubscription() {
    return purchasePlan(SubscriptionPlanType.annual);
  }

  Future<bool> activateTrial() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final success = await _repository.activateTrial();
      if (success) {
        await loadSubscription();
      }
      return success;
    } catch (e) {
      _error = 'Failed to activate trial';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> cancelSubscription() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final success = await _repository.cancelSubscription();
      if (success) {
        await loadSubscription();
      }
      return success;
    } catch (e) {
      _error = 'Failed to cancel subscription';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  bool get hasActiveSubscription {
    return _subscription?.isActive == true && !_subscription!.isExpired;
  }

  bool get hasActiveTrial {
    return _subscription?.hasActiveTrial == true;
  }

  bool get canActivateTrial {
    return _subscription == null || 
           (!_subscription!.hasActiveTrial && !_subscription!.isActive);
  }
}