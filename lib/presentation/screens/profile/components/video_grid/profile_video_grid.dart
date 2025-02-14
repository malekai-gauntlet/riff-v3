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
  // Track which tab is selected (0 = Your Riffs, 1 = Saved)
  int _selectedTabIndex = 0;
  
  // Repository instance
  final VideoRepository _videoRepository = VideoRepository();
  
  // Store videos
  List<Video> _savedVideos = [];
  List<Video> _creatorVideos = []; // Added for creator videos
  bool _isLoading = false;
  String? _error;
  
  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }
  
  // Load initial data based on selected tab
  Future<void> _loadInitialData() async {
    if (_selectedTabIndex == 0) {
      await _loadCreatorVideos();
    } else {
      await _loadSavedVideos();
    }
  }

  // Load videos created by current user
  Future<void> _loadCreatorVideos() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    print('\n🎥 Loading Creator Videos:');
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
      print('📥 Fetching creator videos from repository...');
      final videos = await _videoRepository.getCreatorVideos(userId);
      print('✅ Fetch complete:');
      print('📊 Number of videos: ${videos.length}');
      if (videos.isNotEmpty) {
        print('🖼️ First video details:');
        print('   - ID: ${videos[0].id}');
        print('   - Title: ${videos[0].title}');
        print('   - Thumbnail URL: ${videos[0].thumbnailUrl}');
      }
      
      setState(() {
        _creatorVideos = videos;
        _isLoading = false;
      });
      print('💾 State updated with ${_creatorVideos.length} videos');
      
    } catch (e, stackTrace) {
      print('❌ Error loading creator videos:');
      print('   Error: $e');
      print('   Stack trace: $stackTrace');
      setState(() {
        _error = 'Failed to load your videos';
        _isLoading = false;
      });
    }
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
              _buildTab(0, 'Your Riffs'),
              _buildTab(1, 'Saved'),
            ],
          ),
        ),

        // Video grid
        Expanded(
          child: _selectedTabIndex == 0
              ? _buildCreatorVideosGrid()
              : _buildSavedRecordingsGrid(),
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
  
  Widget _buildCreatorVideosGrid() {
    print('\n🎯 Building Creator Videos Grid:');
    print('📊 Loading state: $_isLoading');
    print('❌ Error state: $_error');
    print('🎥 Number of videos: ${_creatorVideos.length}');
    
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
              onPressed: _loadCreatorVideos,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }
    
    if (_creatorVideos.isEmpty) {
      print('📭 No creator videos to display');
      return const Center(
        child: Text(
          'No videos uploaded yet',
          style: TextStyle(color: Colors.black54),
        ),
      );
    }
    
    print('🎬 Building grid with ${_creatorVideos.length} videos');
    return RefreshIndicator(
      onRefresh: _loadCreatorVideos,
      child: GridView.builder(
        padding: const EdgeInsets.all(1),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1 / 1.5,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
        ),
        itemCount: _creatorVideos.length,
        itemBuilder: (context, index) {
          final video = _creatorVideos[index];
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
                    print('📊 Total Videos: ${_creatorVideos.length}');
                    return SavedVideoViewScreen(
                      initialVideo: video,
                      savedVideos: _creatorVideos,
                      initialIndex: index,
                    );
                  },
                ),
              ).then((_) {
                print('↩️ Returned from SavedVideoViewScreen');
                _loadCreatorVideos(); // Refresh after returning
              });
            },
          );
        },
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
            // Load appropriate data when tab changes
            if (_selectedTabIndex == 0) {
              _loadCreatorVideos();
            } else {
              _loadSavedVideos();
            }
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