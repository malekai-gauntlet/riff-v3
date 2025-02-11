import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'components/profile_header.dart';
import 'components/profile_stats.dart';
import 'components/profile_actions.dart';
import 'components/video_grid/profile_video_grid.dart';

class ProfileViewScreen extends StatelessWidget {
  const ProfileViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              user?.displayName ?? 'Profile',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.black,
              size: 20,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () {
              // TODO: Implement menu functionality
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Profile info section
          const SingleChildScrollView(
            child: Column(
              children: [
                ProfileHeader(),
                ProfileStats(
                  following: 0,
                  savedVideos: 0,
                ),
                SizedBox(height: 12),
                ProfileActions(),
                SizedBox(height: 20),
              ],
            ),
          ),
          
          // Video grid section (takes remaining space)
          const Expanded(
            child: ProfileVideoGrid(),
          ),
        ],
      ),
    );
  }
} 