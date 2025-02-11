import 'package:cloud_firestore/cloud_firestore.dart';

/// Adds tutorial data to the Location video
Future<void> addTutorialData() async {
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
    
    // Tutorial data to add
    final tutorialData = {
      'tutorials': [
        {
          'youtubeId': '-nwUnIIKcPE',
          'title': 'Location - Khalid | Guitar Tutorial',
          'channelName': 'Guitar Tutorial',
          'viewCount': '2.5M views',
          'duration': '6:27',
          'thumbnailUrl': 'https://img.youtube.com/vi/-nwUnIIKcPE/0.jpg',
          'isBestMatch': true
        }
      ]
    };
    
    // Update the document
    await videoDoc.reference.update(tutorialData);
    
    print('Successfully added tutorial data to video: ${videoDoc.id}');
    
  } catch (e, stackTrace) {
    print('Error adding tutorial data: $e');
    print('Stack trace: $stackTrace');
    rethrow;
  }
} 