import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/theme.dart';
import '../core/game_state_manager.dart';
import '../layout/responsive.dart';

class GameHud extends StatefulWidget {
  final GameStateManager state;
  const GameHud({super.key, required this.state});

  @override
  State<GameHud> createState() => _GameHudState();
}

class _GameHudState extends State<GameHud> {
  late Timer _timer;
  String _currentTime = "";
  DateTime _startTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    _currentTime = _formatTime(DateTime.now());
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _currentTime = _formatTime(DateTime.now());
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatTime(DateTime dt) {
    return "${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}:${dt.second.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobile(context)) return const SizedBox.shrink();

    return Positioned.fill(
      child: IgnorePointer(
        child: Stack(
          children: [
            // BOTTOM LEFT: Radar Minimap
            Positioned(
              bottom: 30,
              left: 30,
              child: _HolographicNode(
                tiltX: -0.1,
                tiltY: 0.1,
                child: _buildRadarCluster(),
              ),
            ),

            // BOTTOM RIGHT: Mission Log
            Positioned(
              bottom: 30,
              right: 30,
              child: _HolographicNode(
                tiltX: -0.1,
                tiltY: -0.1,
                child: _buildMissionLog(),
              ),
            ),

            // MIDDLE RIGHT: Evolution Pulse
            Positioned(
              right: 20,
              top: MediaQuery.of(context).size.height * 0.4,
              child: _HolographicNode(
                child: _buildPulseGraph(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRadarCluster() {
    return Container(
      width: 150,
      height: 150,
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          const Text('MISSION_MAP_RADAR', style: TextStyle(fontSize: 8, color: AppTheme.textMuted, letterSpacing: 2)),
          const Spacer(),
          SizedBox(
            width: 100,
            height: 100,
            child: CustomPaint(
              painter: _RadarPainter(progress: widget.state.xpProgress),
            ),
          ),
          const Spacer(),
          const Text('SCANNING_SECTORS...', style: TextStyle(fontSize: 8, color: AppTheme.cyanAccent)).animate(onPlay: (c) => c.repeat()).fadeOut(duration: 1000.ms),
        ],
      ),
    );
  }

  Widget _buildMissionLog() {
    final uptimeDiff = DateTime.now().difference(_startTime);
    final uptimeStr = "${uptimeDiff.inMinutes.toString().padLeft(2, '0')}:${(uptimeDiff.inSeconds % 60).toString().padLeft(2, '0')}";

    return Container(
      width: 200,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.security, size: 12, color: AppTheme.magentaAccent),
                  SizedBox(width: 8),
                  Text('ACTIVE_MISSION', style: TextStyle(fontSize: 10, color: AppTheme.magentaAccent, fontWeight: FontWeight.bold)),
                ],
              ),
              Text(_currentTime, style: const TextStyle(fontSize: 10, color: AppTheme.cyanAccent, fontFamily: 'monospace', fontWeight: FontWeight.bold)),
            ],
          ),
          const Divider(color: Colors.white10),
          Text(
            widget.state.activeQuest.toUpperCase(),
            style: const TextStyle(fontSize: 14, letterSpacing: 1),
          ),
          const SizedBox(height: 12),
          Text('> UPTIME: $uptimeStr\n> ADDR: 0x${Random().nextInt(1000).toRadixString(16).toUpperCase()}\n> SYNC_STATUS: NOMINAL', 
            style: const TextStyle(fontSize: 8, color: AppTheme.textMuted, fontFamily: 'monospace')),
        ],
      ),
    );
  }

  Widget _buildPulseGraph() {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          const RotatedBox(quarterTurns: 3, child: Text('SYNC_PULSE', style: TextStyle(fontSize: 8, color: AppTheme.textMuted))),
          const SizedBox(height: 8),
          SizedBox(
            width: 30,
            height: 100,
            child: CustomPaint(
              painter: _VerticalSparklinePainter(history: widget.state.xpHistory),
            ),
          ),
        ],
      ),
    );
  }
}

class _HolographicNode extends StatelessWidget {
  final Widget child;
  final double tiltX;
  final double tiltY;

  const _HolographicNode({required this.child, this.tiltX = 0.1, this.tiltY = -0.1});

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateX(tiltX)
        ..rotateY(tiltY),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.1),
          border: Border.all(color: AppTheme.cyanAccent.withValues(alpha: 0.3), width: 1),
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(color: AppTheme.cyanAccent.withValues(alpha: 0.1), blurRadius: 20, spreadRadius: -5),
          ],
        ),
        child: child,
      ),
    ).animate().fadeIn(duration: 800.ms).slide(begin: const Offset(0.1, 0.1));
  }
}

class _RadarPainter extends CustomPainter {
  final double progress;
  _RadarPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    
    // Background rings
    final ringPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.05)
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, radius, ringPaint);
    canvas.drawCircle(center, radius * 0.6, ringPaint);
    canvas.drawCircle(center, radius * 0.3, ringPaint);

    // Radar Sweep
    final sweepPaint = Paint()
      ..shader = SweepGradient(
        colors: [Colors.transparent, AppTheme.cyanAccent.withValues(alpha: 0.4)],
        stops: const [0.8, 1.0],
        transform: GradientRotation(DateTime.now().millisecondsSinceEpoch / 500),
      ).createShader(Rect.fromCircle(center: center, radius: radius));
    
    canvas.drawCircle(center, radius, sweepPaint);

    // Blips
    final blipPositions = [
      Offset(radius * 0.4, radius * 0.3),
      Offset(radius * 1.5, radius * 0.8),
      Offset(radius * 0.8, radius * 1.6),
    ];

    for (var pos in blipPositions) {
      canvas.drawCircle(pos, 3, Paint()..color = AppTheme.cyanAccent.withValues(alpha: 0.6));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _VerticalSparklinePainter extends CustomPainter {
  final List<double> history;
  _VerticalSparklinePainter({required this.history});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppTheme.magentaAccent.withValues(alpha: 0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final path = Path();
    if (history.isEmpty) return;
    final stepY = size.height / (history.length - 1);

    for (int i = 0; i < history.length; i++) {
      final y = i * stepY;
      final x = (history[i] * size.width * 0.8) + 2 + sin(DateTime.now().millisecondsSinceEpoch / 100 + i) * 2;
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
