import 'package:flutter/material.dart';
import '../core/theme.dart';

class TechBackground extends StatefulWidget {
  final ValueNotifier<Offset> mousePositionNotifier;

  const TechBackground({super.key, required this.mousePositionNotifier});

  @override
  State<TechBackground> createState() => _TechBackgroundState();
}

class _TechBackgroundState extends State<TechBackground> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Offset>(
      valueListenable: widget.mousePositionNotifier,
      builder: (context, mousePos, child) {
        return CustomPaint(
          size: Size.infinite,
          painter: _StitchPainter(mousePos),
        );
      },
    );
  }
}

class _StitchPainter extends CustomPainter {
  final Offset mousePos;
  final double spacing = 40.0; // Distance between dots

  _StitchPainter(this.mousePos);

  @override
  void paint(Canvas canvas, Size size) {
    final baseColor = AppTheme.cyanAccent.withValues(alpha: 0.15);
    final activeColor = AppTheme.cyanAccent.withValues(alpha: 0.9);

    for (double x = 0; x < size.width + spacing; x += spacing) {
      for (double y = 0; y < size.height + spacing; y += spacing) {
        Offset dotPos = Offset(x, y);

        // Calculate distance from mouse to dot
        double dist = (dotPos - mousePos).distance;

        // Effect radius
        const double effectRadius = 250.0;

        double radius = 0.8; // Base radius of dot
        Color dotColor = baseColor;

        if (dist < effectRadius && mousePos != Offset.zero) {
          // Calculate intensity (1.0 at center, 0.0 at edge)
          double intensity = 1.0 - (dist / effectRadius);

          // Easing for smoother falloff
          intensity = Curves.easeOutCubic.transform(intensity);

          // Increase size and opacity
          radius = 0.8 + (intensity * .7);
          dotColor = Color.lerp(baseColor, activeColor, intensity)!;

          // Slight repulsion effect
          if (dist > 0) {
            Offset pushDir = (dotPos - mousePos) / dist; // normalized vector
            dotPos += pushDir * (intensity * 15.0); // push away by up to 15px
          }
        }

        final paint = Paint()
          ..color = dotColor
          ..style = PaintingStyle.fill;

        canvas.drawCircle(dotPos, radius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _StitchPainter oldDelegate) {
    return oldDelegate.mousePos != mousePos;
  }
}
