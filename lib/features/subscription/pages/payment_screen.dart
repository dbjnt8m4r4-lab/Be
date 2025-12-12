// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import '../../../core/constants/color_constants.dart';
import '../../../l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../providers/subscription_provider.dart';
import 'success_screen.dart';
import '../../auth/providers/auth_provider.dart';
import '../../auth/pages/login_screen.dart';
import '../models/subscription_plan.dart';

enum PaymentMethod { visa, binance }

class PaymentScreen extends StatefulWidget {
  final SubscriptionPlanType initialPlan;

  const PaymentScreen({
    super.key,
    this.initialPlan = SubscriptionPlanType.annual,
  });

  @override
  // ignore: library_private_types_in_public_api
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();
  final _nameController = TextEditingController();
  final _walletController = TextEditingController();
  final _networkController = TextEditingController();
  final _otpController = TextEditingController();

  late SubscriptionPlanType _selectedPlan;
  PaymentMethod _paymentMethod = PaymentMethod.visa;
  bool _authCodeSent = false;

  @override
  void initState() {
    super.initState();
    _selectedPlan = widget.initialPlan;
  }

  Widget _buildPlanTile(AppLocalizations loc, SubscriptionPlanType plan) {
    return RadioListTile<SubscriptionPlanType>(
      value: plan,
      groupValue: _selectedPlan,
      onChanged: (value) {
        if (value != null) {
          setState(() => _selectedPlan = value);
        }
      },
      title: Text(_planTitle(loc, plan)),
      subtitle: Text(_planDescription(loc, plan)),
      secondary: Text('\$${plan.price.toStringAsFixed(0)}'),
    );
  }

  Widget _buildMethodTile(
    AppLocalizations loc,
    PaymentMethod method,
    IconData icon,
  ) {
    final label = method == PaymentMethod.visa
        ? loc.paymentMethodVisa
        : loc.paymentMethodBinance;
    return RadioListTile<PaymentMethod>(
      value: method,
      groupValue: _paymentMethod,
      onChanged: (value) {
        if (value != null) {
          setState(() => _paymentMethod = value);
        }
      },
      title: Text(label),
      secondary: Icon(icon),
    );
  }

  String _planTitle(AppLocalizations loc, SubscriptionPlanType plan) {
    return plan == SubscriptionPlanType.annual
        ? loc.subscriptionAnnual
        : loc.extraProgramName;
  }

  String _planDescription(AppLocalizations loc, SubscriptionPlanType plan) {
    return plan == SubscriptionPlanType.annual
        ? loc.subscriptionAnnualDescription
        : loc.extraProgramPaymentDescription;
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    // Require login for payment flow
    if (authProvider.currentUser == null) {
      final loc = AppLocalizations.of(context)!;
      return Scaffold(
        appBar: AppBar(
          title: Text(loc.subscription),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  loc.paymentRequiresLogin,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  loc.paymentDescription,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                    );
                  },
                  child: Text(loc.loginSignupButton),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(loc.cancel),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(loc.subscription),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                loc.planSelectionTitle,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              _buildPlanTile(loc, SubscriptionPlanType.annual),
              _buildPlanTile(loc, SubscriptionPlanType.extraDiscipline),
              const SizedBox(height: 24),
              Text(
                loc.paymentMethodTitle,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              _buildMethodTile(
                loc,
                PaymentMethod.visa,
                Icons.credit_card,
              ),
              _buildMethodTile(
                loc,
                PaymentMethod.binance,
                Icons.currency_bitcoin,
              ),
              const SizedBox(height: 24),
              if (_paymentMethod == PaymentMethod.visa) ...[
                TextFormField(
                  controller: _cardNumberController,
                  decoration: InputDecoration(
                    labelText: loc.cardNumberLabel,
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.credit_card),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (_paymentMethod != PaymentMethod.visa) return null;
                    if (value == null || value.isEmpty) {
                      return loc.cardNumberRequired;
                    }
                    if (value.length != 16) {
                      return loc.cardNumberLength;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _expiryController,
                        decoration: InputDecoration(
                          labelText: loc.expiryLabel,
                          border: const OutlineInputBorder(),
                          hintText: 'MM/YY',
                        ),
                        validator: (value) {
                          if (_paymentMethod != PaymentMethod.visa) return null;
                          if (value == null || value.isEmpty) {
                            return loc.expiryRequired;
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _cvvController,
                        decoration: InputDecoration(
                          labelText: loc.cvvLabel,
                          border: const OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (_paymentMethod != PaymentMethod.visa) return null;
                          if (value == null || value.isEmpty) {
                            return loc.cvvRequired;
                          }
                          if (value.length != 3) {
                            return loc.cvvLength;
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: loc.cardHolderLabel,
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (_paymentMethod != PaymentMethod.visa) return null;
                    if (value == null || value.isEmpty) {
                      return loc.enterName;
                    }
                    return null;
                  },
                ),
              ] else ...[
                TextFormField(
                  controller: _walletController,
                  decoration: InputDecoration(
                    labelText: loc.walletAddressLabel,
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.account_balance_wallet_outlined),
                  ),
                  validator: (value) {
                    if (_paymentMethod != PaymentMethod.binance) return null;
                    if (value == null || value.isEmpty) {
                      return loc.walletAddressRequired;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _networkController,
                  decoration: InputDecoration(
                    labelText: loc.networkLabel,
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.lan_outlined),
                  ),
                  validator: (value) {
                    if (_paymentMethod != PaymentMethod.binance) return null;
                    if (value == null || value.isEmpty) {
                      return loc.networkRequired;
                    }
                    return null;
                  },
                ),
              ],
              const SizedBox(height: 24),
              TextFormField(
                controller: _otpController,
                decoration: InputDecoration(
                  labelText: loc.authenticationCodeLabel,
                  border: const OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                maxLength: 6,
                validator: (value) {
                  if (value == null || value.length != 6) {
                    return loc.authenticationCodeRequired;
                  }
                  return null;
                },
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    setState(() => _authCodeSent = true);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(loc.authCodeSentMessage)),
                    );
                  },
                  child: Text(_authCodeSent
                      ? loc.authCodeResentLabel
                      : loc.sendAuthenticationCode),
                ),
              ),
              const SizedBox(height: 24),
              Consumer<SubscriptionProvider>(
                builder: (context, subscriptionProvider, child) {
                  return ElevatedButton(
                    onPressed: subscriptionProvider.isLoading
                        ? null
                        : () => _processPayment(context),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: subscriptionProvider.isLoading
                        ? const CircularProgressIndicator()
                        : Text(loc.payAmount(
                            '\$${_selectedPlan.price.toStringAsFixed(0)}')),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _processPayment(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final subscriptionProvider = Provider.of<SubscriptionProvider>(context, listen: false);
      final success = await subscriptionProvider.purchasePlan(_selectedPlan);
      final loc = AppLocalizations.of(context)!;
      
      if (!mounted) return;
      
      if (success) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const SuccessScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(loc.paymentFailed),
            backgroundColor: ColorConstants.accentDark,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    _nameController.dispose();
    _walletController.dispose();
    _networkController.dispose();
    _otpController.dispose();
    super.dispose();
  }
}