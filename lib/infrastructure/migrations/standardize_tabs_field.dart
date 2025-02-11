import 'package:cloud_firestore/cloud_firestore.dart';

/// Standardizes the tabs field name across all videos (changes guitarNotes to tabs)
Future<void> standardizeTabsField() async {
  try {
    // Get Firestore instance
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    
    // Get all videos
    final videosRef = firestore.collection('videos');
    final videoSnapshot = await videosRef.get();
    
    for (final videoDoc in videoSnapshot.docs) {
      final data = videoDoc.data();
      final tutorials = List<Map<String, dynamic>>.from(data['tutorials'] ?? []);
      
      bool needsUpdate = false;
      
      // Update each tutorial
      for (var tutorial in tutorials) {
        // Check if tutorial has guitarNotes field
        if (tutorial.containsKey('guitarNotes')) {
          // Move guitarNotes data to tabs field
          tutorial['tabs'] = tutorial['guitarNotes'];
          tutorial.remove('guitarNotes');
          needsUpdate = true;
        }
      }
      
      // Only update if changes were made
      if (needsUpdate) {
        await videoDoc.reference.update({
          'tutorials': tutorials
        });
        print('Standardized tabs field for video: ${videoDoc.id}');
      }
    }
    
    print('Successfully standardized tabs field across all videos');
    
  } catch (e, stackTrace) {
    print('Error standardizing tabs field: $e');
    print('Stack trace: $stackTrace');
    rethrow;
  }
} 