import 'dart:html' as html;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:video_player/video_player.dart';

class VideoUploadService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

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

  /// Uploads a video to Firebase Storage
  /// Returns a map containing the download URL and storage path
  Future<Map<String, String>> uploadVideo({
    required html.File file,
    required Function(double) onProgress,
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
      
      return {
        'downloadUrl': downloadUrl,
        'storagePath': filename,
      };

    } catch (e) {
      print('Error uploading video: $e');
      rethrow;
    }
  }
} 