import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../core/constants.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.horizontalPadding,
        vertical: 40,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppConstants.desktopMaxWidth,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'PORTFOLIO',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppTheme.cyanAccent,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                '© 2024 PORTFOLIO // STAMP: 2024.05.22',
                style: Theme.of(context).textTheme.labelSmall,
              ),
              Row(
                spacing: 24,
                children: [
                  _SocialLink('GITHUB', AppConstants.githubUrl),
                  _SocialLink('LINKEDIN', AppConstants.linkedinUrl),
                  // _SocialLink('TWITTER', 'https://twitter.com'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SocialLink extends StatefulWidget {
  final String title;
  final String url;

  const _SocialLink(this.title, this.url);

  @override
  State<_SocialLink> createState() => _SocialLinkState();
}

class _SocialLinkState extends State<_SocialLink> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: Text(
        widget.title,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: _isHovering ? AppTheme.cyanAccent : AppTheme.textSecondary,
        ),
      ),
    );
  }
}
