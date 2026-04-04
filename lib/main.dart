import 'dart:math';
import 'package:flutter/material.dart';
import 'core/theme.dart';
import 'widgets/kinetic_nav_bar.dart';
import 'widgets/tech_background.dart';
import 'sections/hero_section.dart';
import 'sections/about_section.dart';
import 'sections/experience_section.dart';
import 'sections/projects_section.dart';
import 'sections/footer.dart';
import 'widgets/crt_overlay.dart';
import 'core/audio_manager.dart';
import 'core/game_state_manager.dart';
import 'widgets/game_hud.dart';
import 'widgets/floating_xp.dart';
// import 'layout/responsive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AudioManager.init();
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Atanu Sabyasachi Jena • Portfolio',
      theme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: const MainLayout(),
    );
  }
}

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<Offset> _mousePosition = ValueNotifier(Offset.zero);
  final GameStateManager _gameState = GameStateManager();

  final List<GlobalKey> _sectionKeys = [
    GlobalKey(), // Home
    GlobalKey(), // About
    GlobalKey(), // Experience
    GlobalKey(), // Projects
    GlobalKey(), // Contact (Footer)
  ];
  
  int _activeIndex = 0;
  int _lastNotificationIndex = 0;
  double _lastMaxScroll = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _mousePosition.dispose();
    super.dispose();
  }

  void _onScroll() {
    double scrollPos = _scrollController.offset;
    int index = (scrollPos / 900).floor().clamp(0, 4);
    
    // XP reward for exploration
    if (scrollPos > _lastMaxScroll) {
      _lastMaxScroll = scrollPos;
      _gameState.addXp(1); 
    }

    if (index != _lastNotificationIndex) {
      _lastNotificationIndex = index;
      AudioManager.playNotification();
      
      // Quest status update
      final quests = ['HOME_SECTOR', 'THE_ARCHITECTURAL_SCOUT', 'EXP_LEVEL', 'DEPLOYMENT_LOG', 'CONTACT_GATEWAY'];
      _gameState.updateQuest(quests[index]);
      
      // Section discovery XP
      _gameState.addXp(100);
    }
  }

  void _scrollTo(int index) {
    if (_activeIndex != index) {
      AudioManager.playTransition();
    }
    setState(() => _activeIndex = index);
    if (_sectionKeys[index].currentContext != null) {
      Scrollable.ensureVisible(
        _sectionKeys[index].currentContext!,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GameProvider(
      state: _gameState,
      child: ListenableBuilder(
        listenable: _gameState,
        builder: (context, _) {
        return CrtOverlay(
          child: FloatingXpLayer(
            child: Scaffold(
              backgroundColor: AppTheme.background,
              body: MouseRegion(
                onHover: (event) => _mousePosition.value = event.localPosition,
                onExit: (event) => _mousePosition.value = Offset.zero,
                child: GestureDetector(
                  onTapDown: (details) {
                    // Random small XP on background click
                    if (Random().nextDouble() > 0.7) {
                      _gameState.addXp(10);
                      FloatingXpLayer.of(context)?.showXp(details.localPosition, 10);
                    }
                  },
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: TechBackground(mousePositionNotifier: _mousePosition),
                      ),
                      Column(
                        children: [
                          KineticNavBar(
                            activeIndex: _activeIndex,
                            onNavigate: _scrollTo,
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              controller: _scrollController,
                              child: Column(
                                children: [
                                  HeroSection(key: _sectionKeys[0]),
                                  const SizedBox(height: 120),
                                  AboutSection(key: _sectionKeys[1]),
                                  const SizedBox(height: 120),
                                  ExperienceSection(key: _sectionKeys[2]),
                                  const SizedBox(height: 120),
                                  ProjectsSection(key: _sectionKeys[3]),
                                  const SizedBox(height: 120),
                                  Footer(key: _sectionKeys[4]),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      GameHud(state: _gameState),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    ),
  );
}
}
