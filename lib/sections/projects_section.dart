import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/theme.dart';
import '../core/constants.dart';
import '../core/audio_manager.dart';
import '../widgets/section_title.dart';
import '../data/portfolio_data.dart';
import '../models/project_item.dart';
import '../core/visibility_animator.dart';
import 'section_container.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VisibilityAnimator(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'DIRECTORY / OPEN_SOURCE_PROJECTS',
                  style: Theme.of(
                    context,
                  ).textTheme.labelSmall?.copyWith(color: AppTheme.textMuted),
                ),
                const SizedBox(height: 16),
                RichText(
                  text: TextSpan(
                    style: Theme.of(
                      context,
                    ).textTheme.displayLarge?.copyWith(fontSize: 80),
                    children: [
                      const TextSpan(text: 'PROJECTS\n'),
                      TextSpan(
                        text: '& OPEN_SOURCE',
                        style: TextStyle(color: AppTheme.textPrimary),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: 600,
                  child: Text(
                    'A curated selection of architecture solutions, digital products, and production-grade tools built with technical precision.',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 80),

          VisibilityAnimator(delay: 200.ms, child: _buildAppGrid(context)),

          const SizedBox(height: 120),

          VisibilityAnimator(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle(title: 'OPEN SOURCE ECOSYSTEM'),
                SizedBox(
                  width: 600,
                  child: Text(
                    'Extending the Flutter & Dart capabilities with modular, high-performance packages used by developers worldwide.',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 64),

          VisibilityAnimator(delay: 200.ms, child: _buildPackagesGrid(context)),
        ],
      ),
    );
  }

  Widget _buildAppGrid(BuildContext context) {
    return Column(
      children: [
        Row(
          children: const [
            Expanded(
              flex: 2,
              child: _AppCard(title: 'Banking App', desc: '', isLarge: true),
            ),
            SizedBox(width: 24),
            Expanded(
              flex: 1,
              child: _AppCard(
                title: 'Nigam Lahari',
                desc:
                    'High-performance audio streaming platform with low-latency playback buffers.',
                isLarge: true,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: const [
            Expanded(
              child: _AppCard(
                title: 'TNS Health',
                desc:
                    'Integrated patient management system for clinical synchronization.',
              ),
            ),
            SizedBox(width: 24),
            Expanded(
              child: _AppCard(
                title: 'Habbit Tracker',
                desc:
                    'Algorithmic progress tracking for gamified habit-feedback loops.',
              ),
            ),
            SizedBox(width: 24),
            Expanded(
              child: _AppCard(
                title: 'NSS Puri',
                desc:
                    'Community mobilization platform for volunteer coordination.',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPackagesGrid(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
        childAspectRatio: 1.6,
      ),
      itemCount: PortfolioData.openSourcePackages.length,
      itemBuilder: (context, index) {
        final pkg = PortfolioData.openSourcePackages[index];
        return _PackageCard(pkg: pkg)
            .animate()
            .fade(
              delay: Duration(milliseconds: 100 * index),
              duration: 500.ms,
            )
            .scaleXY(begin: 0.9, duration: 500.ms, curve: Curves.easeOutBack);
      },
    );
  }
}

class _AppCard extends StatefulWidget {
  final String title;
  final String desc;
  final bool isLarge;

  const _AppCard({
    required this.title,
    required this.desc,
    this.isLarge = false,
  });

  @override
  State<_AppCard> createState() => _AppCardState();
}

class _AppCardState extends State<_AppCard> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        setState(() => _isHovering = true);
        AudioManager.playCardHover();
      },
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTap: () => launchUrl(Uri.parse(AppConstants.githubUrl)),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          transform: Matrix4.translationValues(0, _isHovering ? -10 : 0, 0),
          height: widget.isLarge ? 400 : 250,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: AppTheme.surfaceHighlight,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _isHovering ? AppTheme.cyanAccent : Colors.transparent,
            ),
            boxShadow: _isHovering
                ? [
                    BoxShadow(
                      color: AppTheme.cyanAccent.withValues(alpha: 0.15),
                      blurRadius: 30,
                      spreadRadius: 0,
                    ),
                  ]
                : [],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.desc.isNotEmpty) ...[
                Text(
                  widget.title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: _isHovering
                        ? AppTheme.cyanAccent
                        : AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  widget.desc,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ] else ...[
                const Spacer(),
                Text(
                  widget.title,
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: _isHovering
                        ? AppTheme.cyanAccent
                        : AppTheme.textPrimary,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _PackageCard extends StatefulWidget {
  final ProjectItem pkg;

  const _PackageCard({required this.pkg});

  @override
  State<_PackageCard> createState() => _PackageCardState();
}

class _PackageCardState extends State<_PackageCard> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        setState(() => _isHovering = true);
        AudioManager.playCardHover();
      },
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTap: () => launchUrl(
          Uri.parse('https://pub.dev/packages/${widget.pkg.title}'),
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.translationValues(0, _isHovering ? -5 : 0, 0),
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: AppTheme.surfaceHighlight,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _isHovering ? AppTheme.cyanAccent : AppTheme.borderSide,
            ),
            boxShadow: _isHovering
                ? [
                    BoxShadow(
                      color: AppTheme.cyanAccent.withValues(alpha: 0.1),
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
                  Icon(
                    Icons.archive,
                    color: _isHovering ? Colors.white : AppTheme.cyanAccent,
                  ),
                  Text(
                    'PACKAGE',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                widget.pkg.title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              Text(
                widget.pkg.description,
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.surface,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '>',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppTheme.cyanAccent,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      widget.pkg.actionCommand ?? '',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
