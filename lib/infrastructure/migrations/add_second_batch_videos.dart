import 'package:cloud_firestore/cloud_firestore.dart';

/// Adds second batch of videos metadata to Firestore
Future<void> addSecondBatchVideos() async {
  try {
    // Get Firestore instance
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    
    // Reference to videos collection
    final videosRef = firestore.collection('videos');

    // List of videos to add (metadata only)
    final videosToAdd = [
      {
        'title': 'Sweet Child O Mine',
        'createdAt': DateTime.now(),
        'creatorId': 'creator1',
        'description': 'Sweet Child O Mine by Guns N\' Roses - Guitar Cover. Classic rock guitar riff with iconic intro.',
        'likeCount': 0,
        'savedByUsers': [],
        'tags': ['guitar', 'cover', 'rock', 'guns n roses', 'slash'],
        'thumbnailUrl': null,
        'tutorials': [],
        'url': '', // Add manually later
        'viewCount': 0,
        'playCount': 0
      },
      {
        'title': 'Stairway to Heaven',
        'createdAt': DateTime.now(),
        'creatorId': 'creator1',
        'description': 'Stairway to Heaven by Led Zeppelin - Guitar Cover. Featuring the legendary guitar solo.',
        'likeCount': 0,
        'savedByUsers': [],
        'tags': ['guitar', 'cover', 'rock', 'led zeppelin', 'jimmy page'],
        'thumbnailUrl': null,
        'tutorials': [],
        'url': '', // Add manually later
        'viewCount': 0,
        'playCount': 0
      },
      {
        'title': 'Nothing Else Matters',
        'createdAt': DateTime.now(),
        'creatorId': 'creator1',
        'description': 'Nothing Else Matters by Metallica - Guitar Cover. Beautiful acoustic intro and powerful electric sections.',
        'likeCount': 0,
        'savedByUsers': [],
        'tags': ['guitar', 'cover', 'metal', 'metallica', 'james hetfield'],
        'thumbnailUrl': null,
        'tutorials': [],
        'url': '', // Add manually later
        'viewCount': 0,
        'playCount': 0
      },
      {
        'title': 'Wonderwall',
        'createdAt': DateTime.now(),
        'creatorId': 'creator1',
        'description': 'Wonderwall by Oasis - Guitar Cover. The quintessential acoustic guitar song of the 90s.',
        'likeCount': 0,
        'savedByUsers': [],
        'tags': ['guitar', 'cover', 'acoustic', 'oasis', 'britpop'],
        'thumbnailUrl': null,
        'tutorials': [],
        'url': '', // Add manually later
        'viewCount': 0,
        'playCount': 0
      },
      {
        'title': 'Hotel California',
        'createdAt': DateTime.now(),
        'creatorId': 'creator1',
        'description': 'Hotel California by Eagles - Guitar Cover. Featuring the iconic dual guitar solo.',
        'likeCount': 0,
        'savedByUsers': [],
        'tags': ['guitar', 'cover', 'rock', 'eagles', 'don felder'],
        'thumbnailUrl': null,
        'tutorials': [],
        'url': '', // Add manually later
        'viewCount': 0,
        'playCount': 0
      },
      {
        'title': 'Smoke on the Water',
        'createdAt': DateTime.now(),
        'creatorId': 'creator1',
        'description': 'Smoke on the Water by Deep Purple - Guitar Cover. The most famous guitar riff of all time.',
        'likeCount': 0,
        'savedByUsers': [],
        'tags': ['guitar', 'cover', 'rock', 'deep purple', 'ritchie blackmore'],
        'thumbnailUrl': null,
        'tutorials': [],
        'url': '', // Add manually later
        'viewCount': 0,
        'playCount': 0
      },
      {
        'title': 'Purple Rain',
        'createdAt': DateTime.now(),
        'creatorId': 'creator1',
        'description': 'Purple Rain by Prince - Guitar Cover. Soulful guitar work and emotional solo.',
        'likeCount': 0,
        'savedByUsers': [],
        'tags': ['guitar', 'cover', 'rock', 'prince', 'funk'],
        'thumbnailUrl': null,
        'tutorials': [],
        'url': '', // Add manually later
        'viewCount': 0,
        'playCount': 0
      }
    ];

    print('\nStarting to add videos to Firestore...');
    print('Videos to be added:');
    for (var video in videosToAdd) {
      print('- ${video['title']}');
    }
    print('\nTotal videos: ${videosToAdd.length}');

    int addedCount = 0;

    // Add each video to Firestore
    for (final videoData in videosToAdd) {
      final docRef = await videosRef.add(videoData);
      print('Added video: ${videoData['title']} (ID: ${docRef.id})');
      addedCount++;
    }

    print('Successfully added $addedCount videos');
  } catch (e) {
    print('Error adding second batch of videos: $e');
    rethrow;
  }
} 