import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../../core/services/ffmpeg_service.dart';
import 'dart:html' as html;
import 'package:just_audio/just_audio.dart';

/// A test screen for experimenting with audio extraction from videos
class AudioExtractionTestScreen extends StatefulWidget {
  const AudioExtractionTestScreen({super.key});

  @override
  State<AudioExtractionTestScreen> createState() => _AudioExtractionTestScreenState();
}

class _AudioExtractionTestScreenState extends State<AudioExtractionTestScreen> {
  // Services
  final FFmpegService _ffmpegService = FFmpegService();
  final AudioPlayer _audioPlayer = AudioPlayer();
  
  // Controllers
  VideoPlayerController? _videoController;
  
  // State variables
  bool _isFFmpegInitialized = false;
  bool _isProcessing = false;
  bool _hasAudio = false;
  String _statusMessage = '';
  String _errorMessage = '';
  double _processingProgress = 0.0;
  
  // Performance metrics
  DateTime? _startTime;
  Duration? _processingDuration;

  @override
  void initState() {
    super.initState();
    _initializeFFmpeg();
    _initializeVideo();
  }

  @override
  void dispose() {
    _videoController?.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  /// Initialize FFmpeg
  Future<void> _initializeFFmpeg() async {
    try {
      setState(() => _statusMessage = 'Initializing FFmpeg...');
      
      // Add a small delay to ensure JS files are loaded
      await Future.delayed(const Duration(seconds: 2));
      
      final initialized = await _ffmpegService.initialize();
      setState(() {
        _isFFmpegInitialized = initialized;
        _statusMessage = initialized 
          ? 'FFmpeg initialized successfully' 
          : 'FFmpeg initialization failed';
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'FFmpeg initialization error: $e';
        _statusMessage = 'Failed to initialize FFmpeg';
      });
    }
  }

  /// Initialize video player with a test video
  Future<void> _initializeVideo() async {
    try {
      setState(() => _statusMessage = 'Loading video...');
      
      // Use the Canon video URL
      const videoUrl = 'https://firebasestorage.googleapis.com/v0/b/riff-8a2c9.firebasestorage.app/o/videos%2Fcanon%20new.mp4?alt=media&token=ab09dec5-4ccd-4088-a0ce-19a09f42e462';
      
      _videoController = VideoPlayerController.network(videoUrl);
      await _videoController!.initialize();
      setState(() => _statusMessage = 'Video loaded successfully');
    } catch (e) {
      setState(() {
        _errorMessage = 'Video initialization error: $e';
        _statusMessage = 'Failed to load video';
      });
    }
  }

  /// Extract audio from the current video
  Future<void> _extractAudio() async {
    if (!_isFFmpegInitialized || _videoController == null || _isProcessing) return;

    setState(() {
      _isProcessing = true;
      _processingProgress = 0.0;
      _startTime = DateTime.now();
      _statusMessage = 'Starting audio extraction...';
      _errorMessage = '';
    });

    try {
      // Get video URL from the controller
      final videoUrl = _videoController!.dataSource;
      setState(() {
        _processingProgress = 0.3;
        _statusMessage = 'Processing video data...';
      });

      // Extract audio using FFmpeg
      final audioData = await _ffmpegService.extractAudioFromVideo(videoUrl);

      if (audioData == null) {
        throw Exception('Audio extraction failed');
      }

      setState(() {
        _processingProgress = 0.7;
        _statusMessage = 'Creating audio player...';
      });

      // Create a URL for the audio data
      final blob = html.Blob([audioData]);
      final url = html.Url.createObjectUrlFromBlob(blob);

      // Set up audio player
      await _audioPlayer.setUrl(url);

      // Calculate processing time
      _processingDuration = DateTime.now().difference(_startTime!);

      setState(() {
        _isProcessing = false;
        _hasAudio = true;
        _processingProgress = 1.0;
        _statusMessage = 'Audio extraction complete';
      });
    } catch (e) {
      setState(() {
        _isProcessing = false;
        _errorMessage = 'Error extracting audio: $e';
        _statusMessage = 'Audio extraction failed';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Audio Extraction Test'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // FFmpeg Status Card
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _isFFmpegInitialized ? Colors.green.withOpacity(0.2) : Colors.orange.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    _isFFmpegInitialized ? Icons.check_circle : Icons.warning,
                    color: _isFFmpegInitialized ? Colors.green : Colors.orange,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _isFFmpegInitialized ? 'FFmpeg Ready' : 'FFmpeg Not Ready',
                      style: TextStyle(
                        color: _isFFmpegInitialized ? Colors.green : Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Video Section
            AspectRatio(
              aspectRatio: _videoController?.value.aspectRatio ?? 16/9,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Video Player
                  if (_videoController != null)
                    VideoPlayer(_videoController!),
                  
                  // Video Controls
                  if (_videoController != null)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_videoController!.value.isPlaying) {
                            _videoController!.pause();
                          } else {
                            _videoController!.play();
                          }
                        });
                      },
                      child: Container(
                        color: Colors.black.withOpacity(0.3),
                        child: Icon(
                          _videoController!.value.isPlaying 
                            ? Icons.pause 
                            : Icons.play_arrow,
                          size: 50,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // Debug Info Section
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Debug Information',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Video URL: ${_videoController?.dataSource ?? 'Not loaded'}',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'FFmpeg Status: ${_isFFmpegInitialized ? 'Initialized' : 'Not Initialized'}',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 12,
                    ),
                  ),
                  if (_processingDuration != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      'Last Processing Time: ${_processingDuration!.inMilliseconds}ms',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // Status and Error Messages
            if (_statusMessage.isNotEmpty)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _statusMessage,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
              
            if (_errorMessage.isNotEmpty)
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _errorMessage,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                  ),
                ),
              ),

            // Extract Button
            Container(
              margin: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: _isFFmpegInitialized && !_isProcessing 
                  ? _extractAudio 
                  : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  _isProcessing ? 'Processing...' : 'Extract Audio',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // Progress Indicator
            if (_isProcessing)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${(_processingProgress * 100).toInt()}%',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: _processingProgress,
                      backgroundColor: Colors.grey[800],
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                  ],
                ),
              ),

            // Audio Player Controls
            if (_hasAudio)
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.music_note,
                          color: Colors.green,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Extracted Audio',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(
                            _audioPlayer.playing 
                              ? Icons.pause_circle_filled
                              : Icons.play_circle_filled,
                            color: Colors.white,
                            size: 48,
                          ),
                          onPressed: () {
                            if (_audioPlayer.playing) {
                              _audioPlayer.pause();
                            } else {
                              _audioPlayer.play();
                            }
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
} 