import 'package:cloud_firestore/cloud_firestore.dart';

/// Map of video titles to their YouTube IDs
final videoThumbnails = {
  'Girls Like You - Maroon 5 | Fingerstyle Cover': 'Av3Nv2gzmlI',
  'River Flows in You - Yiruma | Fingerstyle Cover': 'QMW61Jva00s',
  'Riffin': 'k2yIX0Wm3Zo',
  'I Feel It Coming - The Weekend | Fingerstyle Cover': 'ANx0HQa9cpw',
  'Neon Fingerstyle Cover - John Mayer': 'D_EIshPveUw',
  'Crazy Train Cover': '_qZSsZU3sUQ',
  'Civil War Solo - Acoustic': 'nySDgzgaSFA',
  'I See Fire | Ed Sheeran | Fingerstyle': '3QFFBTgnVD8',
  'See You Again | Fingerstyle Version': 'AJrCLftqQ0M',
};

/// Updates missing thumbnails for videos
Future<void> updateMissingThumbnails() async {
  try {
    final firestore = FirebaseFirestore.instance;
    final videosRef = firestore.collection('videos');
    
    print('\nStarting to update video thumbnails...');
    
    // Query all videos (removed thumbnailUrl condition)
    final snapshot = await videosRef
        .get();
    
    print('Found ${snapshot.docs.length} videos to update thumbnails');
    
    int updatedCount = 0;
    
    // Update each video
    for (final doc in snapshot.docs) {
      final data = doc.data();
      final title = data['title'] as String;
      
      // Find matching YouTube ID
      final youtubeId = videoThumbnails[title];
      if (youtubeId == null) {
        print('No YouTube ID found for video: $title');
        continue;
      }
      
      // Generate thumbnail URL
      final thumbnailUrl = 'https://img.youtube.com/vi/$youtubeId/0.jpg';
      
      // Update document
      await doc.reference.update({
        'thumbnailUrl': thumbnailUrl,
      });
      
      print('Updated thumbnail for: $title');
      updatedCount++;
    }
    
    print('\nSuccessfully updated $updatedCount video thumbnails');
  } catch (e) {
    print('Error updating thumbnails: $e');
    rethrow;
  }
} 