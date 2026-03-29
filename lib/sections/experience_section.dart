import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/theme.dart';
import '../data/portfolio_data.dart';
import '../models/experience_item.dart';
import '../core/visibility_animator.dart';
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
            child: Column(
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
                    ).textTheme.displayLarge?.copyWith(fontSize: 80),
                    children: [
                      const TextSpan(text: 'ENGINEERING\n'),
                      TextSpan(
                        text: 'EXPERIENCES',
                        style: TextStyle(
                          color: AppTheme.textSecondary.withValues(alpha: 0.5),
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
            ),
          ),
          const SizedBox(height: 80),

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
    return Padding(
      padding: const EdgeInsets.only(bottom: 80.0),
      child: Row(
        mainAxisAlignment: widget.isLeft
            ? MainAxisAlignment.start
            : MainAxisAlignment.end,
        children: [
          if (!widget.isLeft) const Spacer(),
          Expanded(
            flex: 2,
            child: MouseRegion(
              onEnter: (_) => setState(() => _isHovering = true),
              onExit: (_) => setState(() => _isHovering = false),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                transform: Matrix4.translationValues(
                  _isHovering && widget.isLeft ? 10 : (_isHovering ? -10 : 0),
                  0,
                  0,
                ),
                padding: const EdgeInsets.all(40),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceHighlight,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: _isHovering
                        ? AppTheme.cyanAccent
                        : AppTheme.borderSide,
                  ),
                  boxShadow: _isHovering
                      ? [
                          BoxShadow(
                            color: AppTheme.cyanAccent.withValues(alpha: 0.1),
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
                        Text(
                          widget.item.company,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        Icon(
                          Icons.business,
                          color: _isHovering
                              ? AppTheme.cyanAccent
                              : AppTheme.textSecondary,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.item.role,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppTheme.cyanAccent,
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
                                  color: AppTheme.cyanAccent,
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
          if (widget.isLeft) const Spacer(),
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
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: AppTheme.borderSide),
      ),
      child: Text(text, style: Theme.of(context).textTheme.labelSmall),
    );
  }
}
