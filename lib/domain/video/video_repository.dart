import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'video_model.dart';

class VideoRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  
  // Collection reference
  CollectionReference get _videos => _firestore.collection('videos');
  
  // Get video feed with pagination
  Future<List<Video>> getVideoFeed({
    int limit = 15,
    DocumentSnapshot? startAfter,
  }) async {
    try {
      Query query = _videos.limit(limit);
          
      if (startAfter != null) {
        query = query.startAfterDocument(startAfter);
      }
      
      final snapshot = await query.get();
      final videos = snapshot.docs.map((doc) => Video.fromFirestore(doc)).toList();
      
      // Shuffle the videos randomly
      videos.shuffle();
      
      return videos;
    } catch (e) {
      print('Error fetching video feed: $e');
      rethrow;
    }
  }
  
  // Get a single video by ID
  Future<Video?> getVideo(String videoId) async {
    try {
      final doc = await _videos.doc(videoId).get();
      if (!doc.exists) return null;
      return Video.fromFirestore(doc);
    } catch (e) {
      print('Error fetching video: $e');
      rethrow;
    }
  }
  
  // Update video metadata (likes, views, etc.)
  Future<void> updateVideoMetadata(String videoId, Map<String, dynamic> data) async {
    try {
      await _videos.doc(videoId).update(data);
    } catch (e) {
      print('Error updating video metadata: $e');
      rethrow;
    }
  }
  
  // Get storage reference for video file
  Reference getVideoStorageRef(String videoId) {
    return _storage.ref().child('videos/$videoId');
  }
  
  // Get storage reference for thumbnail
  Reference getThumbnailStorageRef(String videoId) {
    return _storage.ref().child('thumbnails/$videoId.png');
  }
  
  // Get download URL for thumbnail
  Future<String> getThumbnailUrl(String videoId) async {
    try {
      final ref = getThumbnailStorageRef(videoId);
      return await ref.getDownloadURL();
    } catch (e) {
      print('Error getting thumbnail URL: $e');
      rethrow;
    }
  }
  
  // Toggle save/unsave video for a user
  Future<bool> toggleSaveVideo(String videoId, String userId) async {
    try {
      // Get the video document
      final videoRef = _videos.doc(videoId);
      
      // Use a transaction to ensure atomic update
      return await _firestore.runTransaction<bool>((transaction) async {
        final videoDoc = await transaction.get(videoRef);
        if (!videoDoc.exists) throw Exception('Video not found');
        
        final video = Video.fromFirestore(videoDoc);
        final savedByUsers = List<String>.from(video.savedByUsers);
        
        // Toggle saved state
        final bool isSaved = savedByUsers.contains(userId);
        if (isSaved) {
          savedByUsers.remove(userId);
        } else {
          savedByUsers.add(userId);
        }
        
        // Update the document
        transaction.update(videoRef, {'savedByUsers': savedByUsers});
        
        // Return new saved state
        return !isSaved;
      });
    } catch (e) {
      print('Error toggling video save: $e');
      rethrow;
    }
  }
  
  // Get saved videos for a user
  Future<List<Video>> getSavedVideos(String userId, {
    int limit = 10,
    DocumentSnapshot? startAfter,
  }) async {
    try {
      Query query = _videos
          .where('savedByUsers', arrayContains: userId)
          .orderBy('createdAt', descending: true)
          .limit(limit);
          
      if (startAfter != null) {
        query = query.startAfterDocument(startAfter);
      }
      
      final snapshot = await query.get();
      return snapshot.docs.map((doc) => Video.fromFirestore(doc)).toList();
    } catch (e) {
      print('Error fetching saved videos: $e');
      rethrow;
    }
  }
  
  // Toggle like status for a video
  Future<bool> toggleLikeVideo(String videoId, String userId) async {
    try {
      final videoRef = _firestore.collection('videos').doc(videoId);
      
      return await _firestore.runTransaction((transaction) async {
        final videoDoc = await transaction.get(videoRef);
        if (!videoDoc.exists) {
          throw Exception('Video not found');
        }

        // Safely get likedByUsers, defaulting to empty list if it doesn't exist
        final data = videoDoc.data() as Map<String, dynamic>;
        final likedByUsers = List<String>.from(data['likedByUsers'] ?? []);
        final currentLikeCount = data['likeCount'] ?? 0;
        
        final isLiked = likedByUsers.contains(userId);
        
        if (isLiked) {
          // Unlike the video
          likedByUsers.remove(userId);
          transaction.update(videoRef, {
            'likedByUsers': likedByUsers,
            'likeCount': currentLikeCount - 1,
          });
          return false;
        } else {
          // Like the video
          likedByUsers.add(userId);
          transaction.update(videoRef, {
            'likedByUsers': likedByUsers,
            'likeCount': currentLikeCount + 1,
          });
          return true;
        }
      });
    } catch (e) {
      print('Error toggling like: $e');
      rethrow;
    }
  }
} 