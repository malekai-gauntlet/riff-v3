import 'package:flutter/material.dart';
import 'dart:html' as html;
import '../../../domain/video/video_upload_service.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final VideoUploadService _uploadService = VideoUploadService();
  bool _isUploading = false;
  double _uploadProgress = 0;
  String? _errorMessage;

  Future<void> _pickAndUploadVideo() async {
    // Create input element
    final input = html.FileUploadInputElement()
      ..accept = 'video/*'
      ..click();

    // Wait for file to be picked
    input.onChange.listen((event) async {
      final file = input.files?.first;
      if (file == null) return;

      setState(() {
        _isUploading = true;
        _errorMessage = null;
      });

      try {
        await _uploadService.uploadVideo(
          file: file,
          onProgress: (progress) {
            setState(() => _uploadProgress = progress);
          },
        );

        if (mounted) {
          Navigator.of(context).pop(); // Close upload screen
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Video uploaded successfully!')),
          );
        }
      } catch (e) {
        if (mounted) {
          setState(() {
            _errorMessage = e.toString();
            _isUploading = false;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          'Upload Video',
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.5,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(12),
              ),
              child: _isUploading
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          value: _uploadProgress,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${(_uploadProgress * 100).toInt()}%',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    )
                  : const Icon(
                      Icons.cloud_upload_outlined,
                      size: 48,
                      color: Colors.white,
                    ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Upload a video',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'MP4 or WebM (max 30 seconds)',
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 15,
                letterSpacing: -0.2,
              ),
            ),
            if (_errorMessage != null) ...[
              const SizedBox(height: 12),
              Text(
                _errorMessage!,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _isUploading ? null : _pickAndUploadVideo,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                minimumSize: const Size(200, 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _isUploading 
                      ? Icons.hourglass_empty 
                      : Icons.file_upload_outlined,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _isUploading ? 'Uploading...' : 'Select file',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} 