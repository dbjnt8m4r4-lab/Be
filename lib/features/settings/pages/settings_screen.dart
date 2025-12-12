import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

import '../../settings/providers/settings_provider.dart';
import '../../../l10n/app_localizations.dart';
import '../../profile/widgets/profile_photo_picker.dart';
import '../../auth/providers/auth_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _ageController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    _ageController = TextEditingController();
  }


  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context);
    final loc = AppLocalizations.of(context)!;
    
    // Sync controllers
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_usernameController.text != settings.username) {
        _usernameController.text = settings.username;
      }
      if (_emailController.text != settings.email) {
        _emailController.text = settings.email;
      }
      final ageText = settings.age?.toString() ?? '';
      if (_ageController.text != ageText) {
        _ageController.text = ageText;
      }
    });

    return Scaffold(
      appBar: AppBar(title: Text(loc.settings ?? 'Settings')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // Profile Picture
            Center(
              child: ProfilePhotoPicker(
                imageUrl: null,
                size: 100,
                onChanged: (File? file) async {
                  final prefs = await SharedPreferences.getInstance();
                  if (file != null) {
                    await prefs.setString('profile_image_path', file.path);
                  } else {
                    await prefs.remove('profile_image_path');
                  }
                  // Notify AuthProvider listeners to refresh profile icon
                  Provider.of<AuthProvider>(context, listen: false).notifyListeners();
                  if (mounted) {
                    setState(() {});
                  }
                },
              ),
            ),
            const SizedBox(height: 24),

            _buildAccountCard(context, settings, loc),
            const SizedBox(height: 16),
            _buildPersonalizationCard(context, settings, loc),
            const SizedBox(height: 16),
            _buildPermissionsCard(context, loc),
            const SizedBox(height: 24),
            Center(
              child: Text(
                loc.ourGoal ?? 'Our Goal: Help you build better habits',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountCard(BuildContext context, SettingsProvider settings, AppLocalizations loc) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(loc.account ?? 'Account', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            Text(
              loc.loginSignupButton ?? 'Login or create an account',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pushNamed(context, '/auth-gateway'),
                icon: const Icon(Icons.login),
                label: Text(loc.loginSignupButton ?? 'Login / Sign Up'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPersonalizationCard(BuildContext context, SettingsProvider settings, AppLocalizations loc) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(loc.appearance ?? 'Appearance', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              children: [
                ChoiceChip(
                  label: const Row(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.light_mode), SizedBox(width: 6), Text('Light')]),
                  selected: settings.theme == 'light',
                  onSelected: (_) => settings.setTheme('light'),
                ),
                ChoiceChip(
                  label: const Row(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.dark_mode), SizedBox(width: 6), Text('Dark')]),
                  selected: settings.theme == 'dark',
                  onSelected: (_) => settings.setTheme('dark'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(loc.language ?? 'Language', style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              initialValue: settings.language,
              items: const [
                DropdownMenuItem(value: 'en', child: Text('English')),
                DropdownMenuItem(value: 'ar', child: Text('العربية')),
              ],
              onChanged: (v) => v != null ? settings.setLanguage(v) : null,
            ),
            const SizedBox(height: 20),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(loc.analytics ?? 'Analytics'),
              value: settings.analyticsEnabled,
              onChanged: settings.setAnalyticsEnabled,
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(loc.notifications ?? 'Notifications'),
              value: settings.notificationsEnabled,
              onChanged: settings.setNotificationsEnabled,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPermissionsCard(BuildContext context, AppLocalizations loc) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(loc.permissionsTitle ?? 'Permissions', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(
              loc.permissionsHint ?? 'Manage app permissions',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _showPermissionMessage(context, 'Location'),
                  icon: const Icon(Icons.location_on_outlined),
                  label: Text(loc.requestLocation ?? 'Request Location'),
                ),
                OutlinedButton.icon(
                  onPressed: () => _showPermissionMessage(context, 'Phone'),
                  icon: const Icon(Icons.phone_iphone),
                  label: Text(loc.requestPhone ?? 'Request Phone'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showPermissionMessage(BuildContext context, String permission) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$permission permission requested (feature ready for implementation)')),
    );
  }
}