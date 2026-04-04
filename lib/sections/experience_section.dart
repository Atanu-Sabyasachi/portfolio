import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/theme.dart';
import '../core/audio_manager.dart';
import '../data/portfolio_data.dart';
import '../models/experience_item.dart';
import '../core/visibility_animator.dart';
import '../layout/responsive.dart';
import '../core/game_state_manager.dart';
import 'section_container.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VisibilityAnimator(
            child: Builder(
              builder: (context) {
                // Trigger achievement on reveal
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  GameProvider.of(context).unlockAchievement('THE ARCHITECTURAL SCOUT');
                });
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SYSTEM_LOG / PROFESSIONAL_PATH',
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
                              fontSize: Responsive.isMobile(context) ? 48 : 80,
                            ),
                        children: [
                          const TextSpan(text: 'ENGINEERING\n'),
                          TextSpan(
                            text: 'EXPERIENCES',
                            style: TextStyle(
                              color: AppTheme.magentaAccent.withValues(alpha: 0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    Text(
                          'SYS_EVAL_01 // 2021...2024...',
                          style: Theme.of(context).textTheme.labelSmall,
                        )
                        .animate(
                          onPlay: (controller) => controller.repeat(reverse: true),
                        )
                        .shimmer(duration: 1500.ms, color: AppTheme.cyanAccent),
                  ],
                );
              }
            ),
          ),
          const SizedBox(height: 80),

          Stack(
            children: [
              if (!Responsive.isMobile(context))
                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: Container(
                      width: 2,
                      color: AppTheme.borderSide,
                    ),
                  ),
                ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: PortfolioData.experiences.length,
                itemBuilder: (context, index) {
                  final exp = PortfolioData.experiences[index];
                  return VisibilityAnimator(
                    delay: Duration(milliseconds: 150 * index),
                    child: _ExperienceRow(item: exp, isLeft: index % 2 == 0),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ExperienceRow extends StatefulWidget {
  final ExperienceItem item;
  final bool isLeft;

  const _ExperienceRow({required this.item, required this.isLeft});

  @override
  State<_ExperienceRow> createState() => _ExperienceRowState();
}

class _ExperienceRowState extends State<_ExperienceRow> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    return Padding(
      padding: EdgeInsets.only(bottom: isMobile ? 40.0 : 80.0),
      child: Row(
        mainAxisAlignment: isMobile
            ? MainAxisAlignment.start
            : (widget.isLeft ? MainAxisAlignment.start : MainAxisAlignment.end),
        children: [
          if (!widget.isLeft && !isMobile) const Spacer(),
          Expanded(
            flex: isMobile ? 1 : 2,
            child: MouseRegion(
              onEnter: (_) {
                setState(() => _isHovering = true);
                AudioManager.playCardHover();
              },
              onExit: (_) => setState(() => _isHovering = false),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                transform: Matrix4.translationValues(
                  !isMobile && _isHovering && widget.isLeft
                      ? 10
                      : (!isMobile && _isHovering ? -10 : 0),
                  0,
                  0,
                ),
                padding: EdgeInsets.all(isMobile ? 24 : 40),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceHighlight,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: _isHovering
                        ? AppTheme.magentaAccent
                        : AppTheme.borderSide,
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
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
                            color: AppTheme.magentaAccent.withValues(alpha: 0.1),
                            blurRadius: 30,
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
                        Expanded(
                          child: Text(
                            widget.item.company,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                  fontSize: isMobile ? 20 : 24,
                                ),
                          ),
                        ),
                        Icon(
                          Icons.terminal_rounded,
                          color: _isHovering
                              ? AppTheme.magentaAccent
                              : AppTheme.textSecondary,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.item.role,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppTheme.magentaAccent,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 24),
                    if (widget.item.description.isNotEmpty)
                      Text(
                        widget.item.description,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    if (widget.item.highlights.isNotEmpty)
                      ...widget.item.highlights.map(
                        (h) => Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                  top: 8,
                                  right: 16,
                                ),
                                width: 6,
                                height: 6,
                                decoration: const BoxDecoration(
                                  color: AppTheme.magentaAccent,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  h,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    const SizedBox(height: 32),
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: widget.item.tags.map((t) => _Tag(t)).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (widget.isLeft && !isMobile) const Spacer(),
        ],
      ),
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
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: AppTheme.borderSide),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppTheme.cyanAccent,
            ),
      ),
    );
  }
}
