import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../l10n/app_localizations.dart';

/// Fresh photo picker widget that handles camera / gallery selection with
/// explicit permission requests and a modern bottom sheet UI.
class ProfilePhotoPicker extends StatefulWidget {
  final String? imageUrl;
  final ValueChanged<File?>? onChanged;
  final double size;

  const ProfilePhotoPicker({
    super.key,
    this.imageUrl,
    this.onChanged,
    this.size = 72,
  });

  @override
  State<ProfilePhotoPicker> createState() => _ProfilePhotoPickerState();
}

class _ProfilePhotoPickerState extends State<ProfilePhotoPicker> {
  final ImagePicker _picker = ImagePicker();
  File? _localImage;
  bool _isBusy = false;
  String? _savedImagePath;

  @override
  void initState() {
    super.initState();
    _loadSavedImage();
  }

  Future<void> _loadSavedImage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final path = prefs.getString('profile_image_path');
      if (path != null && File(path).existsSync()) {
        setState(() {
          _savedImagePath = path;
          _localImage = File(path);
        });
      }
    } catch (e) {
      // Ignore errors
    }
  }

  Future<void> _handlePick(ImageSource source) async {
    if (!await _hasPermission(source)) {
      _showPermissionDialog(isCamera: source == ImageSource.camera);
      return;
    }

    try {
      setState(() => _isBusy = true);
      final XFile? file = await _picker.pickImage(
        source: source,
        imageQuality: 85,
        maxWidth: 1200,
        preferredCameraDevice: CameraDevice.rear,
      );
      if (file == null) return;

      final local = File(file.path);
      if (await local.exists()) {
        // Save to SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('profile_image_path', local.path);
        
        setState(() {
          _localImage = local;
          _savedImagePath = local.path;
        });
        widget.onChanged?.call(local);
      }
    } catch (e) {
      final msg = AppLocalizations.of(context)?.failedToPickImage(e.toString()) ?? e.toString();
      _showSnack(msg);
    } finally {
      if (mounted) setState(() => _isBusy = false);
    }
  }

  Future<bool> _hasPermission(ImageSource source) async {
    Permission permission;
    if (source == ImageSource.camera) {
      permission = Permission.camera;
    } else if (Platform.isIOS) {
      permission = Permission.photos;
    } else {
      // Android: first try the READ_MEDIA_IMAGES permission via photos.
      permission = Permission.photos;
      var status = await permission.status;
      if (!status.isGranted && !status.isLimited) {
        permission = Permission.storage;
      }
    }

    final status = await permission.request();
    return status.isGranted || status.isLimited;
  }

  void _showPermissionDialog({required bool isCamera}) {
    final loc = AppLocalizations.of(context);
    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(loc?.permissionRequired ?? 'Permission required'),
        content: Text(
          isCamera
              ? (loc?.cameraPermissionRequired ?? 'Camera permission is required')
              : (loc?.photoLibraryPermissionRequired ?? 'Photo library permission is required'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(loc?.cancel ?? 'Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              openAppSettings();
            },
            child: Text(loc?.openSettings ?? 'Open settings'),
          ),
        ],
      ),
    );
  }

  void _openSheet() {
    final loc = AppLocalizations.of(context);
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined),
              title: Text(loc?.takePhoto ?? 'Take photo'),
              onTap: () {
                Navigator.pop(context);
                _handlePick(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: Text(loc?.chooseFromGallery ?? 'Choose from gallery'),
              onTap: () {
                Navigator.pop(context);
                _handlePick(ImageSource.gallery);
              },
            ),
            if (_localImage != null || _savedImagePath != null || (widget.imageUrl?.isNotEmpty ?? false))
              ListTile(
                leading: const Icon(Icons.delete_outline, color: Colors.red),
                title: Text(
                  loc?.removePhoto ?? 'Remove photo',
                  style: const TextStyle(color: Colors.red),
                ),
                onTap: () async {
                  Navigator.pop(context);
                  // Remove from SharedPreferences
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.remove('profile_image_path');
                  
                  setState(() {
                    _localImage = null;
                    _savedImagePath = null;
                  });
                  widget.onChanged?.call(null);
                },
              ),
          ],
        ),
      ),
    );
  }

  void _showSnack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final imageProvider = _localImage != null
        ? FileImage(_localImage!)
        : (_savedImagePath != null && File(_savedImagePath!).existsSync())
            ? FileImage(File(_savedImagePath!))
            : (widget.imageUrl != null && widget.imageUrl!.isNotEmpty)
                ? NetworkImage(widget.imageUrl!)
                : null;

    return GestureDetector(
      onTap: _isBusy ? null : _openSheet,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircleAvatar(
            radius: widget.size / 2,
            backgroundImage: imageProvider as ImageProvider<Object>?,
            backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: imageProvider == null
                ? Icon(
                    Icons.person,
                    size: widget.size * 0.5,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  )
                : null,
          ),
          if (_isBusy)
            Container(
              width: widget.size,
              height: widget.size,
              decoration: const BoxDecoration(
                color: Colors.black45,
                shape: BoxShape.circle,
              ),
              child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
            )
          else
            Positioned(
              right: 4,
              bottom: 4,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    width: 2,
                  ),
                ),
                child: Icon(
                  Icons.camera_alt,
                  size: widget.size * 0.25,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
        ],
      ),
    );
  }
}


