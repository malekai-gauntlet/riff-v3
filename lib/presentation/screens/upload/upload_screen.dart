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
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _artistController = TextEditingController();
  final _tagsController = TextEditingController();
  
  bool _isUploading = false;
  double _uploadProgress = 0;
  String? _errorMessage;
  html.File? _selectedFile;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _artistController.dispose();
    _tagsController.dispose();
    super.dispose();
  }

  Future<void> _pickVideo() async {
    final input = html.FileUploadInputElement()
      ..accept = 'video/*'
      ..click();

    input.onChange.listen((event) {
      final file = input.files?.first;
      if (file != null) {
        setState(() {
          _selectedFile = file;
          _errorMessage = null;
        });
      }
    });
  }

  Future<void> _uploadVideo() async {
    if (!_formKey.currentState!.validate() || _selectedFile == null) return;

    setState(() {
      _isUploading = true;
      _errorMessage = null;
    });

    try {
      final uploadResult = await _uploadService.uploadVideo(
        file: _selectedFile!,
        onProgress: (progress) {
          setState(() => _uploadProgress = progress);
        },
      );

      print('✅ Video uploaded successfully!');
      print('📍 Storage path: ${uploadResult['storagePath']}');
      print('🔗 Download URL: ${uploadResult['downloadUrl']}');

      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Video uploaded successfully!')),
        );
      }
    } catch (e) {
      print('❌ Error uploading video: $e');
      if (mounted) {
        setState(() {
          _errorMessage = e.toString();
          _isUploading = false;
        });
      }
    }
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Video Upload Section
                Center(
                  child: Column(
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
                            : IconButton(
                                onPressed: _pickVideo,
                                icon: Icon(
                                  _selectedFile != null
                                      ? Icons.check_circle
                                      : Icons.cloud_upload_outlined,
                                  size: 48,
                                  color: _selectedFile != null
                                      ? Colors.green
                                      : Colors.white,
                                ),
                              ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        _selectedFile?.name ?? 'No file selected',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'MP4 or WebM (max 30 seconds)',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Form Fields
                const Text(
                  'Title',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _titleController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Enter video title',
                    hintStyle: TextStyle(color: Colors.grey[600]),
                    filled: true,
                    fillColor: Colors.grey[900],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                const Text(
                  'Description',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _descriptionController,
                  style: const TextStyle(color: Colors.white),
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Enter video description',
                    hintStyle: TextStyle(color: Colors.grey[600]),
                    filled: true,
                    fillColor: Colors.grey[900],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                const Text(
                  'Artist (Optional)',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _artistController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Enter artist name',
                    hintStyle: TextStyle(color: Colors.grey[600]),
                    filled: true,
                    fillColor: Colors.grey[900],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                const Text(
                  'Tags (Optional)',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _tagsController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Enter tags separated by commas',
                    hintStyle: TextStyle(color: Colors.grey[600]),
                    filled: true,
                    fillColor: Colors.grey[900],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                if (_errorMessage != null) ...[
                  Text(
                    _errorMessage!,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                ],

                // Upload Button
                Center(
                  child: ElevatedButton(
                    onPressed: _isUploading || _selectedFile == null
                        ? null
                        : _uploadVideo,
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
                          _isUploading ? 'Uploading...' : 'Upload Video',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 