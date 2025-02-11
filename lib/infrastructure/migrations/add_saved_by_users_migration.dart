import 'package:cloud_firestore/cloud_firestore.dart';

/// Adds the savedByUsers array field to all existing videos in Firestore
Future<void> addSavedByUsersMigration() async {
  try {
    // Get Firestore instance
    final firestore = FirebaseFirestore.instance;
    
    print('Starting migration: Adding savedByUsers field to videos...');
    
    // Get all videos from the videos collection
    final videosSnapshot = await firestore.collection('videos').get();
    
    // Create a batch for atomic updates
    final batch = firestore.batch();
    
    // Counter for logging
    int updatedCount = 0;
    
    // Iterate through all videos
    for (final doc in videosSnapshot.docs) {
      final data = doc.data();
      
      // Only update if savedByUsers doesn't exist
      if (!data.containsKey('savedByUsers')) {
        batch.update(doc.reference, {
          'savedByUsers': [], // Initialize as empty array
        });
        updatedCount++;
      }
    }
    
    // Only commit if there are changes to make
    if (updatedCount > 0) {
      await batch.commit();
      print('Migration completed: Updated $updatedCount videos with savedByUsers field');
    } else {
      print('Migration skipped: All videos already have savedByUsers field');
    }
    
  } catch (e, stackTrace) {
    print('Error during migration: $e');
    print('Stack trace: $stackTrace');
    rethrow;
  }
} 