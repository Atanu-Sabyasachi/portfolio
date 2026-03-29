import 'package:flutter/material.dart';
import '../core/theme.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isOutlined;
  final IconData? icon;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isOutlined = false,
    this.icon,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          decoration: BoxDecoration(
            color: widget.isOutlined
                ? (_isHovered ? AppTheme.surfaceHighlight : Colors.transparent)
                : (_isHovered
                      ? AppTheme.cyanAccent.withValues(alpha: 0.8)
                      : AppTheme.cyanAccent),
            border: widget.isOutlined
                ? Border.all(
                    color: widget.isOutlined && _isHovered
                        ? AppTheme.cyanAccent
                        : AppTheme.borderSide,
                    width: 2,
                  )
                : null,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.text.toUpperCase(),
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: widget.isOutlined
                      ? AppTheme.textPrimary
                      : AppTheme.background,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              if (widget.icon != null) ...[
                const SizedBox(width: 8),
                Icon(
                  widget.icon,
                  size: 16,
                  color: widget.isOutlined
                      ? AppTheme.textPrimary
                      : AppTheme.background,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
