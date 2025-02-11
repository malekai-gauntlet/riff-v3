import 'package:cloud_firestore/cloud_firestore.dart';

/// Fixes the Billie Jean tabs data to use the correct field name and type
Future<void> fixBillieJeanTabs() async {
  try {
    // Get Firestore instance
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    
    // Reference to the Billie Jean video
    final videoRef = firestore.collection('videos').where('title', isEqualTo: 'Billie Jean');
    
    // Get the video document
    final videoSnapshot = await videoRef.get();
    
    if (videoSnapshot.docs.isEmpty) {
      print('Billie Jean video not found');
      return;
    }

    // Get the first matching video
    final videoDoc = videoSnapshot.docs.first;
    
    // Get current data
    final data = videoDoc.data();
    final tutorials = List<Map<String, dynamic>>.from(data['tutorials'] ?? []);
    
    if (tutorials.isNotEmpty) {
      // Update the first tutorial with correct tabs data
      tutorials[0]['tabs'] = [{
        'url': 'https://www.songsterr.com/a/wsa/jackson-michael-billie-jean-fingerstyle-tab-s665992',
        'rating': '4.5/5',
        'difficulty': 'advanced',
        'type': 'tabs', // Changed from 'notes' to 'tabs'
        'title': 'Billie Jean Fingerstyle Tab'
      }];
      
      // Remove old guitarNotes field if it exists
      tutorials[0].remove('guitarNotes');
      
      // Update the document
      await videoDoc.reference.update({
        'tutorials': tutorials
      });
      
      print('Successfully fixed Billie Jean tabs data');
    } else {
      print('No tutorials found for Billie Jean');
    }
    
  } catch (e, stackTrace) {
    print('Error fixing Billie Jean tabs: $e');
    print('Stack trace: $stackTrace');
    rethrow;
  }
} 