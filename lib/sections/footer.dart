import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../core/constants.dart';
import '../layout/responsive.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : AppConstants.horizontalPadding,
        vertical: 40,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppConstants.desktopMaxWidth,
          ),
          child: Flex(
            direction: isMobile ? Axis.vertical : Axis.horizontal,
            mainAxisAlignment: isMobile 
                ? MainAxisAlignment.center 
                : MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'PORTFOLIO',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppTheme.cyanAccent,
                  fontWeight: FontWeight.w900,
                ),
              ),
              if (isMobile) const SizedBox(height: 24),
              Text(
                '© ${DateTime.now().year} PORTFOLIO // STAMP: ${DateTime.now().year}.${DateTime.now().month}.${DateTime.now().day}',
                style: Theme.of(context).textTheme.labelSmall,
              ),
              if (isMobile) const SizedBox(height: 24),
              Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 24,
                children: [
                  _SocialLink('GITHUB', AppConstants.githubUrl),
                  _SocialLink('LINKEDIN', AppConstants.linkedinUrl),
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
      child: GestureDetector(
        onTap: () => launchUrl(Uri.parse(widget.url)),
        child: Text(
          widget.title,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: _isHovering ? AppTheme.cyanAccent : AppTheme.textSecondary,
              ),
        ),
      ),
    );
  }
}
