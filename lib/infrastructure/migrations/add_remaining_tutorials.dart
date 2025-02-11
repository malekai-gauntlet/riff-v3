import 'package:cloud_firestore/cloud_firestore.dart';

/// Adds tutorial data to the remaining videos (Canon Rock, Billie Jean, Mad World)
Future<void> addRemainingTutorials() async {
  try {
    // Get Firestore instance
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    
    // Tutorial data for Canon Rock
    await _addTutorialToVideo(
      firestore,
      videoTitle: 'Canon Rock',
      tutorialData: {
        'youtubeId': 'G9gSUb5_wt4',
        'title': 'Jerry C - Canon Rock Guitar Lesson with Tab Part.1',
        'channelName': 'Jw easy guitar',
        'viewCount': '53K views',
        'duration': '11:09',
        'thumbnailUrl': 'https://img.youtube.com/vi/G9gSUb5_wt4/0.jpg',
        'isBestMatch': true
      }
    );
    
    // Tutorial data for Billie Jean
    await _addTutorialToVideo(
      firestore,
      videoTitle: 'Billie Jean',
      tutorialData: {
        'youtubeId': 'dzQyQgAhnPs',
        'title': 'Billie Jean - Michael Jackson | Fingerstyle Guitar | TAB + Chords + Lyrics',
        'channelName': 'Kenneth Acoustic',
        'viewCount': '11K views',
        'duration': '4:09',
        'thumbnailUrl': 'https://img.youtube.com/vi/dzQyQgAhnPs/0.jpg',
        'isBestMatch': true
      }
    );
    
    // Tutorial data for Mad World
    await _addTutorialToVideo(
      firestore,
      videoTitle: 'Mad World',
      tutorialData: {
        'youtubeId': '9faM135hXqg',
        'title': 'Gary Jules - Mad World | Fingerstyle Guitar Lesson (Tutorial)',
        'channelName': 'Fingerstyle Club',
        'viewCount': '7K views',
        'duration': '28:23',
        'thumbnailUrl': 'https://img.youtube.com/vi/9faM135hXqg/0.jpg',
        'isBestMatch': true
      }
    );
    
    print('Successfully added tutorials to all videos');
    
  } catch (e, stackTrace) {
    print('Error adding tutorial data: $e');
    print('Stack trace: $stackTrace');
    rethrow;
  }
}

/// Helper function to add tutorial data to a specific video
Future<void> _addTutorialToVideo(
  FirebaseFirestore firestore, {
  required String videoTitle,
  required Map<String, dynamic> tutorialData,
}) async {
  // Reference to the video
  final videoRef = firestore.collection('videos').where('title', isEqualTo: videoTitle);
  
  // Get the video document
  final videoSnapshot = await videoRef.get();
  
  if (videoSnapshot.docs.isEmpty) {
    print('Video not found: $videoTitle');
    return;
  }

  // Get the first matching video
  final videoDoc = videoSnapshot.docs.first;
  
  // Update the document with the tutorial data
  await videoDoc.reference.update({
    'tutorials': [tutorialData]
  });
  
  print('Successfully added tutorial data to video: $videoTitle');
} 