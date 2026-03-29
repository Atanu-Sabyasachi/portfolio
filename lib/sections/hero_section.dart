import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/theme.dart';
import '../widgets/custom_button.dart';
import '../core/constants.dart';
import '../layout/responsive.dart';
import '../core/audio_manager.dart';
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
                _buildTerminalSnippet(context)
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
                Expanded(
                  flex: 6,
                  child: _buildHeroContent(context),
                ),
                Expanded(
                  flex: 4,
                  child: _buildTerminalSnippet(context)
                      .animate()
                      .fadeIn(delay: 1000.ms)
                      .slideX(begin: 0.1, duration: 600.ms),
                ),
              ],
            ),
          const SizedBox(height: 80),
          if (Responsive.isMobile(context))
            Column(
              children: [
                _StatCard(
                  title: 'System Architecture',
                  desc:
                      'Building scalable apps using BLoC, Provider, and Clean Architecture principles.',
                ).animate(delay: 1200.ms).fadeIn().slideY(begin: 0.2),
                const SizedBox(height: 16),
                _StatSummaryCard(
                  value: '04+',
                  label: 'YEARS OF EXPERIENCE',
                ).animate(delay: 1400.ms).fadeIn().slideY(begin: 0.2),
                const SizedBox(height: 16),
                _StatSummaryCard(
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
                    child: _StatCard(
                      title: 'System Architecture',
                      desc:
                          'Building scalable apps using BLoC, Provider, and Clean Architecture principles.',
                    ).animate(delay: 1200.ms).fadeIn().slideY(begin: 0.2),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    flex: 2,
                    child: _StatSummaryCard(
                      value: '04+',
                      label: 'YEARS OF EXPERIENCE',
                    ).animate(delay: 1400.ms).fadeIn().slideY(begin: 0.2),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    flex: 2,
                    child: _StatSummaryCard(
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
            )
            .animate()
            .fadeIn(delay: 200.ms)
            .slideX(begin: -0.1, duration: 400.ms),
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
            )
            .animate()
            .fadeIn(delay: 400.ms)
            .slideY(begin: 0.1, duration: 600.ms),
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

  Widget _buildTerminalSnippet(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.borderSide),
        boxShadow: [
          BoxShadow(
            color: AppTheme.cyanAccent.withValues(alpha: 0.05),
            blurRadius: 30,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 16),
              const Icon(Icons.circle, size: 12, color: Colors.red),
              const SizedBox(width: 8),
              const Icon(Icons.circle, size: 12, color: Colors.orange),
              const SizedBox(width: 8),
              const Icon(Icons.circle, size: 12, color: Colors.green),
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      'MAIN.DART',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Divider(color: AppTheme.borderSide, height: 1),
          Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  '''01 import 'package:flutter/material.dart';\n02 \n03 void main() {\n04   const me = FlutterDeveloper(\n05     name: "Atanu Sabyasachi Jena",\n06     exp: "4+ years",\n07     focus: ["Performance", "UI/UX"]\n08   );\n09   runApp(me.buildPortfolio());\n10 }\n11 |''',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    height: 1.8,
                    color: AppTheme.textSecondary,
                  ),
                ),
              )
              .animate(onPlay: (controller) => controller.repeat(reverse: true))
              .shimmer(
                duration: 4000.ms,
                color: AppTheme.cyanAccent.withValues(alpha: 0.2),
              ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String desc;
  const _StatCard({required this.title, required this.desc});
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => AudioManager.playCardHover(),
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: AppTheme.surfaceHighlight,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.headlineMedium),
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
    return MouseRegion(
      onEnter: (_) => AudioManager.playCardHover(),
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: AppTheme.surfaceHighlight,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: Theme.of(
                context,
              ).textTheme.displayMedium?.copyWith(color: AppTheme.cyanAccent),
            ),
            const SizedBox(height: 8),
            Text(label, style: Theme.of(context).textTheme.labelSmall),
          ],
        ),
      ),
    );
  }
}
