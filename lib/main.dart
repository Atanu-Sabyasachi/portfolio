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

void main() {
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

  final List<GlobalKey> _sectionKeys = [
    GlobalKey(), // Home
    GlobalKey(), // About
    GlobalKey(), // Experience
    GlobalKey(), // Projects
    GlobalKey(), // Contact (Footer)
  ];
  
  int _activeIndex = 0;

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
    // This is optional logic to highlight active section based on scroll offset.
    // For pure smooth scrolling, we just let it run.
  }

  void _scrollTo(int index) {
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
    return CrtOverlay(
      child: Scaffold(
        backgroundColor: AppTheme.background,
        body: MouseRegion(
          onHover: (event) => _mousePosition.value = event.localPosition,
          onExit: (event) => _mousePosition.value = Offset.zero,
          child: Stack(
            children: [
              // Z-Index 0: Background Layer
              Positioned.fill(
                child: TechBackground(mousePositionNotifier: _mousePosition),
              ),
              
              // Z-Index 1: Content Layer
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
        ],
      ),
    )));
  }
}
