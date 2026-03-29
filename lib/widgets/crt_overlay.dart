import 'package:flutter/material.dart';

class CrtOverlay extends StatelessWidget {
  final Widget child;

  const CrtOverlay({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        IgnorePointer(
          child: CustomPaint(
            size: Size.infinite,
            painter: _CrtScanlinePainter(),
          ),
        ),
      ],
    );
  }
}

class _CrtScanlinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
          .withValues(alpha: 0.1) // Subtle scanline
      ..style = PaintingStyle.fill;

    // Draw horizontal scanlines
    for (double i = 0; i < size.height; i += 3) {
      canvas.drawRect(Rect.fromLTWH(0, i, size.width, 1.5), paint);
    }

    // Draw dark retro vignette
    final Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final gradient = RadialGradient(
      center: Alignment.center,
      radius: 0.8,
      colors: [Colors.transparent, Colors.black.withValues(alpha: 0.6)],
      stops: const [0.7, 1.0],
    );
    canvas.drawRect(rect, Paint()..shader = gradient.createShader(rect));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
