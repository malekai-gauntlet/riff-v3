import 'package:cloud_firestore/cloud_firestore.dart';
import 'comment_model.dart';

class CommentRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get comments subcollection reference for a video
  CollectionReference _commentsRef(String videoId) {
    return _firestore.collection('videos').doc(videoId).collection('comments');
  }

  // Get comment count for a video
  Future<int> getCommentCount(String videoId) async {
    try {
      final snapshot = await _commentsRef(videoId).count().get();
      return snapshot.count ?? 0;  // Handle nullable count
    } catch (e) {
      print('Error getting comment count: $e');
      return 0; // Return 0 if there's an error
    }
  }

  // Get comments for a video with pagination
  Future<List<Comment>> getComments(String videoId, {
    int limit = 15,
    DocumentSnapshot? startAfter,
  }) async {
    try {
      Query query = _commentsRef(videoId)
          .orderBy('createdAt', descending: true)
          .limit(limit);
          
      if (startAfter != null) {
        query = query.startAfterDocument(startAfter);
      }
      
      final snapshot = await query.get();
      return snapshot.docs.map((doc) => Comment.fromFirestore(doc)).toList();
    } catch (e) {
      print('Error fetching comments: $e');
      rethrow;
    }
  }

  // Add a new comment
  Future<Comment> addComment(String videoId, String userId, String username, String text) async {
    try {
      print('Adding comment to video: $videoId');
      final commentData = {
        'videoId': videoId,
        'userId': userId,
        'username': username,
        'text': text,
        'createdAt': FieldValue.serverTimestamp(),
        'likeCount': 0,
        'likedByUsers': [],
      };
      
      print('Comment data: $commentData');
      final docRef = await _commentsRef(videoId).add(commentData);
      print('Comment added with ID: ${docRef.id}');
      
      final doc = await docRef.get();
      print('Retrieved comment data: ${doc.data()}');
      
      return Comment.fromFirestore(doc);
    } catch (e) {
      print('Error adding comment: $e');
      rethrow;
    }
  }

  // Toggle like on a comment
  Future<bool> toggleLikeComment(String videoId, String commentId, String userId) async {
    try {
      final commentRef = _commentsRef(videoId).doc(commentId);
      
      return await _firestore.runTransaction((transaction) async {
        final doc = await transaction.get(commentRef);
        if (!doc.exists) throw Exception('Comment not found');
        
        final comment = Comment.fromFirestore(doc);
        final likedByUsers = List<String>.from(comment.likedByUsers);
        final isLiked = likedByUsers.contains(userId);
        
        if (isLiked) {
          likedByUsers.remove(userId);
          transaction.update(commentRef, {
            'likedByUsers': likedByUsers,
            'likeCount': FieldValue.increment(-1),
          });
          return false;
        } else {
          likedByUsers.add(userId);
          transaction.update(commentRef, {
            'likedByUsers': likedByUsers,
            'likeCount': FieldValue.increment(1),
          });
          return true;
        }
      });
    } catch (e) {
      print('Error toggling comment like: $e');
      rethrow;
    }
  }

  // Delete a comment
  Future<void> deleteComment(String videoId, String commentId) async {
    try {
      await _commentsRef(videoId).doc(commentId).delete();
    } catch (e) {
      print('Error deleting comment: $e');
      rethrow;
    }
  }
} 