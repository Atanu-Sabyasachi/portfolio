import 'package:flutter/material.dart';
import 'audio_manager.dart';

class GameStateManager extends ChangeNotifier {
  int _xp = 0;
  int _level = 1;
  String _activeQuest = 'INITIALIZING SYSTEM...';
  final Set<String> _achievements = {};
  final List<double> _xpHistory = List.filled(30, 0.0);

  int get xp => _xp;
  int get level => _level;
  String get activeQuest => _activeQuest;
  Set<String> get achievements => _achievements;
  List<double> get xpHistory => _xpHistory;

  int get xpForNextLevel => _level * 1000;
  double get xpProgress => _xp / xpForNextLevel;

  void addXp(int amount) {
    _xp += amount;
    _xpHistory.removeAt(0);
    _xpHistory.add(_xp / xpForNextLevel);
    
    if (_xp >= xpForNextLevel) {
      _levelUp();
    }
    notifyListeners();
  }

  void _levelUp() {
    _xp -= xpForNextLevel;
    _level++;
    AudioManager.playNotification();
  }

  void updateQuest(String quest) {
    if (_activeQuest != quest) {
      _activeQuest = quest;
      notifyListeners();
    }
  }

  void unlockAchievement(String title) {
    if (!_achievements.contains(title)) {
      _achievements.add(title);
      addXp(500); 
      AudioManager.playNotification();
      notifyListeners();
    }
  }
}

class GameProvider extends InheritedWidget {
  final GameStateManager state;
  const GameProvider({super.key, required this.state, required super.child});

  static GameStateManager of(BuildContext context) {
    final GameProvider? result = context.dependOnInheritedWidgetOfExactType<GameProvider>();
    return result!.state;
  }

  @override
  bool updateShouldNotify(GameProvider oldWidget) => state != oldWidget.state;
}
