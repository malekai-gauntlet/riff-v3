import 'package:cloud_functions/cloud_functions.dart';

/// Service class to handle gathering guitar resources using AI
class VideoResourceService {
  final FirebaseFunctions _functions = FirebaseFunctions.instance;

  /// Triggers the cloud function to gather guitar resources
  /// Returns a map containing the discovered resources
  Future<void> gatherResources({
    required String videoId,
    required String title,
    String? artist,
  }) async {
    try {
      // Call the cloud function
      final result = await _functions
          .httpsCallable('gatherGuitarResources')
          .call({
        'videoId': videoId,
        'title': title,
        'artist': artist,
      });

      print('✅ Resources gathered successfully!');
      print('📝 Result: ${result.data}');
    } catch (e) {
      print('❌ Error gathering resources: $e');
      rethrow;
    }
  }
} 