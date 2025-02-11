import 'dart:html' as html;
import 'dart:ui_web' as ui_web;

class WebImageUtils {
  static String registerWebImage(String url, String viewId, {bool addClickHandler = false, Function? onTap}) {
    // Register the view factory for web platform
    ui_web.platformViewRegistry.registerViewFactory(viewId, (int viewId) {
      final img = html.ImageElement()
        ..src = url
        ..style.objectFit = 'cover'
        ..style.width = '100%'
        ..style.height = '100%';
      
      if (addClickHandler && onTap != null) {
        img.style.cursor = 'pointer';
        img.onClick.listen((_) => onTap());
      }
      
      return img;
    });
    
    return viewId;
  }
} 