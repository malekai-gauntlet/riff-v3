// Import necessary packages for Firebase, thumbnails, and utilities
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'dart:typed_data';

// Model for tutorial tabs
class TabData {
  final String difficulty;
  final String rating;
  final String title;
  final String type;
  final String url;

  TabData({
    required this.difficulty,
    required this.rating,
    required this.title,
    required this.type,
    required this.url,
  });

  Map<String, dynamic> toMap() => {
    'difficulty': difficulty,
    'rating': rating,
    'title': title,
    'type': type,
    'url': url,
  };
}

// Model for tutorial data
class TutorialData {
  final String channelName;
  final String duration;
  final bool isBestMatch;
  final List<TabData> tabs;
  final String? thumbnailUrl;
  final String title;
  final String viewCount;
  final String youtubeId;

  TutorialData({
    required this.channelName,
    required this.duration,
    required this.isBestMatch,
    required this.tabs,
    this.thumbnailUrl,
    required this.title,
    required this.viewCount,
    required this.youtubeId,
  });

  Map<String, dynamic> toMap() => {
    'channelName': channelName,
    'duration': duration,
    'isBestMatch': isBestMatch,
    'tabs': tabs.map((tab) => tab.toMap()).toList(),
    'thumbnailUrl': thumbnailUrl,
    'title': title,
    'viewCount': viewCount,
    'youtubeId': youtubeId,
  };
}

// Model for video data
class VideoData {
  final DateTime createdAt;
  final String creatorId;
  final String description;
  final int likeCount;
  final int playCount;
  final List<String> savedByUsers;
  final List<String> tags;
  final String? thumbnailUrl;
  final String title;
  final List<TutorialData> tutorials;
  final String url;

  VideoData({
    required this.createdAt,
    required this.creatorId,
    required this.description,
    required this.likeCount,
    required this.playCount,
    required this.savedByUsers,
    required this.tags,
    this.thumbnailUrl,
    required this.title,
    required this.tutorials,
    required this.url,
  });

  Map<String, dynamic> toMap() => {
    'createdAt': Timestamp.fromDate(createdAt),
    'creatorId': creatorId,
    'description': description,
    'likeCount': likeCount,
    'playCount': playCount,
    'savedByUsers': savedByUsers,
    'tags': tags,
    'thumbnailUrl': thumbnailUrl,
    'title': title,
    'tutorials': tutorials.map((tutorial) => tutorial.toMap()).toList(),
    'url': url,
  };
}

// Function to generate and upload thumbnail
Future<String?> generateAndUploadThumbnail(String videoUrl, String videoId) async {
  try {
    if (kIsWeb) {
      // For web, we'll use a frame from the video URL as thumbnail
      // Extract video ID from the Firebase Storage URL
      final uri = Uri.parse(videoUrl);
      final pathSegments = uri.pathSegments;
      final videoFileName = pathSegments[pathSegments.length - 1];
      final thumbnailFileName = '${videoFileName.split('.')[0]}_thumb.jpg';
      
      // Create a reference to the new thumbnail in Firebase Storage
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('thumbnails')
          .child(thumbnailFileName);
      
      // For now, we'll just store the video URL as the thumbnail URL
      // In a production environment, you'd want to generate an actual thumbnail
      await storageRef.putString(videoUrl);
      return await storageRef.getDownloadURL();
    } else {
      // Mobile implementation
      final tempDir = await getTemporaryDirectory();
      final thumbnailPath = await VideoThumbnail.thumbnailFile(
        video: videoUrl,
        thumbnailPath: '${tempDir.path}/thumbnail_$videoId.jpg',
        imageFormat: ImageFormat.JPEG,
        maxHeight: 720,
        quality: 75,
      );

      if (thumbnailPath == null) return null;

      final storageRef = FirebaseStorage.instance
          .ref()
          .child('thumbnails')
          .child('$videoId.jpg');
      
      await storageRef.putFile(File(thumbnailPath));
      final thumbnailUrl = await storageRef.getDownloadURL();

      // Clean up temporary file
      await File(thumbnailPath).delete();

      return thumbnailUrl;
    }
  } catch (e) {
    print('Error generating/uploading thumbnail: $e');
    return null;
  }
}

