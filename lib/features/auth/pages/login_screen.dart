import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../l10n/app_localizations.dart';
import '../providers/auth_provider.dart';
import '../widgets/turnstile_auth_wrapper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();
  final _turnstileKey = GlobalKey<TurnstileAuthWrapperState>();
  bool _usePhoneAuth = false;
  bool _codeVerificationNeeded = false;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.login),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 32),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
              if (!_usePhoneAuth) ...[
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: loc.emailLabel,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return loc.enterEmail;
                        }
                        return null;
                      },
                    ),
                const SizedBox(height: 16),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: loc.passwordLabel,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return loc.enterPassword;
                        }
                        return null;
                      },
                    ),
                const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () => _showForgotPasswordDialog(context),
                        child: Text(loc.forgotPassword),
                      ),
                    ),
              ] else if (_codeVerificationNeeded) ...[
                    Text(
                      loc.wesentVerificationCode(_phoneController.text),
                      style: textTheme.bodyMedium,
                    ),
                const SizedBox(height: 16),
                    TextFormField(
                      controller: _codeController,
                      decoration: InputDecoration(
                        labelText: loc.authenticationCodeLabel,
                        hintText: '000000',
                        prefixIcon: const Icon(Icons.confirmation_number),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return loc.authenticationCodeRequired;
                        }
                        if (value.length != 6) {
                          return loc.codeMustBeSixDigits;
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                    ),
              ] else ...[
                    TextFormField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        labelText: loc.phoneNumber,
                        hintText: '+1234567890',
                        prefixIcon: const Icon(Icons.phone),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return loc.pleaseEnterPhoneNumber;
                        }
                        return null;
                      },
                      keyboardType: TextInputType.phone,
                    ),
              ],
              const SizedBox(height: 16),
                    Consumer<AuthProvider>(
                      builder: (context, authProvider, child) {
                        if (authProvider.error != null) {
                          return Text(
                            authProvider.error!,
                            style: textTheme.bodyMedium?.copyWith(color: theme.colorScheme.error),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
              const SizedBox(height: 16),
              if (!_codeVerificationNeeded)
                TurnstileAuthWrapper(
                  key: _turnstileKey,
                  siteKey: 'YOUR_SITE_KEY',
                  baseUrl: 'https://your-domain.example/',
                  child: Consumer<AuthProvider>(
                    builder: (context, authProvider, child) {
                      return SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: authProvider.isLoading
                              ? null
                              : () => _usePhoneAuth ? _sendVerificationCode(context) : _login(context),
                          style: FilledButton.styleFrom(
                            minimumSize: const Size(double.infinity, 48),
                          ),
                          child: authProvider.isLoading
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  ),
                                )
                              : Text(
                                  _usePhoneAuth ? loc.sendAuthenticationCode.toUpperCase() : loc.login.toUpperCase(),
                                  style: textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.5,
                                    color: theme.colorScheme.onPrimary,
                                  ),
                                ),
                        ),
                      );
                    },
                  ),
                ),
              if (_codeVerificationNeeded)
                Consumer<AuthProvider>(
                  builder: (context, authProvider, child) {
                    return SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: authProvider.isLoading ? null : () => _verifyCode(context),
                        style: FilledButton.styleFrom(minimumSize: const Size(double.infinity, 48)),
                        child: authProvider.isLoading
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              )
                            : Text(
                                loc.verifyCode.toUpperCase(),
                                style: textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                  color: theme.colorScheme.onPrimary,
                                ),
                              ),
                      ),
                    );
                  },
                ),
              const SizedBox(height: 16),
              // Toggle between email and phone auth
                    Card(
                      color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.6),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          children: [
                            const Icon(Icons.email_outlined, size: 20),
                            Expanded(
                              child: Center(
                                child: Text(
                                  loc.emailOption,
                                  style: textTheme.bodyMedium,
                                ),
                              ),
                            ),
                            Switch(
                              value: _usePhoneAuth,
                              onChanged: (value) {
                                setState(() {
                                  _usePhoneAuth = value;
                                  _codeVerificationNeeded = false;
                                  _codeController.clear();
                                });
                              },
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  loc.phoneOption,
                                  style: textTheme.bodyMedium,
                                ),
                              ),
                            ),
                            const Icon(Icons.phone_iphone, size: 20),
                          ],
                        ),
                      ),
                    ),
              const SizedBox(height: 16),
              // Divider with OR
                    Row(
                      children: [
                        const Expanded(child: Divider()),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(loc.or, style: textTheme.bodyMedium),
                        ),
                        const Expanded(child: Divider()),
                      ],
                    ),
              const SizedBox(height: 16),
              // Google Login Button
                    OutlinedButton.icon(
                      onPressed: Provider.of<AuthProvider>(context, listen: false).isLoading
                          ? null
                          : () => _loginWithGoogle(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        foregroundColor: theme.colorScheme.onSurface,
                        backgroundColor: theme.colorScheme.surface,
                      ),
                      icon: Image.asset(
                        'assets/images/google_logo.png',
                        height: 24,
                        width: 24,
                        errorBuilder: (context, error, stackTrace) => Icon(Icons.g_mobiledata, size: 28, color: theme.colorScheme.primary),
                      ),
                      label: Text(loc.continueWithGoogle),
                    ),
              const SizedBox(height: 12),
              // Apple Login Button
                    OutlinedButton.icon(
                      onPressed: _isLoading ? null : () => _loginWithApple(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        foregroundColor: theme.colorScheme.onSurface,
                        backgroundColor: theme.colorScheme.surface,
                      ),
                      icon: const Icon(Icons.apple, size: 28),
                      label: Text(loc.continueWithApple),
                    ),
              const SizedBox(height: 24),
              // Sign up link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          loc.dontHaveAccountPrefix,
                          style: textTheme.bodyMedium,
                        ),
                        TextButton(
                          onPressed: Provider.of<AuthProvider>(context, listen: false).isLoading
                              ? null
                              : () => Navigator.pushReplacementNamed(context, '/signup'),
                          child: Text(loc.signup),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ... rest of the methods remain the same
  Future<void> _login(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    final turnstileState = _turnstileKey.currentState;
    if (turnstileState == null || !turnstileState.isVerified) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete the verification')),
      );
      return;
    }

    try {
      final token = turnstileState.token;
      await Provider.of<AuthProvider>(context, listen: false).login(
        _emailController.text.trim(),
        _passwordController.text,
        turnstileToken: token,
      );
      // Navigation after successful login is handled by AuthGateway/onboarding
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  bool get _isLoading => Provider.of<AuthProvider>(context, listen: false).isLoading;

  Future<void> _loginWithGoogle(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final success = await authProvider.loginWithGoogle();
    if (success && context.mounted) {
      Navigator.pushReplacementNamed(context, '/main');
    }
  }

  Future<void> _loginWithApple(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final success = await authProvider.loginWithApple();
    if (success && context.mounted) {
      Navigator.pushReplacementNamed(context, '/main');
    }
  }

  void _showForgotPasswordDialog(BuildContext context) {
    final resetEmailController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.forgotPassword, style: const TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(AppLocalizations.of(context)!.forgotPasswordDialogContent, style: const TextStyle(color: Colors.black)),
            const SizedBox(height: 16),
            TextFormField(
              controller: resetEmailController,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.emailLabel,
                labelStyle: const TextStyle(color: Colors.black),
                border: const OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[50],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(AppLocalizations.of(context)!.cancel, style: const TextStyle(color: Colors.black)),
          ),
          ElevatedButton(
            onPressed: () {
              if (resetEmailController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(AppLocalizations.of(context)!.pleaseEnterEmail)),
                );
                return;
              }
              _sendPasswordResetEmail(resetEmailController.text.trim(), context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            child: Text(AppLocalizations.of(context)!.sendResetLink, style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Future<void> _sendPasswordResetEmail(String email, BuildContext context) async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      await authProvider.sendPasswordResetEmail(email);
      
      if (context.mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.passwordResetSent(email)),
            duration: const Duration(seconds: 4),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${AppLocalizations.of(context)!.error}: ${e.toString()}')),
        );
      }
    }
  }

  Future<void> _sendVerificationCode(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;
    
    // Note: Phone authentication with verification code is a placeholder
    // In production, you would integrate with Firebase Phone Authentication
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Verification code would be sent to your phone')),
    );
    
    setState(() {
      _codeVerificationNeeded = true;
    });
  }

  Future<void> _verifyCode(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;
    
    // Placeholder for verification code verification
    // In production, you would verify the code with Firebase
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Phone verification feature coming soon')),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _codeController.dispose();
    super.dispose();
  }
}