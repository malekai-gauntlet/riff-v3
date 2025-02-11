import 'package:cloud_firestore/cloud_firestore.dart';

/// Fixes any null fields in the videos collection
Future<void> fixNullFields() async {
  try {
    // Get all videos
    final videosSnapshot = await FirebaseFirestore.instance.collection('videos').get();
    
    for (var doc in videosSnapshot.docs) {
      final data = doc.data();
      bool needsUpdate = false;
      Map<String, dynamic> updatedData = Map.from(data);

      // Fix main video fields
      if (data['thumbnailUrl'] == null) {
        updatedData['thumbnailUrl'] = ''; // or some default thumbnail
        needsUpdate = true;
      }

      // Fix tutorials array
      if (data['tutorials'] != null) {
        List<dynamic> tutorials = List.from(data['tutorials']);
        bool tutorialsUpdated = false;

        for (int i = 0; i < tutorials.length; i++) {
          Map<String, dynamic> tutorial = Map.from(tutorials[i]);
          bool tutorialUpdated = false;

          if (tutorial['thumbnailUrl'] == null) {
            tutorial['thumbnailUrl'] = ''; // or some default thumbnail
            tutorialUpdated = true;
          }

          // Fix tabs array
          if (tutorial['tabs'] != null) {
            List<dynamic> tabs = List.from(tutorial['tabs']);
            bool tabsUpdated = false;

            for (int j = 0; j < tabs.length; j++) {
              Map<String, dynamic> tab = Map.from(tabs[j]);
              bool tabUpdated = false;

              // Add any missing fields with default values
              if (tab['title'] == null) {
                tab['title'] = '';
                tabUpdated = true;
              }
              if (tab['url'] == null) {
                tab['url'] = '';
                tabUpdated = true;
              }

              if (tabUpdated) {
                tabs[j] = tab;
                tabsUpdated = true;
              }
            }

            if (tabsUpdated) {
              tutorial['tabs'] = tabs;
              tutorialUpdated = true;
            }
          }

          if (tutorialUpdated) {
            tutorials[i] = tutorial;
            tutorialsUpdated = true;
          }
        }

        if (tutorialsUpdated) {
          updatedData['tutorials'] = tutorials;
          needsUpdate = true;
        }
      }

      // Update document if any changes were made
      if (needsUpdate) {
        print('Fixing null fields for video: ${data['title']}');
        await doc.reference.update(updatedData);
      }
    }

    print('Successfully fixed null fields in all videos');
  } catch (e) {
    print('Error fixing null fields: $e');
    rethrow;
  }
} 