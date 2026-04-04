import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/theme.dart';
import '../widgets/custom_button.dart';
import '../core/constants.dart';
import '../layout/responsive.dart';
import '../core/audio_manager.dart';
import '../core/file_helper.dart';
import '../core/game_state_manager.dart';
import '../widgets/code_highlighter.dart';
import '../widgets/floating_xp.dart';
import 'section_container.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (Responsive.isMobile(context))
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeroContent(context),
                const SizedBox(height: 48),
                const _InteractiveCodeBlock()
                    .animate()
                    .fadeIn(delay: 1000.ms)
                    .slideY(begin: 0.1, duration: 600.ms),
              ],
            )
          else
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 6, child: _buildHeroContent(context)),
                const Expanded(flex: 4, child: _InteractiveCodeBlock())
                    .animate()
                    .fadeIn(delay: 1000.ms)
                    .slideX(begin: 0.1, duration: 600.ms),
              ],
            ),
          const SizedBox(height: 80),
          if (Responsive.isMobile(context))
            Column(
              children: [
                const _StatCard(
                  title: 'System Architecture',
                  desc:
                      'Building scalable apps using BLoC, Provider, and Clean Architecture principles.',
                ).animate(delay: 1200.ms).fadeIn().slideY(begin: 0.2),
                const SizedBox(height: 16),
                const _StatSummaryCard(
                  value: '04+',
                  label: 'YEARS OF EXPERIENCE',
                ).animate(delay: 1400.ms).fadeIn().slideY(begin: 0.2),
                const SizedBox(height: 16),
                const _StatSummaryCard(
                  value: '25+',
                  label: 'APPS DEPLOYED',
                ).animate(delay: 1600.ms).fadeIn().slideY(begin: 0.2),
              ],
            )
          else
            IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: const _StatCard(
                      title: 'System Architecture',
                      desc:
                          'Building scalable apps using BLoC, Provider, and Clean Architecture principles.',
                    ).animate(delay: 1200.ms).fadeIn().slideY(begin: 0.2),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    flex: 2,
                    child: const _StatSummaryCard(
                      value: '04+',
                      label: 'YEARS OF EXPERIENCE',
                    ).animate(delay: 1400.ms).fadeIn().slideY(begin: 0.2),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    flex: 2,
                    child: const _StatSummaryCard(
                      value: '25+',
                      label: 'APPS DEPLOYED',
                    ).animate(delay: 1600.ms).fadeIn().slideY(begin: 0.2),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildHeroContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppTheme.surfaceHighlight,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppTheme.cyanAccent,
                      shape: BoxShape.circle,
                    ),
                  )
                  .animate(onPlay: (controller) => controller.repeat())
                  .shimmer(duration: 2000.ms, color: Colors.white)
                  .fadeIn(duration: 500.ms),
              const SizedBox(width: 8),
              Text(
                'AVAILABLE FOR NEW PROJECTS',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          ),
        ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.1, duration: 400.ms),
        const SizedBox(height: 32),
        RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
              fontSize: Responsive.isMobile(context) ? 48 : 96,
              height: 1.1,
            ),
            children: const [
              TextSpan(text: 'CRAFTING '),
              TextSpan(
                text: 'FLUID\n',
                style: TextStyle(
                  color: AppTheme.cyanAccent,
                  fontStyle: FontStyle.italic,
                ),
              ),
              TextSpan(text: 'EXPERIENCES.'),
            ],
          ),
        ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1, duration: 600.ms),
        const SizedBox(height: 32),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Text(
            AppConstants.myShortDescription,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ).animate(delay: 600.ms).fadeIn(),
        const SizedBox(height: 48),
        Wrap(
          spacing: 24,
          runSpacing: 16,
          children: [
            CustomButton(
              text: 'VIEW PROJECTS',
              icon: Icons.arrow_forward_rounded,
              onPressed: () => launchUrl(Uri.parse(AppConstants.githubUrl)),
            ).animate(delay: 800.ms).fadeIn().slideX(begin: -0.1),
            CustomButton(
              text: 'HIRE ME',
              isOutlined: true,
              onPressed: () => launchUrl(Uri.parse(AppConstants.linkedinUrl)),
            ).animate(delay: 1000.ms).fadeIn().slideX(begin: -0.1),
          ],
        ),
      ],
    );
  }
}

class _InteractiveCodeBlock extends StatefulWidget {
  const _InteractiveCodeBlock();

  @override
  State<_InteractiveCodeBlock> createState() => _InteractiveCodeBlockState();
}

class _InteractiveCodeBlockState extends State<_InteractiveCodeBlock> {
  double _rotateX = 0;
  double _rotateY = 0;
  double _scale = 1.0;
  double _offsetY = 0;
  int _tapCount = 0;

