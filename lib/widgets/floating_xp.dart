import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/theme.dart';

class FloatingXpData {
  final Offset position;
  final int amount;
  final DateTime timestamp;

  FloatingXpData({
    required this.position,
    required this.amount,
    required this.timestamp,
  });
}

class FloatingXpLayer extends StatefulWidget {
  final Widget child;
  const FloatingXpLayer({super.key, required this.child});

  static _FloatingXpLayerState? of(BuildContext context) {
    return context.findAncestorStateOfType<_FloatingXpLayerState>();
  }

  @override
  State<FloatingXpLayer> createState() => _FloatingXpLayerState();
}

class _FloatingXpLayerState extends State<FloatingXpLayer> {
  final List<FloatingXpData> _xpPopups = [];

  void showXp(Offset position, int amount) {
    setState(() {
      _xpPopups.add(FloatingXpData(
        position: position,
        amount: amount,
        timestamp: DateTime.now(),
      ));
    });

    // Cleanup after animation finishes
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (mounted) {
        setState(() {
          _xpPopups.removeWhere((item) =>
              DateTime.now().difference(item.timestamp).inMilliseconds >= 1100);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        ..._xpPopups.map((data) => _XpIndicator(data: data)),
      ],
    );
  }
}

class _XpIndicator extends StatelessWidget {
  final FloatingXpData data;
  const _XpIndicator({required this.data});

  @override
  Widget build(BuildContext context) {
    final randomX = (Random().nextDouble() - 0.5) * 60; // Horizontal drift

    return Positioned(
      left: data.position.dx - 20,
      top: data.position.dy - 40,
      child: Text(
        '+${data.amount} XP',
        style: const TextStyle(
          color: AppTheme.cyanAccent,
          fontWeight: FontWeight.bold,
          fontSize: 22,
          shadows: [
            Shadow(color: Colors.black, blurRadius: 4, offset: Offset(2, 2)),
            Shadow(color: AppTheme.cyanAccent, blurRadius: 20),
          ],
        ),
      )
          .animate()
          .fadeIn(duration: 200.ms)
          .moveY(begin: 0, end: -120, duration: 1000.ms, curve: Curves.easeOut)
          .moveX(begin: 0, end: randomX, duration: 1000.ms, curve: Curves.easeOut)
          .fadeOut(delay: 600.ms, duration: 400.ms),
    );
  }
}
