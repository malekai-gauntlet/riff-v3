import 'package:cloud_firestore/cloud_firestore.dart';

/// Fixes both tutorial and tabs data for Billie Jean
Future<void> fixBillieJeanComplete() async {
  try {
    // Get Firestore instance
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    
    // Reference to the Billie Jean video with correct title
    final videoRef = firestore.collection('videos').where('title', isEqualTo: 'Billie Jean Guitar Tutorial');
    
    // Get the video document
    final videoSnapshot = await videoRef.get();
    
    if (videoSnapshot.docs.isEmpty) {
      print('Billie Jean Guitar Tutorial video not found');
      return;
    }

    // Get the first matching video
    final videoDoc = videoSnapshot.docs.first;
    
    // Complete tutorial data with tabs
    final tutorialData = {
      'tutorials': [{
        'youtubeId': 'dzQyQgAhnPs',
        'title': 'Billie Jean - Michael Jackson | Fingerstyle Guitar | TAB + Chords + Lyrics',
        'channelName': 'Kenneth Acoustic',
        'viewCount': '11K views',
        'duration': '4:09',
        'thumbnailUrl': 'https://img.youtube.com/vi/dzQyQgAhnPs/0.jpg',
        'isBestMatch': true,
        'tabs': [{
          'url': 'https://www.songsterr.com/a/wsa/jackson-michael-billie-jean-fingerstyle-tab-s665992',
          'rating': '4.5/5',
          'difficulty': 'advanced',
          'type': 'tabs',
          'title': 'Billie Jean Fingerstyle Tab'
        }]
      }]
    };
    
    // Update the document with complete data
    await videoDoc.reference.update(tutorialData);
    
    print('Successfully fixed Billie Jean tutorial and tabs data');
    
  } catch (e, stackTrace) {
    print('Error fixing Billie Jean data: $e');
    print('Stack trace: $stackTrace');
    rethrow;
  }
} 