  void _onTapDown(TapDownDetails details, Size size) {
    // Safety check: Avoid NaN or Infinity in matrix calculations
    if (size.width <= 0 ||
        size.height <= 0 ||
        size.width.isInfinite ||
        size.height.isInfinite)
      return;

    AudioManager.playClick();
    
    // XP & Achievement logic
    _tapCount++;
    final state = GameProvider.of(context);
    state.addXp(50);
    FloatingXpLayer.of(context)?.showXp(details.globalPosition, 50);
    
    if (_tapCount >= 5) {
      state.unlockAchievement('DEBUG MASTER');
    }

    final xPos = details.localPosition.dx;
    final yPos = details.localPosition.dy;

    final middleX = size.width / 2;
    final middleY = size.height / 2;

    setState(() {
      _rotateX = ((yPos - middleY) / size.height).clamp(-0.5, 0.5) * 0.4;
      _rotateY = ((middleX - xPos) / size.width).clamp(-0.5, 0.5) * 0.4;
      _scale = 0.92; // Compression
      _offsetY = 15; // Dip
    });
  }

  void _onTapUp(TapUpDetails _) {
    FileHelper.downloadResume(AppConstants.resumeUrl);
    GameProvider.of(context).unlockAchievement('RESUME RUNNER');
    
    setState(() {
      _rotateX = 0;
      _rotateY = 0;
      _scale = 1.15; // Higher jump
      _offsetY = -30; // Upward displacement
    });

    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) {
        setState(() {
          _scale = 1.0;
          _offsetY = 0;
        });
      }
    });
  }

  void _onTapCancel() {
    setState(() {
      _rotateX = 0;
      _rotateY = 0;
      _scale = 1.0;
      _offsetY = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Use bounded constraints only to avoid NaN
        final width = constraints.hasBoundedWidth
            ? constraints.maxWidth
            : MediaQuery.of(context).size.width * 0.4;
        final height = constraints.hasBoundedHeight
            ? constraints.maxHeight
            : 400.0;
        final size = Size(width, height);

        return GestureDetector(
          onTapDown: (details) => _onTapDown(details, size),
          onTapUp: _onTapUp,
          onTapCancel: _onTapCancel,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 800),
            curve: Curves.elasticOut,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateX(_rotateX)
              ..rotateY(_rotateY)
              ..scale(_scale)
              ..translate(0.0, _offsetY, 0.0),
            child: _buildCodeCard(context),
          ),
        );
      },
    );
  }

  Widget _buildCodeCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderSide),
        boxShadow: [
          BoxShadow(
            color: AppTheme.cyanAccent.withValues(alpha: 0.15),
            blurRadius: 40,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
          _buildTerminalHeader(context),
          const Divider(color: AppTheme.borderSide, height: 1),
          Padding(
                padding: const EdgeInsets.all(24.0),
                child: CodeHighlighter(
                  code: '''class AtanuSabyasachi extends StatelessWidget {
  final String name = 'Atanu Sabyasachi Jena';
  final String experience = '4+ Years';

  @override
  Widget build(context) => DeveloperProfile(
    role: 'Senior Flutter Developer',
    focus: ['Architecture', 'Performance'],
    onTap: () => DownloadResume(),
    child: HeroAnimation(
       tag: 'portfolio_core',
       child: MainApp(),
    ),
  );
}''',
                ),
              )
              .animate(onPlay: (controller) => controller.repeat(reverse: true))
              .shimmer(
                duration: 8000.ms,
                color: AppTheme.magentaAccent.withValues(alpha: 0.1),
              ),
        ],
      ),
    );
  }

  Widget _buildTerminalHeader(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 16),
        const Icon(Icons.circle, size: 10, color: Colors.red),
        const SizedBox(width: 8),
        const Icon(Icons.circle, size: 10, color: Colors.orange),
        const SizedBox(width: 8),
        const Icon(Icons.circle, size: 10, color: Colors.green),
        Expanded(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                'MAIN.DART',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppTheme.textSecondary,
                  letterSpacing: 2,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String desc;
  const _StatCard({required this.title, required this.desc});
  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    return MouseRegion(
      onEnter: (_) => AudioManager.playCardHover(),
      child: Container(
        padding: EdgeInsets.all(isMobile ? 24 : 32),
        decoration: BoxDecoration(
          color: AppTheme.surfaceHighlight,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontSize: isMobile ? 20 : 24,
              ),
            ),
            const SizedBox(height: 12),
            Text(desc, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}

class _StatSummaryCard extends StatelessWidget {
  final String value;
  final String label;
  const _StatSummaryCard({required this.value, required this.label});
  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    return MouseRegion(
      onEnter: (_) => AudioManager.playCardHover(),
      child: Container(
        padding: EdgeInsets.all(isMobile ? 24 : 32),
        decoration: BoxDecoration(
          color: AppTheme.surfaceHighlight,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: AppTheme.cyanAccent,
                fontSize: isMobile ? 32 : 45,
              ),
            ),
            const SizedBox(height: 8),
            Text(label, style: Theme.of(context).textTheme.labelSmall),
          ],
        ),
      ),
    );
  }
}
