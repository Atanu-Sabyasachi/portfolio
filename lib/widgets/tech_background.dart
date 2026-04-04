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
  final double spacing = 25.0; // Increased density (was 40.0)

  _StitchPainter(this.mousePos);

  @override
  void paint(Canvas canvas, Size size) {
    final baseColor = AppTheme.cyanAccent.withValues(alpha: 0.25); // Increased visibility (was 0.1)
    final activeColor = AppTheme.cyanAccent;

    for (double x = 0; x < size.width + spacing; x += spacing) {
      for (double y = 0; y < size.height + spacing; y += spacing) {
        Offset dotPos = Offset(x, y);

        double dist = (dotPos - mousePos).distance;
        const double effectRadius = 180.0; // Decreased radius (was 300.0)
        double radius = 0.6; // Slightly larger base radius
        Color dotColor = baseColor;

        if (dist < effectRadius && mousePos != Offset.zero) {
          double intensity = 1.0 - (dist / effectRadius);
          intensity = Curves.easeOutCubic.transform(intensity);

          radius = 0.6 + (intensity * 1.5);
          dotColor = activeColor.withValues(alpha: 0.25 + (intensity * 0.75));

          // Repulsion
          Offset pushDir = (dotPos - mousePos) / (dist + 0.1);
          dotPos += pushDir * (intensity * 20.0);
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
