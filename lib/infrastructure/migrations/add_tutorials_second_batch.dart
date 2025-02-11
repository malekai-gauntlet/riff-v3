import 'package:cloud_firestore/cloud_firestore.dart';

/// Adds tutorial data to the second batch of videos
Future<void> addTutorialsSecondBatch() async {
  try {
    // Get Firestore instance
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    
    // Tutorial data for each video
    final tutorialData = {
      'Neon Fingerstyle Cover - John Mayer': {
        'youtubeId': 'fiRNnUSrw4c',
        'title': 'Neon Live in LA - Guitar Tutorial John Mayer Guitar Lesson',
        'channelName': 'Guitar Zero2Hero',
        'viewCount': '1M views',
        'duration': '1:12:05',
        'thumbnailUrl': 'https://img.youtube.com/vi/fiRNnUSrw4c/0.jpg',
        'isBestMatch': true,
        'tabs': [{
          'url': 'https://www.songsterr.com/a/wsa/john-mayer-neon-live-tab-s72073',
          'rating': '4.3/5',
          'difficulty': 'Expert',
          'type': 'tabs',
          'title': 'Neon Live in LA - Guitar Tutorial John Mayer Guitar Lesson'
        }]
      },
      'Girls Like You - Maroon 5 | Fingerstyle Cover': {
        'youtubeId': 'DtxGLf9gpvc',
        'title': 'Fingerstyle Tutorial - Girls Like You',
        'channelName': 'LickNRiff',
        'viewCount': '949k views',
        'duration': '1:00:00',
        'thumbnailUrl': 'https://img.youtube.com/vi/DtxGLf9gpvc/0.jpg',
        'isBestMatch': true,
        'tabs': [{
          'url': 'https://www.e-chords.com/en/chords/maroon-5/girls-like-you',
          'rating': '4/5',
          'difficulty': 'Easy',
          'type': 'tabs',
          'title': 'Girls Like You - Maroon 5'
        }]
      },
      'River Flows in You - Yiruma | Fingerstyle Cover': {
        'youtubeId': 'n2at2weR-cI',
        'title': 'River Flows in You | Fingerstyle Guitar Lesson (Tutorial)',
        'channelName': 'Sungha Jung',
        'viewCount': '1.2M views',
        'duration': '10:20',
        'thumbnailUrl': 'https://img.youtube.com/vi/n2at2weR-cI/0.jpg',
        'isBestMatch': true,
        'tabs': [{
          'url': 'https://fingertabs.com/fingertabs/yiruma-river-flows-in-you-fingerstyle-tabs-marina-mirakova.html',
          'rating': '4.5/5',
          'difficulty': 'Intermediate',
          'type': 'tabs',
          'title': 'Yiruma – River Flows in You Fingerstyle Tabs (Marina Mirakova)'
        }]
      },
      'I Feel It Coming - The Weekend | Fingerstyle Cover': {
        'youtubeId': 'ycnHbLnmGVE',
        'title': 'I Feel It Coming - Fingerstyle Guitar - Adam Rafferty',
        'channelName': 'Adam Rafferty',
        'viewCount': '6.9M views',
        'duration': '7:44',
        'thumbnailUrl': 'https://img.youtube.com/vi/ycnHbLnmGVE/0.jpg',
        'isBestMatch': true,
        'tabs': [{
          'url': 'https://paidtabs.com/search/ANx0HQa9cpw',
          'rating': '4.7/5',
          'difficulty': 'Intermediate',
          'type': 'tabs',
          'title': 'The Weeknd I Feel It Coming Fingerstyle Guitar Tab - Andrew Foy'
        }]
      },
      'Civil War Solo - Acoustic': {
        'youtubeId': '8o14MMXL96o',
        'title': 'Civil War - Fingerstyle Guitar Tutorial (Half-step Down, No Capo)',
        'channelName': 'GNR Tutorials',
        'viewCount': '500K views',
        'duration': '8:45',
        'thumbnailUrl': 'https://img.youtube.com/vi/8o14MMXL96o/0.jpg',
        'isBestMatch': true,
        'tabs': [{
          'url': 'https://www.songsterr.com/a/wsa/guns-n-roses-civil-war-tab-s8153',
          'rating': '4.6/5',
          'difficulty': 'Advanced',
          'type': 'tabs',
          'title': 'Civil War Tab – Guns N\' Roses'
        }]
      },
      'I See Fire | Ed Sheeran | Fingerstyle': {
        'youtubeId': '3QFFBTgnVD8',
        'title': 'I See Fire - Fingerstyle Guitar Lesson - Ed Sheeran',
        'channelName': 'Guitar Zero2Hero',
        'viewCount': '350K views',
        'duration': '6:30',
        'thumbnailUrl': 'https://img.youtube.com/vi/3QFFBTgnVD8/0.jpg',
        'isBestMatch': true,
        'tabs': [{
          'url': 'https://www.songsterr.com/a/wsa/ed-sheeran-i-see-fire-fingerstyle-cover-by-gp-tab-s387601',
          'rating': '4.5/5',
          'difficulty': 'Intermediate',
          'type': 'tabs',
          'title': 'Ed Sheeran – I See Fire Fingerstyle Cover Tab (Gp)'
        }]
      },
      'See You Again | Fingerstyle Version': {
        'youtubeId': '2Lq784V-KPw',
        'title': 'See You Again - Fingerstyle Guitar Tutorial – Wiz Khalifa ft. Charlie Puth',
        'channelName': 'GuitarNick',
        'viewCount': '400K views',
        'duration': '9:10',
        'thumbnailUrl': 'https://img.youtube.com/vi/2Lq784V-KPw/0.jpg',
        'isBestMatch': true,
        'tabs': [{
          'url': 'https://paidtabs.com/search/gnGA1o43UOI',
          'rating': '4.6/5',
          'difficulty': 'Intermediate',
          'type': 'tabs',
          'title': 'See You Again – Wiz Khalifa ft. Charlie Puth Fingerstyle Guitar Tab (Peter Gergely)'
        }]
      },
      'Riffin': {
        'youtubeId': 'k2yIX0Wm3Zo',
        'title': 'Riff - Fingerstyle Riff Demonstration',
        'channelName': 'Guitar Shorts',
        'viewCount': '50K views',
        'duration': '0:30',
        'thumbnailUrl': 'https://img.youtube.com/vi/k2yIX0Wm3Zo/0.jpg',
        'isBestMatch': true,
        'tabs': [{
          'url': 'https://www.ultimate-guitar.com/explore',
          'rating': 'N/A',
          'difficulty': 'N/A',
          'type': 'tabs',
          'title': 'Riff – (No comprehensive tab available)'
        }]
      }
    };

    print('\nStarting to add tutorial data...');
    print('Videos to update:');
    for (var title in tutorialData.keys) {
      print('- $title');
    }

    // Update each video with its tutorial data
    for (var entry in tutorialData.entries) {
      final videoTitle = entry.key;
      final tutorial = entry.value;

      // Find the video by title
      final videoQuery = await firestore
          .collection('videos')
          .where('title', isEqualTo: videoTitle)
          .get();

      if (videoQuery.docs.isEmpty) {
        print('Video not found: $videoTitle');
        continue;
      }

      // Get the first matching video
      final videoDoc = videoQuery.docs.first;
      
      // Update the document with the tutorial data
      await videoDoc.reference.update({
        'tutorials': [tutorial]
      });
      
      print('Added tutorial data to video: $videoTitle');
    }

    print('\nSuccessfully added tutorial data to all videos');
  } catch (e) {
    print('Error adding tutorial data: $e');
    rethrow;
  }
} 