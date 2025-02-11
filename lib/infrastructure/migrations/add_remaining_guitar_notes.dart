import 'package:cloud_firestore/cloud_firestore.dart';

/// Adds guitar notes data to the remaining videos (Canon Rock, Billie Jean, Mad World)
Future<void> addRemainingGuitarNotes() async {
  try {
    // Get Firestore instance
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    
    // Guitar notes for Canon Rock
    await _addGuitarNotesToVideo(
      firestore,
      videoTitle: 'Canon Rock',
      guitarNoteData: {
        'url': 'https://tabs.ultimate-guitar.com/tab/jerryc/canon-rock-tabs-468669',
        'rating': '4.9/5',
        'difficulty': 'advanced',
        'type': 'tabs',
        'title': 'Canon Rock Tab by JerryC'
      }
    );
    
    // Guitar notes for Billie Jean
    await _addGuitarNotesToVideo(
      firestore,
      videoTitle: 'Billie Jean',
      guitarNoteData: {
        'url': 'https://www.songsterr.com/a/wsa/jackson-michael-billie-jean-fingerstyle-tab-s665992',
        'rating': '4.5/5',
        'difficulty': 'advanced',
        'type': 'notes',
        'title': 'Billie Jean Fingerstyle Tab'
      }
    );
    
    // Guitar notes for Mad World
    await _addGuitarNotesToVideo(
      firestore,
      videoTitle: 'Mad World',
      guitarNoteData: {
        'url': 'https://tabs.ultimate-guitar.com/tab/gary-jules/mad-world-tabs-201478',
        'rating': '4.8/5',
        'difficulty': 'moderate',
        'type': 'tabs',
        'title': 'Mad World Tab'
      }
    );
    
    print('Successfully added guitar notes to all videos');
    
  } catch (e, stackTrace) {
    print('Error adding guitar notes data: $e');
    print('Stack trace: $stackTrace');
    rethrow;
  }
}

/// Helper function to add guitar notes data to a specific video
Future<void> _addGuitarNotesToVideo(
  FirebaseFirestore firestore, {
  required String videoTitle,
  required Map<String, dynamic> guitarNoteData,
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
  
  // Get current data
  final data = videoDoc.data();
  final tutorials = List<Map<String, dynamic>>.from(data['tutorials'] ?? []);
  
  // Update the first tutorial with guitar notes data
  if (tutorials.isNotEmpty) {
    // Add guitar notes to the first tutorial
    tutorials[0]['guitarNotes'] = [guitarNoteData];
    
    // Update the document with the modified tutorials array
    await videoDoc.reference.update({
      'tutorials': tutorials
    });
    
    print('Successfully added guitar notes to tutorial for video: $videoTitle');
  } else {
    print('No tutorials found for video: $videoTitle');
  }
} 