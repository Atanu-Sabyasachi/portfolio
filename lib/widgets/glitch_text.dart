import 'dart:math';
import 'package:flutter/material.dart';
import '../core/theme.dart';

class GlitchText extends StatefulWidget {
  final String text;
  final TextStyle? style;

  const GlitchText({super.key, required this.text, this.style});

  @override
  State<GlitchText> createState() => _GlitchTextState();
}

class _GlitchTextState extends State<GlitchText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Random _rnd = Random();

  double _offset1 = 0;
  double _offset2 = 0;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(
            vsync: this,
            duration: const Duration(milliseconds: 100),
          )
          ..addListener(() {
            if (_rnd.nextDouble() > 0.8) {
              setState(() {
                _offset1 = (_rnd.nextDouble() - 0.5) * 6; // Glitch range
                _offset2 = (_rnd.nextDouble() - 0.5) * 6;
              });
            } else {
              setState(() {
                _offset1 = 0;
                _offset2 = 0;
              });
            }
          })
          ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Cyan Shift
        if (_offset1 != 0)
          Positioned(
            left: _offset1,
            top: _offset2,
            child: Text(
              widget.text,
              style: widget.style?.copyWith(
                color: AppTheme.cyanAccent.withValues(alpha: 0.5),
              ),
            ),
          ),
        // Red Shift
        if (_offset2 != 0)
          Positioned(
            left: -_offset1,
            top: -_offset2,
            child: Text(
              widget.text,
              style: widget.style?.copyWith(
                color: Colors.redAccent.withValues(alpha: 0.5),
              ),
            ),
          ),
        // Base Text
        Text(widget.text, style: widget.style),
      ],
    );
  }
}
