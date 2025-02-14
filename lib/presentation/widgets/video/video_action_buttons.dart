import 'package:flutter/material.dart';
import '../../../domain/video/video_model.dart';
import '../../../domain/video/video_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../screens/tutorial/tutorial_screen.dart';
import 'package:video_player/video_player.dart';
import '../comment/comment_bottom_sheet.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../domain/comment/comment_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import '../../screens/tab/tab_view_screen.dart';

// Convert to StatefulWidget for local state management
class VideoActionButtons extends StatefulWidget {
  final Video video;
  final VideoPlayerController? controller;

  const VideoActionButtons({
    super.key,
    required this.video,
    this.controller,
  });

  @override
  State<VideoActionButtons> createState() => _VideoActionButtonsState();
}

class _VideoActionButtonsState extends State<VideoActionButtons> {
  final VideoRepository _videoRepository = VideoRepository();
  final CommentRepository _commentRepository = CommentRepository();
  
  // Local state to track saved and liked status
  bool? _optimisticIsSaved;
  bool? _optimisticIsLiked;
  // Add optimistic like count
  int? _optimisticLikeCount;
  // Add optimistic save count
  int? _optimisticSaveCount;
  // Add comment count
  int _commentCount = 0;
  
  // Add speed state
  double _currentSpeed = 1.0;
  
  // Get current user ID
  String? get _currentUserId => FirebaseAuth.instance.currentUser?.uid;

