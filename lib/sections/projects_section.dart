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
import '../layout/responsive.dart';
import 'section_container.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VisibilityAnimator(child: _buildHeader(context)),
          const SizedBox(height: 80),
          VisibilityAnimator(delay: 200.ms, child: _buildAppGrid(context)),
          const SizedBox(height: 120),
          VisibilityAnimator(child: _buildProjectSubHeader(context)),
          const SizedBox(height: 64),
          VisibilityAnimator(delay: 200.ms, child: _buildPackagesGrid(context)),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    return Column(
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
            ).textTheme.displayLarge?.copyWith(
                  fontSize: isMobile ? 48 : 80,
                ),
            children: [
              const TextSpan(text: 'PROJECTS\n'),
              const TextSpan(
                text: '& OPEN_SOURCE',
                style: TextStyle(color: AppTheme.orangeAccent),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Text(
            'A curated selection of architecture solutions, digital products, and production-grade tools built with technical precision.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ],
    );
  }

  Widget _buildProjectSubHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'OPEN SOURCE ECOSYSTEM'),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Text(
            'Extending the Flutter & Dart capabilities with modular, high-performance packages used by developers worldwide.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ],
    );
  }

  Widget _buildAppGrid(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    if (isMobile) {
      return Column(
        children: const [
          _AppCard(title: 'Banking App', desc: '', isLarge: true),
          SizedBox(height: 24),
          _AppCard(
            title: 'Nigam Lahari',
            desc:
                'High-performance audio streaming platform with low-latency playback buffers.',
            isLarge: true,
          ),
          SizedBox(height: 24),
          _AppCard(
            title: 'TNS Health',
            desc:
                'Integrated patient management system for clinical synchronization.',
          ),
          SizedBox(height: 24),
          _AppCard(
            title: 'Habbit Tracker',
            desc:
                'Algorithmic progress tracking for gamified habit-feedback loops.',
          ),
          SizedBox(height: 24),
          _AppCard(
            title: 'NSS Puri',
            desc:
                'Community mobilization platform for volunteer coordination.',
          ),
        ],
      );
    }
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
    int crossAxisCount = 3;
    double aspectRatio = 1.6;
    
    if (Responsive.isMobile(context)) {
      crossAxisCount = 1;
      aspectRatio = 1.8;
    } else if (Responsive.isTablet(context)) {
      crossAxisCount = 2;
      aspectRatio = 1.4;
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
        childAspectRatio: aspectRatio,
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
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _isHovering ? AppTheme.magentaAccent : Colors.transparent,
            ),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                AppTheme.surfaceHighlight,
                _isHovering 
                  ? AppTheme.deepIndigo.withValues(alpha: 0.3)
                  : AppTheme.surfaceHighlight,
              ],
            ),
            boxShadow: _isHovering
                ? [
                    BoxShadow(
                      color: AppTheme.magentaAccent.withValues(alpha: 0.2),
                      blurRadius: 40,
                      spreadRadius: -10,
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
                        ? AppTheme.magentaAccent
                        : AppTheme.textPrimary,
                    fontWeight: FontWeight.w900,
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
                        ? AppTheme.magentaAccent
                        : AppTheme.textPrimary,
                    fontWeight: FontWeight.w900,
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
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _isHovering ? AppTheme.orangeAccent : AppTheme.borderSide,
            ),
            gradient: LinearGradient(
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
              colors: [
                AppTheme.surfaceHighlight,
                _isHovering 
                  ? AppTheme.deepIndigo.withValues(alpha: 0.2)
                  : AppTheme.surfaceHighlight,
              ],
            ),
            boxShadow: _isHovering
                ? [
                    BoxShadow(
                      color: AppTheme.orangeAccent.withValues(alpha: 0.15),
                      blurRadius: 20,
                      spreadRadius: 0,
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
                    Icons.inventory_2_outlined,
                    color: _isHovering ? Colors.white : AppTheme.orangeAccent,
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
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: _isHovering ? AppTheme.orangeAccent : AppTheme.textPrimary,
                  fontWeight: FontWeight.w900,
                ),
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
                        color: AppTheme.orangeAccent,
                        fontWeight: FontWeight.bold,
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
