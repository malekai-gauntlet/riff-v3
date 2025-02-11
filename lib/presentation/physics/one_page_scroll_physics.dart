import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class OnePageScrollPhysics extends PageScrollPhysics {
  const OnePageScrollPhysics({ScrollPhysics? parent}) : super(parent: parent);

  @override
  OnePageScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return OnePageScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  double getPixels(ScrollMetrics position, double velocity) {
    if (kIsWeb) {
      // On web, be more strict about page snapping
      final double page = (position.pixels / position.viewportDimension).round().toDouble();
      return page * position.viewportDimension;
    }
    
    final double targetPage = position.pixels / position.viewportDimension;
    final int pageIndex = targetPage.round();  // Lock to nearest page
    return pageIndex * position.viewportDimension;
  }

  @override
  double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
    if (kIsWeb) {
      // On web, be more aggressive about clamping the scroll
      final double maxOffset = position.viewportDimension * 0.5;  // Only allow half-page scrolls
      return offset.clamp(-maxOffset, maxOffset);
    }
    return offset.clamp(-position.viewportDimension, position.viewportDimension);
  }

  @override
  Simulation? createBallisticSimulation(ScrollMetrics position, double velocity) {
    if (kIsWeb && velocity.abs() > 1000) {
      // On web, reduce high-velocity scrolls
      velocity = velocity.sign * 1000;
    }
    
    final double targetPixels = getPixels(position, velocity);
    return ScrollSpringSimulation(
      spring,
      position.pixels,
      targetPixels,
      velocity,
      tolerance: tolerance,
    );
  }
} 