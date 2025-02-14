import 'dart:html' as html;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:video_player/video_player.dart';
import 'package:cloud_functions/cloud_functions.dart';

class VideoUploadService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseFunctions _functions = FirebaseFunctions.instance;

  Future<bool> checkVideoDuration(html.File file) async {
    // Create a temporary URL for the file
    final url = html.Url.createObjectUrl(file);
    final controller = VideoPlayerController.network(url);
    
    try {
      await controller.initialize();
      final duration = controller.value.duration;
      return duration.inSeconds <= 30;
    } finally {
      controller.dispose();
      html.Url.revokeObjectUrl(url);
    }
  }

  /// Uploads a video to Firebase Storage and creates a Firestore document
  /// Returns a map containing the download URL, storage path, and document ID
  Future<Map<String, String>> uploadVideo({
    required html.File file,
    required Function(double) onProgress,
    required String title,
    String? artist,
    required String description,
  }) async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception('User not authenticated');

      // Check video duration
      final isValidDuration = await checkVideoDuration(file);
      if (!isValidDuration) {
        throw Exception('Video must be 30 seconds or less');
      }

      // Create a unique filename
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final filename = 'videos/$timestamp-${file.name}';
      
      // Create upload task
      final ref = _storage.ref().child(filename);
      final metadata = SettableMetadata(
        contentType: file.type,
        customMetadata: {
          'creatorId': user.uid,
          'uploadedAt': DateTime.now().toIso8601String(),
        },
      );

      // Start upload with progress monitoring
      final task = ref.putBlob(file, metadata);
      task.snapshotEvents.listen((TaskSnapshot snapshot) {
        final progress = snapshot.bytesTransferred / snapshot.totalBytes;
        onProgress(progress);
      });

      // Wait for upload to complete
      await task;
      
      // Get download URL
      final downloadUrl = await ref.getDownloadURL();

      // Create Firestore document
      final docRef = await _firestore.collection('videos').add({
        'url': downloadUrl,
        'title': title,
        'description': description,
        'creatorId': user.uid,
        'createdAt': FieldValue.serverTimestamp(),
        'likeCount': 0,
        'playCount': 0,
        'viewCount': 0,
        'savedByUsers': [],
        'likedByUsers': [],
        'tutorials': [],
      });

      // Call cloud function to gather guitar resources
      try {
        print('📞 Calling gatherGuitarResources cloud function with:');
        print('  - videoId: ${docRef.id}');
        print('  - title: $title');
        print('  - artist: ${artist ?? 'not provided'}');

        final callable = _functions.httpsCallable(
          'gatherGuitarResources',
          options: HttpsCallableOptions(
            timeout: const Duration(seconds: 60), // Increase timeout for API calls
          ),
        );

        final result = await callable.call({
          'videoId': docRef.id,
          'title': title,
          'artist': artist,
        });

        print('✅ Cloud function completed successfully');
        print('📦 Function result data: ${result.data}');

      } catch (e) {
        // Log detailed error information
        print('❌ Error calling gatherGuitarResources:');
        if (e is FirebaseFunctionsException) {
          print('  - Code: ${e.code}');
          print('  - Message: ${e.message}');
          print('  - Details: ${e.details}');
          
          // Handle specific error cases
          switch (e.code) {
            case 'not-found':
              print('  → Function not found. Check function deployment');
              break;
            case 'invalid-argument':
              print('  → Invalid arguments provided to function');
              break;
            case 'deadline-exceeded':
              print('  → Function timed out. Check Perplexity API response time');
              break;
            case 'resource-exhausted':
              print('  → Function quota exceeded or out of memory');
              break;
            default:
              print('  → Unexpected error code');
          }
        } else {
          print('  - Unknown error type: ${e.runtimeType}');
          print('  - Error details: $e');
        }
        // Don't rethrow - allow upload to complete
        // Resources can be gathered later if needed
      }
      
      return {
        'downloadUrl': downloadUrl,
        'storagePath': filename,
        'documentId': docRef.id,
      };

    } catch (e) {
      print('Error uploading video: $e');
      rethrow;
    }
  }
} 