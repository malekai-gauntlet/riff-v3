// Main container for the profile video grid with tab selection
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../../domain/video/video_repository.dart';
import '../../../../../domain/video/video_model.dart';
import '../../../../screens/saved_videos/saved_video_view_screen.dart';
import 'video_thumbnail.dart';

class ProfileVideoGrid extends StatefulWidget {
  const ProfileVideoGrid({super.key});

  @override
  State<ProfileVideoGrid> createState() => _ProfileVideoGridState();
}

class _ProfileVideoGridState extends State<ProfileVideoGrid> {
  // Track which tab is selected (0 = Saved Recordings, 1 = Tutorials)
  int _selectedTabIndex = 0;
  
  // Repository instance
  final VideoRepository _videoRepository = VideoRepository();
  
  // Store videos
  List<Video> _savedVideos = [];
  bool _isLoading = false;
  String? _error;
  
  @override
  void initState() {
    super.initState();
    _loadSavedVideos();
  }
  
  // Load saved videos for current user
  Future<void> _loadSavedVideos() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    print('\n🔍 Loading Saved Videos:');
    print('👤 User ID: $userId');
    
    if (userId == null) {
      print('❌ No user ID available - user might not be logged in');
      return;
    }
    
    setState(() {
      _isLoading = true;
      _error = null;
    });
    
    try {
      print('📥 Fetching saved videos from repository...');
      final videos = await _videoRepository.getSavedVideos(userId);
      print('✅ Fetch complete:');
      print('📊 Number of videos: ${videos.length}');
      if (videos.isNotEmpty) {
        print('🖼️ First video details:');
        print('   - ID: ${videos[0].id}');
        print('   - Title: ${videos[0].title}');
        print('   - Thumbnail URL: ${videos[0].thumbnailUrl}');
      }
      
      setState(() {
        _savedVideos = videos;
        _isLoading = false;
      });
      print('💾 State updated with ${_savedVideos.length} videos');
      
    } catch (e, stackTrace) {
      print('❌ Error loading saved videos:');
      print('   Error: $e');
      print('   Stack trace: $stackTrace');
      setState(() {
        _error = 'Failed to load saved videos';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Tab selector
        Container(
          color: Colors.white,
          child: Row(
            children: [
              _buildTab(0, 'Saved Recordings'),
              _buildTab(1, 'Tutorials'),
            ],
          ),
        ),

        // Video grid
        Expanded(
          child: _selectedTabIndex == 0
              ? _buildSavedRecordingsGrid()
              : _buildTutorialsGrid(),
        ),
      ],
    );
  }
  
  Widget _buildSavedRecordingsGrid() {
    print('\n🎯 Building Saved Recordings Grid:');
    print('📊 Loading state: $_isLoading');
    print('❌ Error state: $_error');
    print('🎥 Number of videos: ${_savedVideos.length}');
    
    if (_isLoading) {
      print('⏳ Showing loading indicator');
      return const Center(child: CircularProgressIndicator());
    }
    
    if (_error != null) {
      print('❌ Showing error state: $_error');
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_error!, style: const TextStyle(color: Colors.black54)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadSavedVideos,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }
    
    if (_savedVideos.isEmpty) {
      print('📭 No saved videos to display');
      return const Center(
        child: Text(
          'No saved videos yet',
          style: TextStyle(color: Colors.black54),
        ),
      );
    }
    
    print('🎬 Building grid with ${_savedVideos.length} videos');
    return RefreshIndicator(
      onRefresh: _loadSavedVideos,
      child: GridView.builder(
        padding: const EdgeInsets.all(1),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1 / 1.5,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
        ),
        itemCount: _savedVideos.length,
        itemBuilder: (context, index) {
          final video = _savedVideos[index];
          return VideoThumbnail(
            thumbnailUrl: video.thumbnailUrl,
            likeCount: video.likeCount,
            onTap: () {
              print('\n🎯 Grid Item Tapped:');
              print('📺 Video ID: ${video.id}');
              print('📝 Video Title: ${video.title}');
              print('🔢 Index: $index');
              print('📱 Starting navigation to SavedVideoViewScreen...');
              
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    print('🏗️ Building SavedVideoViewScreen:');
                    print('🎥 Initial Video: ${video.id}');
                    print('📊 Total Videos: ${_savedVideos.length}');
                    return SavedVideoViewScreen(
                      initialVideo: video,
                      savedVideos: _savedVideos,
                      initialIndex: index,
                    );
                  },
                ),
              ).then((_) {
                print('↩️ Returned from SavedVideoViewScreen');
              });
            },
          );
        },
      ),
    );
  }
  
  Widget _buildTutorialsGrid() {
    // TODO: Implement tutorials grid
    return const Center(
      child: Text(
        'Tutorials coming soon!',
        style: TextStyle(color: Colors.black54),
      ),
    );
  }

  // Helper method to build individual tabs
  Widget _buildTab(int index, String title) {
    final isSelected = _selectedTabIndex == index;
    
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedTabIndex = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? Colors.black : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.black : Colors.black54,
              fontSize: 15,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
} 