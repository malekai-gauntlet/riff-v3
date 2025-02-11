// This class handles the logic for showing electric guitar videos in sequence
// when a user shows interest in an electric guitar video

import 'package:cloud_firestore/cloud_firestore.dart';

class ElectricVideoSequence {
  // Singleton instance
  static final ElectricVideoSequence _instance = ElectricVideoSequence._internal();
  factory ElectricVideoSequence() => _instance;
  ElectricVideoSequence._internal() {
  }

  // Track if we should show electric videos next
  bool _shouldShowElectric = false;
  
  // Track if we should suppress electric videos (accessible from outside)
  bool _suppressElectric = false;
  bool get suppressElectric => _suppressElectric;
  
  // Callback for when suppress state changes
  Function? onSuppressStateChanged;
  
  // Setter for suppressElectric that triggers callback
  set suppressElectric(bool value) {
    if (_suppressElectric != value) {
      _suppressElectric = value;
      onSuppressStateChanged?.call();
    }
  }

  // Current video being watched
  String? _currentVideoId;
  
  // Last shown electric video
  String? _lastShownElectricId;
  
  // Track all played videos
  final Set<String> _playedVideos = {};
  
  // Timer for tracking watch time
  DateTime? _watchStartTime;

  // Start tracking watch time for a video
  void startWatching(String videoId) {
    _currentVideoId = videoId;
    _watchStartTime = DateTime.now();
    _playedVideos.add(videoId);  // Add to played videos
  }

  // Stop tracking watch time and process the result
  Future<void> stopWatching() async {
    if (_currentVideoId == null || _watchStartTime == null) {
      return;
    }

    final watchDuration = DateTime.now().difference(_watchStartTime!);
    
    // Check if current video has electric tag
    final videoDoc = await FirebaseFirestore.instance
        .collection('videos')
        .doc(_currentVideoId)
        .get();
    
    final tags = List<String>.from(videoDoc.data()?['tags'] ?? []);
    
    if (tags.contains('electric')) {
      // If electric video watched for less than 3 seconds
      if (watchDuration.inSeconds < 3) {
        suppressElectric = true;
        _shouldShowElectric = false;
      }
      // If watched for more than 6 seconds
      else if (watchDuration.inSeconds > 6) {
        // Check if there are any unplayed electric videos
        final unplayedQuery = await FirebaseFirestore.instance
            .collection('videos')
            .where('tags', arrayContains: 'electric')
            .where(FieldPath.documentId, whereNotIn: [..._playedVideos].toList())
            .get();
            
        if (unplayedQuery.docs.isNotEmpty) {
          _shouldShowElectric = true;
        }
      }
    }

    // Reset tracking
    _currentVideoId = null;
    _watchStartTime = null;
  }

  // Check if next video should be electric
  bool shouldShowElectricNext() {
    return _shouldShowElectric;
  }

  // Get next electric video
  Future<DocumentSnapshot?> getNextElectricVideo() async {
    if (!_shouldShowElectric || suppressElectric) {
      return null;
    }
    
    // Get all unplayed electric videos
    final querySnapshot = await FirebaseFirestore.instance
        .collection('videos')
        .where('tags', arrayContains: 'electric')
        .where(FieldPath.documentId, whereNotIn: [..._playedVideos].toList())
        .get();

    if (querySnapshot.docs.isEmpty) {
      _shouldShowElectric = false;
      return null;
    }

    // Reset flag after finding next video
    _shouldShowElectric = false;
    
    // Return a random unplayed electric video
    final random = DateTime.now().millisecondsSinceEpoch % querySnapshot.docs.length;
    final selectedVideo = querySnapshot.docs[random];
    return selectedVideo;
  }
} 