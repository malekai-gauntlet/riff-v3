import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'comment_model.freezed.dart';
part 'comment_model.g.dart';

@freezed
class Comment with _$Comment {
  const factory Comment({
    required String id,
    required String videoId,
    required String userId,
    required String username,
    String? userProfilePic,
    required String text,
    required DateTime createdAt,
    @Default(0) int likeCount,
    @Default([]) List<String> likedByUsers,
  }) = _Comment;

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);

  factory Comment.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Comment.fromJson({
      ...data,
      'id': doc.id,
      'createdAt': (data['createdAt'] as Timestamp).toDate().toIso8601String(),
      'likedByUsers': (data['likedByUsers'] as List<dynamic>?)?.cast<String>() ?? [],
    });
  }
} 