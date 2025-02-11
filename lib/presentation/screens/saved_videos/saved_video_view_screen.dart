import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../../domain/video/video_model.dart';

class SavedVideoViewScreen extends StatefulWidget {
  final Video initialVideo;
  final List<Video> savedVideos;
  final int initialIndex;

  const SavedVideoViewScreen({
    super.key,
    required this.initialVideo,
    required this.savedVideos,
    required this.initialIndex,
  });

  @override
  State<SavedVideoViewScreen> createState() => _SavedVideoViewScreenState();
}

class _SavedVideoViewScreenState extends State<SavedVideoViewScreen> {
  // Controller for page view
  late final PageController _pageController;
  // Track current page
  late int _currentPage;
  // Map of video controllers
  final Map<String, VideoPlayerController> _controllers = {};

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialIndex;
    _pageController = PageController(initialPage: _currentPage);
    _initializeController(widget.initialVideo);
  }

  Future<void> _initializeController(Video video) async {
    if (_controllers[video.id] != null) return;

    final controller = VideoPlayerController.network(video.url);
    _controllers[video.id] = controller;

    try {
      await controller.initialize();
      await controller.setLooping(true);
      if (mounted && video.id == widget.savedVideos[_currentPage].id) {
        await controller.play();
      }
      setState(() {});
    } catch (e) {
      print('Error initializing video controller: $e');
    }
  }

  @override
  void dispose() {
    // Properly cleanup each controller
    for (final controller in _controllers.values) {
      controller.pause();  // Ensure video is paused
      controller.dispose();
    }
    _controllers.clear();  // Clear the map
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Video PageView
          PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            itemCount: widget.savedVideos.length,
            onPageChanged: (index) async {
              setState(() => _currentPage = index);
              // Initialize next video
              if (index < widget.savedVideos.length - 1) {
                _initializeController(widget.savedVideos[index + 1]);
              }
              // Pause previous video
              if (index > 0) {
                _controllers[widget.savedVideos[index - 1].id]?.pause();
              }
              // Play current video
              await _controllers[widget.savedVideos[index].id]?.play();
            },
            itemBuilder: (context, index) {
              final video = widget.savedVideos[index];
              final controller = _controllers[video.id];
              
              if (controller == null || !controller.value.isInitialized) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                );
              }

              return GestureDetector(
                onTap: () {
                  if (controller.value.isPlaying) {
                    controller.pause();
                  } else {
                    controller.play();
                  }
                },
                child: VideoPlayer(controller),
              );
            },
          ),

          // Back button
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 16,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 28,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }
} 