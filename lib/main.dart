import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'presentation/screens/auth/login_screen.dart';
import 'presentation/screens/profile/profile_view_screen.dart';
import 'presentation/screens/feed/feed_screen.dart';
import 'presentation/screens/tab/tab_view_screen.dart';
import 'presentation/screens/discover/discover_screen.dart';
import 'presentation/screens/tab/static_tab_view_screen.dart';
import 'presentation/widgets/navigation/bottom_nav_bar.dart';
import 'presentation/widgets/navigation/feed_toggle.dart';
import 'presentation/widgets/video/video_action_buttons.dart';
import 'auth/infrastructure/auth_repository.dart';
import 'domain/video/video_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyDgao37t6Nnzv3mCIrJR_A6TkPcOofz8Rw',
        appId: '1:96689107158:ios:a7ba68094857c78a239977',
        messagingSenderId: '96689107158',
        projectId: 'riff-8a2c9',
        storageBucket: 'riff-8a2c9.firebasestorage.app',
        authDomain: 'riff-8a2c9.firebaseapp.com', // Add this for web
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Riff',
      theme: ThemeData(
        // Custom theme colors that feel more musical/guitar-focused
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6B4CE6), // Deep purple as primary
          secondary: const Color(0xFFFF8A65), // Warm orange as accent
        ),
        useMaterial3: true,
        // Add custom page transitions
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {
            for (final platform in TargetPlatform.values)
              platform: const CustomPageTransitionsBuilder(),
          },
        ),
      ),
      home: const AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthRepository().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        
        if (snapshot.hasData) {
          return const HomePage();
        }
        
        return const LoginScreen();
      },
    );
  }
}

// Creating a dedicated HomePage widget instead of MyHomePage
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  int _selectedFeedIndex = 1; // Default to "For You"

  // Updated method to get the current screen based on selected index
  Widget _getCurrentScreen() {
    switch (_selectedIndex) {
      case 0: // Home
        return Stack(
          children: [
            FeedScreen(selectedGenre: _selectedFeedIndex),
            Positioned(
              top: MediaQuery.of(context).padding.top + 10,
              left: 0,
              right: 0,
              child: FeedToggle(
                selectedIndex: _selectedFeedIndex,
                onToggle: (index) => setState(() => _selectedFeedIndex = index),
              ),
            ),
          ],
        );
      case 1: // Discover
        // return const DiscoverScreen();  // Comment out the DiscoverScreen
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 20,
                left: 20,
                right: 20,
                bottom: 20,
              ),
              child: const Text(
                'My Tabs',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildTabCard(
                    title: 'Canon Rock',
                    artist: 'Jerry C',
                    difficulty: 'Intermediate',
                    lastModified: '2 days ago',
                  ),
                  _buildTabCard(
                    title: 'Smoke on the Water',
                    artist: 'Deep Purple',
                    difficulty: 'Beginner',
                    lastModified: '1 week ago',
                  ),
                  _buildTabCard(
                    title: 'Iron Man',
                    artist: 'Black Sabbath',
                    difficulty: 'Intermediate',
                    lastModified: '3 days ago',
                  ),
                  _buildTabCard(
                    title: 'Sweet Child O\' Mine',
                    artist: 'Guns N\' Roses',
                    difficulty: 'Advanced',
                    lastModified: '5 days ago',
                  ),
                  _buildTabCard(
                    title: 'Nothing Else Matters',
                    artist: 'Metallica',
                    difficulty: 'Intermediate',
                    lastModified: 'Just now',
                  ),
                ],
              ),
            ),
          ],
        );
      case 3: // Profile
        return const ProfileViewScreen();
      default:
        return const SizedBox.shrink();
    }
  }

  // Helper method to build a tab card
  Widget _buildTabCard({
    required String title,
    required String artist,
    required String difficulty,
    required String lastModified,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // If it's Canon Rock, show the static tab view
            if (title == 'Canon Rock') {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => StaticTabViewScreen(
                    title: title,
                    artist: artist,
                  ),
                ),
              );
              return;
            }

            // For other tabs, use the existing TabViewScreen
            final video = Video(
              id: title.toLowerCase().replaceAll(' ', '-'),
              title: title,
              artist: artist,
              description: 'Guitar tab for $title by $artist',
              url: '', // No video URL needed for static tabs
              thumbnailUrl: null,
              creatorId: 'system', // System generated tabs
              createdAt: DateTime.now(),
              likeCount: 0,
              tags: ['tab'],
              likedByUsers: [],
              savedByUsers: [],
              tutorials: [],
            );

            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => TabViewScreen(
                  video: video,
                  isStaticTab: true,
                ),
              ),
            );
          },
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Guitar Icon with background
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.music_note,
                    color: Colors.white.withOpacity(0.9),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                // Tab Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        artist,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              difficulty,
                              style: const TextStyle(
                                color: Colors.blue,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            lastModified,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Arrow Icon
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white.withOpacity(0.5),
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // Remove the AppBar since we're positioning FeedToggle in the Stack
      body: _getCurrentScreen(),
      bottomNavigationBar: RiffBottomNavBar(
        selectedIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }
}

// Add custom page transitions builder
class CustomPageTransitionsBuilder extends PageTransitionsBuilder {
  const CustomPageTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    const begin = Offset(1.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.easeInOutCubic;
    const duration = Duration(milliseconds: 500);

    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    var offsetAnimation = animation.drive(tween);

    return SlideTransition(
      position: offsetAnimation,
      child: child,
    );
  }
}