import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/theme.dart';
import '../core/constants.dart';
import '../core/audio_manager.dart';
import '../widgets/section_title.dart';
import '../core/visibility_animator.dart';
import '../widgets/glitch_text.dart';
import 'section_container.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VisibilityAnimator(child: _buildHeader(context)),
          const SizedBox(height: 64),
          VisibilityAnimator(
            delay: 200.ms,
            child: _buildExperienceLog(context),
          ),
          const SizedBox(height: 80),
          VisibilityAnimator(delay: 200.ms, child: _buildCoreModules(context)),
          const SizedBox(height: 80),
          VisibilityAnimator(delay: 200.ms, child: _buildSoftSystems(context)),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'IDENTITY_VERIFICATION: PASSED',
          style: Theme.of(
            context,
          ).textTheme.labelSmall?.copyWith(color: AppTheme.textMuted),
        ),
        const SizedBox(height: 16),
        GlitchText(
          text: 'ATANU SABYASACHI JENA',
          style: Theme.of(
            context,
          ).textTheme.displayLarge?.copyWith(fontSize: 80),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: 600,
          child: Text(
            AppConstants.myLongDescription,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ],
    );
  }

  Widget _buildExperienceLog(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(48),
      decoration: BoxDecoration(
        color: AppTheme.surfaceHighlight,
        borderRadius: BorderRadius.circular(8),
        border: Border(left: BorderSide(color: AppTheme.cyanAccent, width: 4)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'EXPERIENCE_LOG',
                  style: Theme.of(
                    context,
                  ).textTheme.labelSmall?.copyWith(color: AppTheme.cyanAccent),
                ),
                const SizedBox(height: 16),
                Text(
                  '4+ YEARS OF FLUTTER EXCELLENCE',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Specializing in multi-platform deployment and state management at scale. Delivering production-grade applications with pixel-perfect precision.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 24),
                Row(
                  children: const [
                    _Tag('PRODUCTION READY'),
                    SizedBox(width: 16),
                    _Tag('NATIVE BRIDGE'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 48),
          Text(
                '04',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: 140,
                  color: AppTheme.surfaceHighlight.withValues(alpha: 0.5),
                  shadows: [
                    Shadow(
                      offset: Offset(4, 4),
                      blurRadius: 10,
                      color: Colors.black.withValues(alpha: 0.5),
                    ),
                  ],
                ),
              )
              .animate(onPlay: (controller) => controller.repeat(reverse: true))
              .scaleXY(
                begin: 1.0,
                end: 1.05,
                duration: 2000.ms,
                curve: Curves.easeInOutSine,
              ),
        ],
      ),
    );
  }

  Widget _buildCoreModules(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'CORE_MODULES'),
        Row(
          children: const [
            Expanded(
              child: _ProgressCard(
                title: 'FLUTTER & DART',
                value: 95,
                color: AppTheme.cyanAccent,
              ),
            ),
            SizedBox(width: 24),
            Expanded(
              child: _ProgressCard(
                title: 'BLoC & MobX',
                value: 90,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(width: 24),
            Expanded(
              child: _ProgressCard(
                title: 'CLEAN & SOLID',
                value: 88,
                color: AppTheme.successGreen,
              ),
            ),
            SizedBox(width: 24),
            Expanded(
              child: _ProgressCard(
                title: 'FIREBASE & REST',
                value: 92,
                color: Colors.redAccent,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSoftSystems(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'SOFT_SYSTEMS'),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: const [
                  _SoftSkillRow(
                    icon: Icons.psychology,
                    title: 'PROBLEM SOLVING',
                    desc:
                        'Deconstructing complex bottlenecks into modular maintainable logic solutions.',
                  ),
                  SizedBox(height: 32),
                  _SoftSkillRow(
                    icon: Icons.groups,
                    title: 'TEAM COLLABORATION',
                    desc:
                        'Synchronizing with cross-functional teams using Agile and Git-flow protocols.',
                  ),
                  SizedBox(height: 32),
                  _SoftSkillRow(
                    icon: Icons.trending_up,
                    title: 'ADAPTIVE LEARNING',
                    desc:
                        'Continuous integration of emerging mobile technologies and design paradigms.',
                  ),
                ],
              ),
            ),
            const SizedBox(width: 64),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(40),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceHighlight,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                          Icons.check_circle,
                          color: AppTheme.cyanAccent,
                          size: 48,
                        )
                        .animate(onPlay: (controller) => controller.repeat())
                        .shimmer(duration: 2000.ms),
                    const SizedBox(height: 24),
                    Text(
                      'READY FOR DEPLOYMENT',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Currently accepting high-impact projects and engineering challenges.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 32),
                    MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () =>
                                launchUrl(Uri.parse(AppConstants.linkedinUrl)),
                            child: Container(
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: AppTheme.cyanAccent,
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: Center(
                                child: Text(
                                  'INITIATE_CONTACT',
                                  style: Theme.of(context).textTheme.labelMedium
                                      ?.copyWith(
                                        color: AppTheme.background,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        )
                        .animate(
                          onPlay: (controller) =>
                              controller.repeat(reverse: true),
                        )
                        .tint(color: Colors.white24, duration: 1500.ms),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _Tag extends StatelessWidget {
  final String text;
  const _Tag(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: AppTheme.borderSide),
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
          ),
          const SizedBox(width: 8),
          Text(text, style: Theme.of(context).textTheme.labelSmall),
        ],
      ),
    );
  }
}

class _ProgressCard extends StatefulWidget {
  final String title;
  final int value;
  final Color color;

  const _ProgressCard({
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  State<_ProgressCard> createState() => _ProgressCardState();
}

class _ProgressCardState extends State<_ProgressCard> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovering = true);
        AudioManager.playCardHover();
      },
      onExit: (_) => setState(() => _isHovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.translationValues(0, _isHovering ? -10 : 0, 0),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppTheme.surfaceHighlight,
          borderRadius: BorderRadius.circular(8),
          boxShadow: _isHovering
              ? [
                  BoxShadow(
                    color: widget.color.withValues(alpha: 0.2),
                    blurRadius: 20,
                    spreadRadius: -5,
                  ),
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.code, size: 24, color: AppTheme.textSecondary),
                Text('v3.19.x', style: Theme.of(context).textTheme.labelSmall),
              ],
            ),
            const SizedBox(height: 24),
            Text(widget.title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 32),
            Container(
              height: 4,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppTheme.surface,
                borderRadius: BorderRadius.circular(2),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: widget.value / 100,
                child: Container(
                  decoration: BoxDecoration(
                    color: widget.color,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ).animate().slideX(
              begin: -1.0,
              end: 0,
              duration: 1000.ms,
              curve: Curves.easeOutCirc,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'OPTIMIZATION',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                Text(
                  '${widget.value}%',
                  style: Theme.of(
                    context,
                  ).textTheme.labelSmall?.copyWith(color: widget.color),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SoftSkillRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String desc;

  const _SoftSkillRow({
    required this.icon,
    required this.title,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => AudioManager.playCardHover(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.surfaceHighlight,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppTheme.cyanAccent),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                Text(desc, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