// Main migration function
Future<void> addVideoData(VideoData videoData) async {
  try {
    // Generate a unique ID for the video
    final videoId = FirebaseFirestore.instance.collection('videos').doc().id;

    // Generate and upload thumbnail if not provided
    String? thumbnailUrl = videoData.thumbnailUrl;
    if (thumbnailUrl == null) {
      print('Generating thumbnail for video: ${videoData.title}');
      thumbnailUrl = await generateAndUploadThumbnail(videoData.url, videoId);
    }

    // Prepare video data with generated thumbnail
    final videoMap = videoData.toMap();
    if (thumbnailUrl != null) {
      videoMap['thumbnailUrl'] = thumbnailUrl;
    }

    // Upload to Firestore
    await FirebaseFirestore.instance
        .collection('videos')
        .doc(videoId)
        .set(videoMap);

    print('Successfully uploaded video: ${videoData.title}');
  } catch (e) {
    print('Error uploading video data: $e');
    rethrow;
  }
}

// Example usage
Future<void> runMigration() async {
  final videoData = VideoData(
    createdAt: DateTime.parse('2025-02-06 17:29:49-06:00'),
    creatorId: 'creator1',
    description: 'Matt Garret',
    likeCount: 0,
    playCount: 0,
    savedByUsers: [],
    tags: ['electric', 'cover', 'metal', 'ozzy', 'crazy train'],
    thumbnailUrl: null, // Set to null to trigger thumbnail generation
    title: 'Crazy Train | Fingerstyle Cover',
    tutorials: [
      TutorialData(
        channelName: 'Guitar Tutorials',
        duration: '12:34',
        isBestMatch: true,
        tabs: [
          TabData(
            difficulty: 'Intermediate',
            rating: '4.5/5',
            title: 'Crazy Train Tabs',
            type: 'tabs',
            url: 'https://tabs.ultimate-guitar.com/tab/ozzy-osbourne/crazy-train-tabs-38622',
          ),
        ],
        thumbnailUrl: null, // Set to null to trigger thumbnail generation
        title: 'Ozzy - Crazy Train - Guitar Lesson (Solo) with Tabs!',
        viewCount: '211k views',
        youtubeId: 'wULcuNKPsIY',
      ),
    ],
    url: 'https://firebasestorage.googleapis.com/v0/b/riff-8a2c9.firebasestorage.app/o/videos%2Fcrazy%20train%20solo.mp4?alt=media&token=e3a3e39e-13a3-4a84-bdfe-ff22f6b2ddee',
  );

  // First, generate and upload the video thumbnail
  final videoId = FirebaseFirestore.instance.collection('videos').doc().id;
  final videoThumbnailUrl = await generateAndUploadThumbnail(videoData.url, videoId);
  
  if (videoThumbnailUrl != null) {
    print('Successfully generated video thumbnail: $videoThumbnailUrl');
  }

  // Then, generate and upload the tutorial thumbnail
  final tutorialThumbnailUrl = await generateAndUploadThumbnail(
    videoData.url, // Using the same video for tutorial thumbnail
    '${videoId}_tutorial'
  );
  
  if (tutorialThumbnailUrl != null) {
    print('Successfully generated tutorial thumbnail: $tutorialThumbnailUrl');
    // Update the tutorial's thumbnail URL
    videoData.tutorials[0] = TutorialData(
      channelName: videoData.tutorials[0].channelName,
      duration: videoData.tutorials[0].duration,
      isBestMatch: videoData.tutorials[0].isBestMatch,
      tabs: videoData.tutorials[0].tabs,
      thumbnailUrl: tutorialThumbnailUrl,
      title: videoData.tutorials[0].title,
      viewCount: videoData.tutorials[0].viewCount,
      youtubeId: videoData.tutorials[0].youtubeId,
    );
  }

  // Create updated video data with the generated thumbnail
  final updatedVideoData = VideoData(
    createdAt: videoData.createdAt,
    creatorId: videoData.creatorId,
    description: videoData.description,
    likeCount: videoData.likeCount,
    playCount: videoData.playCount,
    savedByUsers: videoData.savedByUsers,
    tags: videoData.tags,
    thumbnailUrl: videoThumbnailUrl,
    title: videoData.title,
    tutorials: videoData.tutorials,
    url: videoData.url,
  );

  await addVideoData(updatedVideoData);
} 