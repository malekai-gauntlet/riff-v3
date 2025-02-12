import 'package:flutter/material.dart';
import '../../screens/upload/upload_screen.dart';

class RiffBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const RiffBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.black,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedLabelStyle: const TextStyle(fontSize: 11),
      unselectedLabelStyle: const TextStyle(fontSize: 11),
      currentIndex: selectedIndex,
      onTap: (index) {
        // If upload button is tapped (index 2)
        if (index == 2) {
          Navigator.of(context).push(
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (context) => const UploadScreen(),
            ),
          );
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