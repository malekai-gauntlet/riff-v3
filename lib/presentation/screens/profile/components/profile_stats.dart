import 'package:flutter/material.dart';

class ProfileStats extends StatelessWidget {
  final int following;
  final int savedVideos;

  const ProfileStats({
    super.key,
    this.following = 0,
    this.savedVideos = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildStatColumn('Following', following),
        const SizedBox(width: 35),  // Increased spacing since we only have two items
        _buildStatColumn('Saved videos', savedVideos),
      ],
    );
  }

  Widget _buildStatColumn(String label, int count) {
    String displayCount = count.toString();
    // Format large numbers (e.g., 1.2K, 1.2M)
    if (count >= 1000000) {
      displayCount = '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      displayCount = '${(count / 1000).toStringAsFixed(1)}K';
    }

    return Column(
      children: [
        Text(
          displayCount,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: Colors.black,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 1),
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.black87,
            letterSpacing: -0.2,
          ),
        ),
      ],
    );
  }
} 