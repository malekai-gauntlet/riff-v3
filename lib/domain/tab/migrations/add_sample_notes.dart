import 'package:cloud_firestore/cloud_firestore.dart';

/// Migration to add sample notes to the existing tab
class AddSampleNotesMigration {
  static Future<void> run() async {
    try {
      print('🎸 Starting sample notes migration...');
      final firestore = FirebaseFirestore.instance;
      
      // Get the existing tab document
      final querySnapshot = await firestore
          .collection('ai_tabs')
          .where('video_id', isEqualTo: 'ZM6Ft9tUBri7TW62ALV6')
          .limit(1)
          .get();
      
      if (querySnapshot.docs.isEmpty) {
        print('❌ No tab document found');
        return;
      }
      
      final doc = querySnapshot.docs.first;
      final data = doc.data();
      
      // Create a sample original melody (not copying any existing song)
      final measures = [
        {
          'index': 0,
          'timeSignature': '4/4',
          'strings': [
            {
              'string': 1,
              'notes': [
                {'fret': 5, 'duration': 1, 'position': 0},
                {'fret': 7, 'duration': 1, 'position': 2},
                {'fret': 8, 'duration': 1, 'position': 4},
              ]
            },
            {
              'string': 2,
              'notes': [
                {'fret': 5, 'duration': 1, 'position': 6}
              ]
            }
          ]
        },
        {
          'index': 1,
          'timeSignature': '4/4',
          'strings': [
            {
              'string': 1,
              'notes': [
                {'fret': 7, 'duration': 1, 'position': 0},
                {'fret': 5, 'duration': 1, 'position': 2}
              ]
            },
            {
              'string': 2,
              'notes': [
                {'fret': 8, 'duration': 1, 'position': 4},
                {'fret': 5, 'duration': 1, 'position': 6}
              ]
            }
          ]
        }
      ];
      
      // Update the sections array with new measures
      data['content']['sections'][0]['measures'] = measures;
      
      // Update the document
      await doc.reference.update({
        'content': data['content']
      });
      
      print('✅ Successfully added sample notes to tab');
      
    } catch (e) {
      print('❌ Error in migration:');
      print(e);
      rethrow;
    }
  }
} 