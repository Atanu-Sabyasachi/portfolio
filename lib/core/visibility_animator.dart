import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VisibilityAnimator extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final double yOffset;

  const VisibilityAnimator({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.yOffset = 0.1,
  });

  @override
  State<VisibilityAnimator> createState() => _VisibilityAnimatorState();
}

class _VisibilityAnimatorState extends State<VisibilityAnimator> {
  bool _isVisible = false;
  final Key _key = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: _key,
      onVisibilityChanged: (info) {
        if (!_isVisible && info.visibleFraction > 0.1) {
          setState(() => _isVisible = true);
        }
      },
      child: widget.child
          .animate(target: _isVisible ? 1 : 0, delay: widget.delay)
          .fade(duration: 600.ms, curve: Curves.easeOutCubic)
          .slideY(begin: widget.yOffset, end: 0, duration: 600.ms, curve: Curves.easeOutCubic),
    );
  }
}
