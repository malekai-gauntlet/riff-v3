import 'package:flutter/material.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// A test screen for experimenting with audio extraction from videos
class AudioExtractionTestScreen extends StatefulWidget {
  const AudioExtractionTestScreen({super.key});

  @override
  State<AudioExtractionTestScreen> createState() => _AudioExtractionTestScreenState();
}

class _AudioExtractionTestScreenState extends State<AudioExtractionTestScreen> {
  String _statusMessage = '';
  String _errorMessage = '';
  bool _isProcessing = false;

  Future<void> _startTabGeneration() async {
    try {
      // Check if user is authenticated
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        print('No user logged in, attempting anonymous sign in...');
        await FirebaseAuth.instance.signInAnonymously();
      }

      setState(() {
        _isProcessing = true;
        _statusMessage = 'Starting tab generation...';
        _errorMessage = '';
      });

      print('Calling Cloud Function with user: ${FirebaseAuth.instance.currentUser?.uid}');
      
      // Call the Cloud Function
      final result = await FirebaseFunctions.instanceFor(region: 'us-central1')
          .httpsCallable('generateTabFromAudio',
            options: HttpsCallableOptions(
              timeout: const Duration(seconds: 30),
            ),
          )
          .call({
        'documentId': 'ZM6Ft9tUBri7TW62ALV6',
      });

      // Handle the response
      final data = result.data as Map<String, dynamic>;
      
      setState(() {
        _isProcessing = false;
        _statusMessage = 'Response received: ${data['message']}\nMP3 URL: ${data['mp3url']}';
      });

      print('Cloud Function Result: ${result.data}');
    } catch (e) {
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
            ElevatedButton(
              onPressed: _isProcessing ? null : _startTabGeneration,
              child: Text(_isProcessing ? 'Processing...' : 'Generate Tab'),
            ),
            if (_statusMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  _statusMessage,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
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