// VideoThumbnail widget for displaying individual video previews in the profile grid
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

// Web-specific imports
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
// ignore: avoid_web_libraries_in_flutter
import 'dart:ui' as ui;
// Add this line for web platform registry
import 'package:flutter/foundation.dart' show kIsWeb;
// ignore: avoid_web_libraries_in_flutter
import 'dart:ui_web' as ui_web if (dart.library.html) '';

class VideoThumbnail extends StatelessWidget {
  // Add static set to track registered views
  static final Set<String> _registeredViews = {};
  
  // Properties for the video thumbnail
  final String? thumbnailUrl; // URL for the video thumbnail image
  final int likeCount; // Number of likes to display
  final VoidCallback onTap; // Callback for when thumbnail is tapped

  const VideoThumbnail({
    super.key,
    this.thumbnailUrl,
    required this.likeCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('\n👆 Main Thumbnail Tap:');
        print('🖼️ Thumbnail URL: $thumbnailUrl');
        print('💻 Platform: ${kIsWeb ? 'Web' : 'Mobile'}');
        onTap();
      },
      behavior: HitTestBehavior.opaque, // Make entire area tappable
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Thumbnail with platform-specific implementation
          if (thumbnailUrl != null)
            if (kIsWeb)
              _buildWebImage(thumbnailUrl!)
            else
              CachedNetworkImage( // Use CachedNetworkImage for mobile
                imageUrl: thumbnailUrl!,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Colors.grey[300],
                  child: const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[300],
                  child: const Icon(
                    Icons.error_outline,
                    color: Colors.grey,
                  ),
                ),
              )
          else
            Container(
              color: Colors.grey[300],
              child: const Icon(
                Icons.video_library,
                color: Colors.grey,
              ),
            ),

          // Like count overlay
          Positioned(
            left: 8,
            bottom: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.favorite,
                    color: Colors.white,
                    size: 14,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    _formatCount(likeCount),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWebImage(String url) {
    final String viewId = 'thumbnail-${url.hashCode}';
    print('\n🌐 Building Web Image:');
    print('🔑 View ID: $viewId');
    print('🔗 URL: $url');
    
    if (kIsWeb && !_registeredViews.contains(viewId)) {
      print('📝 Registering new view factory');
      // Update this line to use the correct registry access
      // ignore: undefined_prefixed_name
      ui_web.platformViewRegistry.registerViewFactory(viewId, (int viewId) {
        print('🏭 Creating image element for viewId: $viewId');
        final container = html.DivElement()
          ..style.width = '100%'
          ..style.height = '100%'
          ..style.cursor = 'pointer';
          
        final img = html.ImageElement()
          ..src = url
          ..style.objectFit = 'cover'
          ..style.width = '100%'
          ..style.height = '100%';
          
        container.append(img);
        
        // Add click handler to the container
        container.onClick.listen((event) {
          print('\n👆 Web Image Clicked:');
          print('🖼️ Thumbnail URL: $url');
          onTap();
        });
        
        return container;
      });
      _registeredViews.add(viewId);
      print('✅ View registered successfully');
    } else {
      print('ℹ️ View already registered');
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: HtmlElementView(
        viewType: viewId,
      ),
    );
  }
  
  String _formatCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    } else {
      return count.toString();
    }
  }
} 