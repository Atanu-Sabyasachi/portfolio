import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../core/constants.dart';
import '../core/audio_manager.dart';
import '../layout/responsive.dart';

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
    bool isMobile = Responsive.isMobile(context);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : AppConstants.horizontalPadding,
        vertical: 24,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildLogo(context),
          if (isMobile)
            Row(
              children: [
                _SoundToggle(),
                const SizedBox(width: 16),
                _buildMobileMenu(context),
              ],
            )
          else
            _buildDesktopMenu(context),
        ],
      ),
    );
  }

  Widget _buildLogo(BuildContext context) {
    return Text(
      'PORTFOLIO'.toUpperCase(),
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: AppTheme.cyanAccent,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
            fontStyle: FontStyle.italic,
          ),
    );
  }

  Widget _buildDesktopMenu(BuildContext context) {
    return Row(
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
        const SizedBox(width: 8),
        _SoundToggle(),
      ],
    );
  }

  Widget _buildMobileMenu(BuildContext context) {
    return PopupMenuButton<int>(
      onSelected: onNavigate,
      color: AppTheme.surface,
      icon: const Icon(Icons.menu_rounded, color: AppTheme.cyanAccent),
      offset: const Offset(0, 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: AppTheme.borderSide),
      ),
      itemBuilder: (context) => [
        _buildPopupItem(context, 0, 'HOME'),
        _buildPopupItem(context, 1, 'ABOUT'),
        _buildPopupItem(context, 2, 'EXPERIENCE'),
        _buildPopupItem(context, 3, 'PROJECTS'),
        _buildPopupItem(context, 4, 'CONTACT'),
      ],
    );
  }

  PopupMenuItem<int> _buildPopupItem(
    BuildContext context,
    int index,
    String label,
  ) {
    return PopupMenuItem(
      value: index,
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: activeIndex == index
                  ? AppTheme.cyanAccent
                  : AppTheme.textPrimary,
            ),
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
      onEnter: (_) {
        setState(() => _isHovering = true);
        AudioManager.playHover();
      },
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTap: () {
          widget.onTap();
          AudioManager.playClick();
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: widget.isActive || _isHovering
                    ? AppTheme.magentaAccent
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

class _SoundToggle extends StatefulWidget {
  @override
  State<_SoundToggle> createState() => _SoundToggleState();
}

class _SoundToggleState extends State<_SoundToggle> {
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          setState(() {
            AudioManager.toggleMute();
          });
          if (!AudioManager.isMuted) {
            AudioManager.playClick();
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            border: Border.all(
              color: AudioManager.isMuted
                  ? AppTheme.textMuted
                  : AppTheme.cyanAccent,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                AudioManager.isMuted ? Icons.volume_off : Icons.volume_up,
                size: 14,
                color: AudioManager.isMuted
                    ? AppTheme.textMuted
                    : AppTheme.cyanAccent,
              ),
              const SizedBox(width: 8),
              Text(
                AudioManager.isMuted ? 'SOUND: OFF' : 'SOUND: ON',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontSize: 10,
                  color: AudioManager.isMuted
                      ? AppTheme.textMuted
                      : AppTheme.cyanAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
