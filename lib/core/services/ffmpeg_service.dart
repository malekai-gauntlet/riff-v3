import 'dart:async';
import 'dart:html' as html;
import 'dart:js_util';
import 'dart:typed_data';

/// Service to handle FFmpeg operations in web
class FFmpegService {
  /// Initialize FFmpeg
  Future<bool> initialize() async {
    try {
      // Call the JavaScript initialization function
      final result = await promiseToFuture<bool>(
        callMethod(html.window, 'initializeFFmpeg', [])
      );
      return result;
    } catch (e) {
      print('Error initializing FFmpeg: $e');
      return false;
    }
  }

  /// Extract audio from a video file
  Future<Uint8List?> extractAudioFromVideo(String videoUrl) async {
    try {
      // Call the JavaScript function to extract audio
      final result = await promiseToFuture<dynamic>(
        callMethod(html.window, 'extractAudioFromVideo', [videoUrl])
      );

      // Convert the result back to Uint8List
      final audioData = Uint8List.fromList(
        (result as List).map((e) => e as int).toList()
      );
      
      return audioData;
    } catch (e) {
      print('Error extracting audio: $e');
      return null;
    }
  }
} 