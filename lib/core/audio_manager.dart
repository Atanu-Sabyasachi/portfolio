import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

class AudioManager {
  static final AudioPlayer _player = AudioPlayer()..setReleaseMode(ReleaseMode.stop);
  static bool isMuted = true; // Default to muted for web compliance

  static const String hoverSfx = 'audio/hover.mp3';
  static const String clickSfx = 'audio/click.mp3';
  static const String transitionSfx = 'audio/transition.mp3';

  /// Initialize and pre-cache sounds
  static Future<void> init() async {
    if (kIsWeb) {
      // Pre-caching is handled differently on web, but we can warm up the player
      _player.setSource(AssetSource(hoverSfx));
    }
  }

  static void toggleMute() {
    isMuted = !isMuted;
  }

  static Future<void> playHover() async {
    if (isMuted) return;
    try {
      await _player.stop();
      await _player.play(AssetSource(hoverSfx), volume: 0.3);
    } catch (e) {
      debugPrint('Audio Error: $e');
    }
  }

  static Future<void> playClick() async {
    if (isMuted) return;
    try {
      final clickPlayer = AudioPlayer(); // Use temporary player for overlapping sounds
      await clickPlayer.play(AssetSource(clickSfx), volume: 0.6);
    } catch (e) {
      debugPrint('Audio Error: $e');
    }
  }

  static Future<void> playTransition() async {
    if (isMuted) return;
    try {
      final transPlayer = AudioPlayer();
      await transPlayer.play(AssetSource(transitionSfx), volume: 0.4);
    } catch (e) {
      debugPrint('Audio Error: $e');
    }
  }
}