  // Show the no tabs bottom sheet
  void _showNoTabsBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "This riff doesn't have tabs online.",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close bottom sheet
                _startTabGeneration();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Create AI Generated Tabs',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  // Function to start tab generation
  Future<void> _startTabGeneration() async {
    try {
      // Get the video document to check for wavurl
      final videoDoc = await FirebaseFirestore.instance
          .collection('videos')
          .doc(widget.video.id)
          .get();

      final data = videoDoc.data();
      if (data == null || !data.containsKey('wavurl')) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No WAV file available for this video')),
          );
        }
        return;
      }

      final wavurl = data['wavurl'] as String;

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Generating tab...')),
        );
      }

      // Ensure user is authenticated
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        await FirebaseAuth.instance.signInAnonymously();
      }

      // Create a new document in ai_tabs collection
      final aiTabsDoc = await FirebaseFirestore.instance
          .collection('ai_tabs')
          .add({
        'video_id': widget.video.id,
        'created_at': FieldValue.serverTimestamp(),
      });

      // Call the cloud function to generate tab
      final functions = FirebaseFunctions.instance;
      final result = await functions
          .httpsCallable('generateTabFromAudio')
          .call({
        'wavurl': wavurl,
        'aiTabsDocumentId': aiTabsDoc.id,
      });

      if (result.data['success'] == true && mounted) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tab generated successfully!')),
        );
        
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => TabViewScreen(
              video: widget.video,
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to generate tab: $e')),
        );
      }
    }
  }

  // Check if video has any type of tabs (Guitar Pro or AI)
  Future<bool> _hasAnyTabs() async {
    try {
      // Check for Guitar Pro tabs
      final videoDoc = await FirebaseFirestore.instance
          .collection('videos')
          .doc(widget.video.id)
          .get();
      
      if (videoDoc.exists) {
        final data = videoDoc.data();
        if (data != null && 
            data.containsKey('guitarprourl') && 
            data['guitarprourl'] != null && 
            data['guitarprourl'].toString().isNotEmpty) {
          return true;
        }
      }

      // Check for AI-generated tabs
      final aiTabsQuery = await FirebaseFirestore.instance
          .collection('ai_tabs')
          .where('video_id', isEqualTo: widget.video.id)
          .limit(1)
          .get();

      return aiTabsQuery.docs.isNotEmpty;
    } catch (e) {
      print('Error checking for tabs: $e');
      return false;
    }
  }

  // Check if video is saved by current user, using optimistic value if available
  bool get _isSaved {
    if (_optimisticIsSaved != null) return _optimisticIsSaved!;
    return _currentUserId != null && widget.video.savedByUsers.contains(_currentUserId!);
  }

  // Check if video is liked by current user, using optimistic value if available
  bool get _isLiked {
    if (_optimisticIsLiked != null) return _optimisticIsLiked!;
    return _currentUserId != null && widget.video.likedByUsers.contains(_currentUserId!);
  }

  // Get current like count with optimistic value
  int get _likeCount {
    return _optimisticLikeCount ?? widget.video.likeCount;
  }

  // Get current save count with optimistic value
  int get _saveCount {
    return _optimisticSaveCount ?? widget.video.savedByUsers.length;
  }

  @override
  void initState() {
    super.initState();
    _loadCommentCount();
  }

  Future<void> _loadCommentCount() async {
    try {
      final count = await _commentRepository.getCommentCount(widget.video.id);
      if (mounted) {
        setState(() {
          _commentCount = count;
        });
      }
    } catch (e) {
      print('Error loading comment count: $e');
    }
  }

  void _showComments(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CommentBottomSheet(
        videoId: widget.video.id,
        onClose: () {
          Navigator.pop(context);
          widget.controller?.play();
        },
      ),
    );
  }

  // Add method to handle speed changes
  Future<void> _changeSpeed(double speed) async {
    if (widget.controller == null) return;
    
    try {
      await widget.controller!.setPlaybackSpeed(speed);
      setState(() {
        _currentSpeed = speed;
      });
      
      // Show feedback
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Playback speed: ${speed}x'),
          duration: const Duration(seconds: 1),
        ),
      );
    } catch (e) {
      print('Error changing speed: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error changing playback speed')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70, // Fixed width for the action buttons column
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Like Button
          _ActionButton(
            icon: Icon(
              _isLiked ? Icons.favorite : Icons.favorite_border,
              color: _isLiked ? Colors.red : Colors.white,
              size: 32,
            ),
            label: _likeCount.toString(),
            onTap: () async {
              final userId = _currentUserId;
              if (userId == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please log in to like videos')),
                );
                return;
              }
              
              // Optimistically update UI including like count
              setState(() {
                _optimisticIsLiked = !_isLiked;
                _optimisticLikeCount = _likeCount + (_isLiked ? 1 : -1);
              });
              
              try {
                final isLiked = await _videoRepository.toggleLikeVideo(widget.video.id, userId);
                
                // Update local state with server response
                setState(() {
                  _optimisticIsLiked = isLiked;
                });
                
                // Show feedback
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(isLiked ? 'Video liked' : 'Like removed'),
                    duration: const Duration(seconds: 1),
                  ),
                );
              } catch (e) {
                // Revert optimistic update on error
                setState(() {
                  _optimisticIsLiked = null;
                  _optimisticLikeCount = null;
                });
                
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Error liking video')),
                );
              }
            },
          ),
          // Save Button
          _ActionButton(
            icon: Icon(
              _isSaved ? Icons.bookmark : Icons.bookmark_outline,
              color: _isSaved ? Colors.blue : Colors.white,
              size: 32,
            ),
            label: _saveCount.toString(),
            onTap: () async {
              final userId = _currentUserId;
              if (userId == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please log in to save videos')),
                );
                return;
              }
              
              // Optimistically update UI including save count
              setState(() {
                _optimisticIsSaved = !_isSaved;
                _optimisticSaveCount = _saveCount + (_isSaved ? 1 : -1);
              });
              
              try {
                final isSaved = await _videoRepository.toggleSaveVideo(widget.video.id, userId);
                
                // Update local state with server response
                if (mounted) {
                  setState(() {
                    _optimisticIsSaved = isSaved;
                  });
                  
                  // Show feedback
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(isSaved ? 'Video saved' : 'Video unsaved'),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                }
              } catch (e) {
                // Revert optimistic update on error
                if (mounted) {
                  setState(() {
                    _optimisticIsSaved = null;
                    _optimisticSaveCount = null;
                  });
                  
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Error saving video')),
                  );
                }
              }
            },
          ),
          // Comment Button
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: _ActionButton(
              icon: const Icon(
                Icons.chat_bubble_outline,
                color: Colors.white,
                size: 24,
              ),
              label: _commentCount.toString(),
              onTap: () {
                // Pause the video when opening comments
                widget.controller?.pause();
                _showComments(context);
              },
            ),
          ),
          // Mute toggle button
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: _ActionButton(
              icon: Icon(
                widget.controller?.value.volume == 0 ? Icons.volume_off : Icons.volume_up,
                color: Colors.white,
                size: 28,
              ),
              label: '',
              onTap: () async {
                final isMuted = widget.controller?.value.volume == 0;
                await widget.controller?.setVolume(isMuted ? 1.0 : 0.0);
                setState(() {}); // Trigger rebuild to update icon
              },
            ),
          ),
          // Tutorial Button
          _ActionButton(
            icon: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.shade200.withOpacity(0.15),
                    blurRadius: 12,
                    spreadRadius: 12,
                  ),
                ],
              ),
              child: SvgPicture.asset(
                'assets/images/guitar-solid.svg',
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
                height: 30,
                width: 30,
              ),
            ),
            label: 'Tutorial',
            onTap: () async {
              // Pause the video if controller exists
              widget.controller?.pause();
              
              // Check if the video has any tabs
              final hasTabs = await _hasAnyTabs();
              
              if (!mounted) return;
              
              if (hasTabs) {
                // If tabs exist, show tutorial screen
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => TutorialScreen(
                      video: widget.video,
                      onClose: () {
                        // Resume video when returning from tutorial screen
                        widget.controller?.play();
                      },
                    ),
                  ),
                );
              } else {
                // If no tabs exist, show bottom sheet
                _showNoTabsBottomSheet();
              }
            },
          ),
          const SizedBox(height: 8), // Reduced spacing before speed control
          // Speed Control Button
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: _ActionButton(
              icon: Icon(
                Icons.speed,
                color: Colors.white.withOpacity(0.8),
                size: 20,
              ),
              label: _currentSpeed == 1.0 ? '1x' : '${_currentSpeed}x',
              onTap: () {
                final RenderBox button = context.findRenderObject() as RenderBox;
                final Offset position = button.localToGlobal(Offset.zero);
                
                showMenu(
                  context: context,
                  position: RelativeRect.fromLTRB(
                    position.dx - 10,
                    position.dy - -5,
                    position.dx,
                    position.dy,
                  ),
                  color: Colors.black.withOpacity(0.9),
                  items: [
                    PopupMenuItem(
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                      child: Text('1x', style: TextStyle(color: Colors.white)),
                      value: 1.0,
                    ),
                    PopupMenuItem(
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                      child: Text('0.75x', style: TextStyle(color: Colors.white)),
                      value: 0.75,
                    ),
                    PopupMenuItem(
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                      child: Text('0.5x', style: TextStyle(color: Colors.white)),
                      value: 0.5,
                    ),
                    PopupMenuItem(
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                      child: Text('0.25x', style: TextStyle(color: Colors.white)),
                      value: 0.25,
                    ),
                  ],
                ).then((value) {
                  if (value != null) {
                    _changeSpeed(value);
                  }
                });
              },
            ),
          ),
          const SizedBox(height: 12), // Spacing from bottom
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final Widget icon;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: icon,
        ),
        const SizedBox(height: 3), // Reduced space between icon and number
        if (label != 'Tutorial') // Don't show numbers for tutorial button
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        const SizedBox(height: 12), // Space between button groups
      ],
    );
  }
} 