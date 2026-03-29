import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class AudioManager {
  static final Map<String, Uint8List> _cache = {};
  static final AudioPlayer _player = AudioPlayer()..setReleaseMode(ReleaseMode.stop);
  static bool isMuted = true; // Default to muted for web compliance

  static const String hoverSfx = 'assets/audio/hover.mp3';
  static const String clickSfx = 'assets/audio/click.mp3';
  static const String transitionSfx = 'assets/audio/transition.mp3';
  static const String cardHoverSfx = 'assets/audio/card_transition.mp3';
  static const String notificationSfx = 'assets/audio/notification.mp3';

  /// Pre-load sounds into memory (Required for reliable web playback)
  static Future<void> init() async {
    try {
      final assets = [
        hoverSfx,
        clickSfx,
        transitionSfx,
        cardHoverSfx,
        notificationSfx,
      ];

      for (var asset in assets) {
        final data = await rootBundle.load(asset);
        _cache[asset] = data.buffer.asUint8List();
      }
      debugPrint('Audio System: 5 assets pre-loaded.');
    } catch (e) {
      debugPrint('Audio System Initialization Error: $e');
    }
  }

  static void toggleMute() {
    isMuted = !isMuted;
  }

  static Source? _getSource(String key) {
    if (!_cache.containsKey(key)) return null;
    return BytesSource(_cache[key]!);
  }

  static Future<void> playHover() async {
    if (isMuted) return;
    try {
      final source = _getSource(hoverSfx);
      if (source == null) return;
      await _player.stop();
      await _player.play(source, volume: 0.1);
    } catch (e) {
      debugPrint('Audio Error (Hover): $e');
    }
  }

  static Future<void> playCardHover() async {
    if (isMuted) return;
    try {
      final source = _getSource(cardHoverSfx);
      if (source == null) return;
      final p = AudioPlayer(); // One-off for overlapping hover blips
      await p.play(source, volume: 0.15);
    } catch (e) {
      debugPrint('Audio Error (CardHover): $e');
    }
  }

  static Future<void> playClick() async {
    if (isMuted) return;
    try {
      final source = _getSource(clickSfx);
      if (source == null) return;
      final p = AudioPlayer(); 
      await p.play(source, volume: 0.5);
    } catch (e) {
      debugPrint('Audio Error (Click): $e');
    }
  }

  static Future<void> playTransition() async {
    if (isMuted) return;
    try {
      final source = _getSource(transitionSfx);
      if (source == null) return;
      final p = AudioPlayer();
      await p.play(source, volume: 0.4);
    } catch (e) {
      debugPrint('Audio Error (Transition): $e');
    }
  }

  static Future<void> playNotification() async {
    if (isMuted) return;
    try {
      final source = _getSource(notificationSfx);
      if (source == null) return;
      final p = AudioPlayer();
      await p.play(source, volume: 0.4);
    } catch (e) {
      debugPrint('Audio Error (Notification): $e');
    }
  }
}
