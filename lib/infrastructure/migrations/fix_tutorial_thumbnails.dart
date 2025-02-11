import 'package:cloud_firestore/cloud_firestore.dart';

/// Fixes tutorial thumbnails by generating them from YouTube IDs
Future<void> fixTutorialThumbnails() async {
  try {
    // Get Firestore instance
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    
    // Get all videos that have tutorials
    final QuerySnapshot videos = await firestore
        .collection('videos')
        .where('tutorials', isNotEqualTo: [])
        .get();
    
    print('\nStarting to fix tutorial thumbnails...');
    print('Found ${videos.docs.length} videos with tutorials');
    
    // Process each video
    for (final DocumentSnapshot doc in videos.docs) {
      final data = doc.data() as Map<String, dynamic>;
      final tutorials = List<Map<String, dynamic>>.from(data['tutorials'] ?? []);
      
      bool needsUpdate = false;
      
      // Update each tutorial's thumbnail
      for (var i = 0; i < tutorials.length; i++) {
        final tutorial = tutorials[i];
        final youtubeId = tutorial['youtubeId'] as String?;
        
        if (youtubeId != null) {
          final expectedThumbnail = 'https://img.youtube.com/vi/$youtubeId/0.jpg';
          if (tutorial['thumbnailUrl'] != expectedThumbnail) {
            tutorials[i]['thumbnailUrl'] = expectedThumbnail;
            needsUpdate = true;
          }
        }
      }
      
      // Update the document if needed
      if (needsUpdate) {
        await doc.reference.update({
          'tutorials': tutorials
        });
        print('Fixed thumbnails for video: ${data['title']}');
      }
    }
    
    print('\nSuccessfully fixed all tutorial thumbnails');
  } catch (e) {
    print('Error fixing tutorial thumbnails: $e');
    rethrow;
  }
} 