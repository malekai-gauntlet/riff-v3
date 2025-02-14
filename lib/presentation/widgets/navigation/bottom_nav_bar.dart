import 'package:flutter/material.dart';
import '../../screens/upload/upload_screen.dart';
import '../../../domain/video/video_model.dart';

class RiffBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;
  final Function(Video)? onVideoUploaded;  // Add callback for video upload

  const RiffBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
    this.onVideoUploaded,  // Make it optional
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.black,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white54,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedLabelStyle: const TextStyle(fontSize: 11),
      unselectedLabelStyle: const TextStyle(fontSize: 11),
      currentIndex: selectedIndex,
      onTap: (index) async {
        // If upload button is tapped (index 2)
        if (index == 2) {
          // Show upload screen and await the result
          final newVideo = await Navigator.of(context).push<Video>(
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (context) => const UploadScreen(),
            ),
          );

          // If a video was returned and we're still mounted
          if (newVideo != null && context.mounted) {
            // Switch to feed tab (index 0)
            onTap(0);
            
            // Notify parent about the new video
            onVideoUploaded?.call(newVideo);
          }
          return;
        }
        onTap(index);
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home_filled),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Discover',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_box_outlined),
          activeIcon: Icon(Icons.add_box),
          label: 'Upload',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          activeIcon: Icon(Icons.person),
          label: 'Me',
        ),
        // BottomNavigationBarItem(
        //   icon: Icon(Icons.library_music_outlined),
        //   activeIcon: Icon(Icons.library_music),
        //   label: 'Tabs',
        // ),
      ],
    );
  }
} 