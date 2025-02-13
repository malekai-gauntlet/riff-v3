import 'package:flutter/material.dart';

/// A placeholder screen for the Discover feature
class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon
            Icon(
              Icons.search,
              size: 64,
              color: Colors.white.withOpacity(0.5),
            ),
            const SizedBox(height: 24),
            // Message
            Text(
              'Coming Soon!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            // Subtitle
            Text(
              'Discover new guitar content',
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 