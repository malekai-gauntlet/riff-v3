import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../tutorial/tutorial_model.dart';

part 'video_model.freezed.dart';
part 'video_model.g.dart';

@freezed
class Video with _$Video {
  const factory Video({
    required String id,
    required String url,
    String? thumbnailUrl,
    required String title,
    required String description,
    required String creatorId,
    String? artist,
    @Default(0) int viewCount,
    @Default(0) int likeCount,
    @Default(0) int playCount,
    @Default([]) List<String> tags,
    @Default([]) List<String> savedByUsers,
    @Default([]) List<String> likedByUsers,
    @Default([]) List<Tutorial> tutorials,
    required DateTime createdAt,
  }) = _Video;

  factory Video.fromJson(Map<String, dynamic> json) => _$VideoFromJson(json);

  factory Video.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    
    // Safely handle tutorials data, defaulting to empty list if not present
    List<Tutorial> tutorialsData = [];
    if (data.containsKey('tutorials') && data['tutorials'] != null) {
      try {
        tutorialsData = (data['tutorials'] as List<dynamic>).map((tutorialData) {
          if (tutorialData is Map<String, dynamic>) {
            return Tutorial.fromFirestore(tutorialData);
          }
          return tutorialData as Tutorial;
        }).toList();
      } catch (e) {
        print('Error parsing tutorials: $e');
        // If there's an error, return empty list rather than crashing
        tutorialsData = [];
      }
    }

    final videoJson = {
      ...data,
      'id': doc.id,
      'createdAt': (data['createdAt'] as Timestamp).toDate().toIso8601String(),
      'savedByUsers': (data['savedByUsers'] as List<dynamic>?)?.cast<String>() ?? [],
      'likedByUsers': (data['likedByUsers'] as List<dynamic>?)?.cast<String>() ?? [],
      'playCount': data['playCount'] ?? 0,
      'thumbnailUrl': data['thumbnailUrl'],
      'tutorials': data['tutorials'] ?? [],  // Use raw tutorial data from Firebase
    };

    return Video.fromJson(videoJson);
  }
} 