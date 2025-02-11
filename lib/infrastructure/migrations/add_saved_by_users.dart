import 'package:cloud_firestore/cloud_firestore.dart';

/// Migration to add savedByUsers array to all existing videos
Future<void> addSavedByUsersMigration() async {
  try {
    // Get Firestore instance
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    
    // Get all videos that don't have savedByUsers field
    final QuerySnapshot videos = await firestore.collection('videos').get();
    
    // Create a batch for atomic updates
    final WriteBatch batch = firestore.batch();
    int updatedCount = 0;
    int skippedCount = 0;
    
    // Process each video
    for (final DocumentSnapshot doc in videos.docs) {
      final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      
      // Check if savedByUsers field exists
      if (!data.containsKey('savedByUsers')) {
        // Add savedByUsers field as empty array
        batch.update(doc.reference, {
          'savedByUsers': [],
        });
        updatedCount++;
      } else {
        skippedCount++;
      }
    }
    
    // Commit the batch
    if (updatedCount > 0) {
      await batch.commit();
    }
    
    print('Migration completed:');
    print('- Updated videos: $updatedCount');
    print('- Skipped videos (already had savedByUsers): $skippedCount');
    print('- Total videos processed: ${videos.docs.length}');
    
  } catch (e, stackTrace) {
    print('Error during migration: $e');
    print('Stack trace: $stackTrace');
    rethrow;
  }
} 