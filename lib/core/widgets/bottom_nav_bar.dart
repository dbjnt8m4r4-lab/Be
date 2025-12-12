import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import '../../l10n/app_localizations.dart';
import '../../features/auth/providers/auth_provider.dart';

class _ProfileIcon extends StatefulWidget {
  final AuthProvider authProvider;
  
  const _ProfileIcon({required this.authProvider});
  
  @override
  State<_ProfileIcon> createState() => _ProfileIconState();
}

class _ProfileIconState extends State<_ProfileIcon> {
  String? _profileImagePath;
  
  @override
  void initState() {
    super.initState();
    _loadProfileImage();
    // Listen to auth provider changes
    widget.authProvider.addListener(_onAuthChanged);
  }
  
  @override
  void dispose() {
    widget.authProvider.removeListener(_onAuthChanged);
    super.dispose();
  }
  
  void _onAuthChanged() {
    _loadProfileImage();
  }
  
  Future<void> _loadProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    final path = prefs.getString('profile_image_path');
    if (mounted) {
      setState(() {
        _profileImagePath = path;
      });
    }
  }
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Reload profile image when widget rebuilds
    _loadProfileImage();
  }
  
  @override
  void didUpdateWidget(_ProfileIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Reload when widget is updated
    _loadProfileImage();
  }
  
  @override
  Widget build(BuildContext context) {
    // Check local file first
    if (_profileImagePath != null && File(_profileImagePath!).existsSync()) {
      return CircleAvatar(
        radius: 12,
        backgroundImage: FileImage(File(_profileImagePath!)),
      );
    }
    
    // Check Firebase photo URL
    final photoUrl = widget.authProvider.currentUser?.photoUrl;
    if (photoUrl != null && photoUrl.isNotEmpty) {
      return CircleAvatar(
        radius: 12,
        backgroundImage: NetworkImage(photoUrl),
      );
    }
    
    return const Icon(Icons.account_circle, size: 28);
  }
}

class BottomNavBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });
  
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int? _lastIndex;
  
  @override
  void initState() {
    super.initState();
    _lastIndex = widget.currentIndex;
  }
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Reload profile icon when dependencies change
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {});
      }
    });
  }
  
  @override
  void didUpdateWidget(BottomNavBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Reload when page index changes (user navigates between pages)
    if (oldWidget.currentIndex != widget.currentIndex) {
      _lastIndex = widget.currentIndex;
      if (mounted) {
        setState(() {});
      }
    }
    // Also reload periodically to catch profile picture changes
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    
    return Directionality(
      textDirection: TextDirection.ltr,
      child: BottomNavigationBar(
        currentIndex: widget.currentIndex,
        onTap: widget.onTap,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.gps_fixed, size: 28),
            label: loc.goals ?? 'Goals',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.check, size: 28),
            label: loc.taskManager,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.timeline, size: 28),
            label: loc.analytics,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.flag, size: 28),
            label: loc.habits,
          ),
          BottomNavigationBarItem(
            icon: Consumer<AuthProvider>(
              builder: (context, auth, child) {
                return _ProfileIcon(authProvider: auth);
              },
            ),
            label: loc.settings,
          ),
        ],
      ),
    );
  }
}