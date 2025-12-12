import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/color_constants.dart';
import '../../../l10n/app_localizations.dart';
import '../providers/auth_provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.signupTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 32),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.nameLabel,
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)!.enterName;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.emailLabel,
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)!.enterEmail;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.passwordLabel,
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)!.enterPassword;
                  }
                  if (value.length < 6) {
                    return AppLocalizations.of(context)!.passwordTooShort;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.confirmPasswordLabel,
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)!.confirmPassword;
                  }
                  if (value != _passwordController.text) {
                    return AppLocalizations.of(context)!.passwordMismatch;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              Consumer<AuthProvider>(
                builder: (context, authProvider, child) {
                  if (authProvider.error != null) {
                    return Text(
                      authProvider.error!,
                      style: const TextStyle(color: ColorConstants.accentLight),
                      textAlign: TextAlign.center,
                    );
                  }
                  return const SizedBox();
                },
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : () => _signup(context),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Text(
                          AppLocalizations.of(context)!.signup.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Expanded(child: Divider()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'OR',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).hintColor,
                          ),
                    ),
                  ),
                  const Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: _isLoading ? null : _signUpWithGoogle,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  side: BorderSide(color: Theme.of(context).dividerColor),
                ),
                icon: Image.asset(
                  'assets/images/google_logo.png',
                  height: 24,
                  width: 24,
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.g_mobiledata, size: 28),
                ),
                label: Text(
                  'Sign up with Google',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: _isLoading ? null : _signUpWithApple,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  side: BorderSide(color: Theme.of(context).dividerColor),
                ),
                icon: const Icon(Icons.apple, size: 24),
                label: Text(
                  'Sign up with Apple',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account? ',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  TextButton(
                    onPressed: _isLoading ? null : () => Navigator.pop(context),
                    child: Text(AppLocalizations.of(context)!.login),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _signup(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final success = await authProvider.signup(
        _nameController.text,
        _emailController.text,
        _passwordController.text,
      );
      
      if (!mounted) return;
      
      if (success) {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, '/tasks');
      }
    }
  }

  bool get _isLoading => Provider.of<AuthProvider>(context, listen: true).isLoading;

  Future<void> _signUpWithGoogle() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final success = await authProvider.loginWithGoogle();
    if (success && context.mounted) {
      Navigator.pushReplacementNamed(context, '/main');
    }
  }

  Future<void> _signUpWithApple() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final success = await authProvider.loginWithApple();
    if (success && context.mounted) {
      Navigator.pushReplacementNamed(context, '/main');
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}