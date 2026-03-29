import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/theme.dart';
import '../core/constants.dart';
import 'custom_button.dart';

class KineticNavBar extends StatelessWidget {
  final Function(int) onNavigate;
  final int activeIndex;

  const KineticNavBar({
    super.key,
    required this.onNavigate,
    this.activeIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.horizontalPadding,
        vertical: 24,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'PORTFOLIO'.toUpperCase(),
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppTheme.cyanAccent,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.5,
              fontStyle: FontStyle.italic,
            ),
          ),
          Row(
            spacing: 32,
            children: [
              _NavText(
                'HOME',
                isActive: activeIndex == 0,
                onTap: () => onNavigate(0),
              ),
              _NavText(
                'ABOUT',
                isActive: activeIndex == 1,
                onTap: () => onNavigate(1),
              ),
              _NavText(
                'EXPERIENCE',
                isActive: activeIndex == 2,
                onTap: () => onNavigate(2),
              ),
              _NavText(
                'PROJECTS',
                isActive: activeIndex == 3,
                onTap: () => onNavigate(3),
              ),
              _NavText(
                'CONTACT',
                isActive: activeIndex == 4,
                onTap: () => onNavigate(4),
              ),
              const SizedBox(width: 8),
              CustomButton(
                text: 'RESUME',
                onPressed: () => launchUrl(Uri.parse(AppConstants.resumeUrl)),
                isOutlined: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NavText extends StatefulWidget {
  final String text;
  final bool isActive;
  final VoidCallback onTap;

  const _NavText(this.text, {this.isActive = false, required this.onTap});

  @override
  State<_NavText> createState() => _NavTextState();
}

class _NavTextState extends State<_NavText> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: widget.isActive || _isHovering
                    ? AppTheme.cyanAccent
                    : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          padding: const EdgeInsets.only(bottom: 4),
          child: Text(
            widget.text,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: widget.isActive || _isHovering
                  ? AppTheme.textPrimary
                  : AppTheme.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
