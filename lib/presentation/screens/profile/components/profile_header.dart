import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../domain/profile/profile_service.dart';

class ProfileHeader extends StatefulWidget {
  const ProfileHeader({super.key});

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  final ProfileService _profileService = ProfileService();
  bool _isUploading = false;

  // Handle profile picture upload
  Future<void> _handleProfilePictureUpload() async {
    try {
      setState(() => _isUploading = true);

      // Pick image
      final imageFile = await _profileService.pickImage();
      if (imageFile == null) {
        setState(() => _isUploading = false);
        return;
      }

      // Upload image
      final downloadUrl = await _profileService.uploadProfilePicture(imageFile);
      if (downloadUrl == null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to upload profile picture')),
          );
        }
      }
    } finally {
      if (mounted) {
        setState(() => _isUploading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final username = user?.displayName ?? 'Username';
    final handle = '@${user?.email?.split('@')[0] ?? 'username'}';
    final photoUrl = user?.photoURL;

    return Column(
      children: [
        const SizedBox(height: 16),
        // Profile Picture
        GestureDetector(
          onTap: _isUploading ? null : _handleProfilePictureUpload,
          child: Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black12, width: 0.5),
            ),
            child: Stack(
              children: [
                // Profile Image or Default Icon
                ClipOval(
                  child: photoUrl != null
                      ? Image.network(
                          photoUrl,
                          width: 96,
                          height: 96,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return _buildDefaultAvatar();
                          },
                        )
                      : _buildDefaultAvatar(),
                ),
                // Upload indicator
                if (_isUploading)
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      ),
                    ),
                  ),
                // Edit button
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: const Color(0xFF00F2EA), // TikTok blue
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        
        // Username
        Text(
          username,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 4),
        
        // Handle
        Text(
          handle,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black87,
            letterSpacing: -0.2,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildDefaultAvatar() {
    return const CircleAvatar(
      radius: 48,
      backgroundColor: Colors.black,
      child: Icon(
        Icons.person,
        size: 48,
        color: Colors.white54,
      ),
    );
  }
} 