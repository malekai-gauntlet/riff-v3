import 'package:flutter/material.dart';
import '../../../auth/infrastructure/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _authRepository = AuthRepository();
  String _bio = 'Add bio'; // Add bio state
  
  Future<void> _updateName(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final currentName = user.displayName ?? 'Add name';
    final TextEditingController nameController = TextEditingController(
      text: currentName == 'Add name' ? '' : currentName
    );
    
    // Show dialog to edit name
    final newName = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Name'),
        content: TextField(
          autofocus: true,
          controller: nameController,
          decoration: const InputDecoration(
            hintText: 'Enter your name',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, nameController.text),
            child: const Text('Save'),
          ),
        ],
      ),
    );

    // If name was entered and changed
    if (newName != null && newName.isNotEmpty && newName != currentName) {
      try {
        // Update Firebase Auth display name
        await user.updateDisplayName(newName);
        // Reload user to get updated data
        await user.reload();
        if (mounted) {
          setState(() {});
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Name updated successfully')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to update name')),
          );
        }
      }
    }
  }

  Future<void> _updateBio(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final TextEditingController bioController = TextEditingController(
      text: _bio == 'Add bio' ? '' : _bio
    );
    
    // Show dialog to edit bio
    final newBio = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Bio'),
        content: TextField(
          autofocus: true,
          controller: bioController,
          maxLines: 4, // Larger text field for bio
          decoration: const InputDecoration(
            hintText: 'Tell us about yourself',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, bioController.text),
            child: const Text('Save'),
          ),
        ],
      ),
    );

    // If bio was entered and changed
    if (newBio != null && newBio != _bio) {
      try {
        // Here we'll just update local state for now
        // TODO: Add Firebase bio storage implementation
        setState(() {
          _bio = newBio.isEmpty ? 'Add bio' : newBio;
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Bio updated successfully')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to update bio')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black, size: 28),
          onPressed: () => Navigator.of(context).pop(),
        ),
        titleSpacing: 0,
        title: const Text(
          'Edit profile',
          style: TextStyle(
            color: Colors.black,
            fontSize: 17,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.5,
          ),
        ),
      ),
      body: ListView(
        children: [
          // Profile Picture Section
          Column(
            children: [
              const SizedBox(height: 24),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black12, width: 0.5),
                ),
                child: const CircleAvatar(
                  radius: 48,
                  backgroundColor: Colors.black,
                  child: Icon(
                    Icons.person,
                    size: 48,
                    color: Colors.white54,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: () {
                  // TODO: Implement photo edit functionality
                },
                child: const Text(
                  'Edit photo or avatar',
                  style: TextStyle(
                    color: Color(0xFF07B9F2),
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 36),
            ],
          ),

          // About You Section
          const Padding(
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 8, top: 0),
            child: Text(
              'About you',
              style: TextStyle(
                color: Color(0xFF8A8B8F),
                fontSize: 13,
                fontWeight: FontWeight.w500,
                letterSpacing: -0.1,
              ),
            ),
          ),

          // Profile Fields
          _buildProfileField(
            title: 'Name',
            value: user?.displayName ?? 'Add name',
            showChevron: true,
            onTap: () => _updateName(context),
          ),
          _buildProfileField(
            title: 'Bio',
            value: _bio,
            showChevron: true,
            onTap: () => _updateBio(context),
          ),

          const SizedBox(height: 32),

          // Account Section
          const Padding(
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 8, top: 24),
            child: Text(
              'Account',
              style: TextStyle(
                color: Color(0xFF8A8B8F),
                fontSize: 13,
                fontWeight: FontWeight.w500,
                letterSpacing: -0.1,
              ),
            ),
          ),

          _buildProfileField(
            title: 'Log out',
            value: '',
            showChevron: false,
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProfileField({
    required String title,
    required String value,
    bool showChevron = false,
    VoidCallback? onTap,
  }) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFEEEEEE),
            width: 0.5,
          ),
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black,
            fontWeight: FontWeight.w400,
            letterSpacing: -0.2,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              value,
              style: const TextStyle(
                color: Color(0xFF86878B),
                fontSize: 15,
                fontWeight: FontWeight.w400,
                letterSpacing: -0.2,
              ),
            ),
            if (showChevron) ...[
              const SizedBox(width: 6),
              const Icon(
                Icons.chevron_right,
                color: Color(0xFF86878B),
                size: 22,
              ),
            ],
          ],
        ),
        onTap: onTap,
      ),
    );
  }
} 