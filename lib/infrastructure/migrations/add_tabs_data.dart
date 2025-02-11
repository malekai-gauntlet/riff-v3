import 'package:cloud_firestore/cloud_firestore.dart';

/// Adds Ultimate Guitar tabs data to the Location video's tutorial
Future<void> addTabsData() async {
  try {
    // Get Firestore instance
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    
    // Reference to the Location video
    final videoRef = firestore.collection('videos').where('title', isEqualTo: 'Location');
    
    // Get the video document
    final videoSnapshot = await videoRef.get();
    
    if (videoSnapshot.docs.isEmpty) {
      print('Video not found');
      return;
    }

    // Get the first matching video
    final videoDoc = videoSnapshot.docs.first;
    
    // Get current tutorials data
    final data = videoDoc.data();
    final tutorials = data['tutorials'] as List<dynamic>? ?? [];
    
    // Update the first tutorial with tabs data
    if (tutorials.isNotEmpty) {
      tutorials[0]['tabs'] = [
        {
          'url': 'https://tabs.ultimate-guitar.com/tab/khalid/location-tabs-2162319',
          'rating': '4.9/5',
          'difficulty': 'advanced',
          'type': 'tabs',
          'title': 'Location Guitar Tabs'
        }
      ];
      
      // Update the document with the modified tutorials array
      await videoDoc.reference.update({
        'tutorials': tutorials
      });
      
      print('Successfully added tabs data to tutorial for video: ${videoDoc.id}');
    } else {
      print('No tutorials found for the video');
    }
    
  } catch (e, stackTrace) {
    print('Error adding tabs data: $e');
    print('Stack trace: $stackTrace');
    rethrow;
  }
} 