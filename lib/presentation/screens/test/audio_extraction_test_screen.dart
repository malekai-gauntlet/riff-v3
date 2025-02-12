import 'package:flutter/material.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// A test screen for experimenting with audio extraction and tab generation.
/// This screen provides a simple interface to:
/// 1. Test the cloud function that generates tabs from audio
/// 2. Display processing status and any errors
/// 3. Show the results of the tab generation process
class AudioExtractionTestScreen extends StatefulWidget {
  const AudioExtractionTestScreen({super.key});

  @override
  State<AudioExtractionTestScreen> createState() => _AudioExtractionTestScreenState();
}

class _AudioExtractionTestScreenState extends State<AudioExtractionTestScreen> {
  // Track the status message to display to the user
  String _statusMessage = '';
  
  // Track any error messages that occur during processing
  String _errorMessage = '';
  
  // Flag to indicate if tab generation is in progress
  bool _isProcessing = false;

  /// Initiates the tab generation process by:
  /// 1. Ensuring user is authenticated (anonymous auth if needed)
  /// 2. Calling the cloud function with WAV URL and document ID
  /// 3. Handling the response and any errors
  Future<void> _startTabGeneration() async {
    try {
      // Ensure user is authenticated for Firebase access
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        print('No user logged in, attempting anonymous sign in...');
        await FirebaseAuth.instance.signInAnonymously();
      }

      // Update UI to show processing state
      setState(() {
        _isProcessing = true;
        _statusMessage = 'Starting tab generation...';
        _errorMessage = '';
      });

      print('Calling Cloud Function with user: ${FirebaseAuth.instance.currentUser?.uid}');
      
      // Call the Cloud Function with:
      // - WAV URL: Location of the audio file to analyze
      // - AI Tabs Document ID: Firestore document to update with tab data
      final result = await FirebaseFunctions.instanceFor(region: 'us-central1')
          .httpsCallable('generateTabFromAudio',
            options: HttpsCallableOptions(
              timeout: const Duration(seconds: 30),
            ),
          )
          .call({
        'wavurl': 'https://firebasestorage.googleapis.com/v0/b/riff-8a2c9.firebasestorage.app/o/videos%2Fcanon%20new.wav?alt=media&token=28df4793-67b4-42ff-b1c5-72fcc41e2560',
        'aiTabsDocumentId': 'sDjjCXMoYwJ2nrx8R6Xa',
      });

      // Parse and display the response from the cloud function
      final data = result.data as Map<String, dynamic>;
      
      setState(() {
        _isProcessing = false;
        _statusMessage = 'Response received: ${data['message']}\nMP3 URL: ${data['mp3url']}';
      });

      print('Cloud Function Result: ${result.data}');
    } catch (e) {
      // Log and display any errors that occur
      print('Detailed error: $e');
      setState(() {
        _isProcessing = false;
        _errorMessage = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Audio Extraction Test'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Main action button - disabled while processing
            ElevatedButton(
              onPressed: _isProcessing ? null : _startTabGeneration,
              child: Text(_isProcessing ? 'Processing...' : 'Generate Tab'),
            ),
            // Status message display
            if (_statusMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  _statusMessage,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            // Error message display
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  _errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
} 