import 'package:flutter/material.dart';
import '../core/theme.dart';

class CodeHighlighter extends StatelessWidget {
  final String code;

  const CodeHighlighter({super.key, required this.code});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          height: 1.5,
          fontSize: 13,
          color: AppTheme.textSecondary,
        ),
        children: _highlight(code),
      ),
    );
  }

  List<TextSpan> _highlight(String input) {
    final List<TextSpan> spans = [];
    final RegExp regExp = RegExp(
      r'(import|class|extends|override|void|case|const|static|final|return|as|if|else|var|dynamic|int|double|String|bool|Map|List|Set|Future|Stream|get|set|this|super|true|false)|'
      r'("[^"]*"|' + r"'[^']*')" + r'|' + // Strings
      r'([A-Z][a-zA-Z0-9]+)|' + // Types/Classes
      r'(@[a-zA-Z]+)|' + // Annotations
      r'(\/\/.*|\/\*[\s\S]*?\*\/)|' + // Comments
      r'(\b\d+\b)', // Numbers
      multiLine: true,
    );

    int lastMatchEnd = 0;
    for (final Match match in regExp.allMatches(input)) {
      if (match.start > lastMatchEnd) {
        spans.add(TextSpan(text: input.substring(lastMatchEnd, match.start)));
      }

      final String matchText = match.group(0)!;
      Color? color;

      if (match.group(1) != null) {
        color = AppTheme.magentaAccent; // Keywords
      } else if (match.group(2) != null) {
        color = AppTheme.successGreen; // Strings
      } else if (match.group(3) != null) {
        color = AppTheme.cyanAccent; // Classes/Types
      } else if (match.group(4) != null) {
        color = AppTheme.orangeAccent; // Annotations
      } else if (match.group(5) != null) {
        color = AppTheme.textMuted; // Comments
      } else if (match.group(6) != null) {
        color = AppTheme.orangeAccent; // Numbers
      }

      spans.add(TextSpan(
        text: matchText,
        style: TextStyle(
          color: color,
          fontWeight: match.group(1) != null ? FontWeight.bold : FontWeight.normal,
        ),
      ));
      lastMatchEnd = match.end;
    }

    if (lastMatchEnd < input.length) {
      spans.add(TextSpan(text: input.substring(lastMatchEnd)));
    }

    return spans;
  }
}
