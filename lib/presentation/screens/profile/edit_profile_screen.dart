import 'package:flutter/material.dart';
import '../../../auth/infrastructure/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authRepository = AuthRepository();
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
          ),
          _buildProfileField(
            title: 'Username',
            value: user?.email?.split('@')[0] ?? 'Add username',
            showChevron: true,
          ),
          _buildProfileField(
            title: 'Bio',
            value: 'Add bio',
            showChevron: true,
          ),
          _buildProfileField(
            title: 'Pronouns',
            value: 'Add pronouns',
            showChevron: true,
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