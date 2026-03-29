import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimationCore {
  /// Base subtle entrance for large blocks
  static Widget fadeSlide(Widget child, {Duration delay = Duration.zero}) {
    return child
        .animate(delay: delay)
        .fade(duration: 600.ms, curve: Curves.easeOutCubic)
        .slideY(begin: 0.1, end: 0, duration: 600.ms, curve: Curves.easeOutCubic);
  }

  /// Staggered effect for list items
  static List<Widget> stagger(List<Widget> children, {Duration interval = const Duration(milliseconds: 100)}) {
    return children.animate(interval: interval)
        .fade(duration: 400.ms)
        .slideY(begin: 0.1, end: 0);
  }
  
  /// Tech blink for title bars
  static Widget techBlink(Widget child) {
    return child
        .animate()
        .fadeIn(duration: 200.ms)
        .then(delay: 100.ms)
        .shimmer(duration: 1000.ms, color: Colors.white24);
  }
}
