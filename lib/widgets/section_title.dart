import 'package:flutter/material.dart';
import '../core/theme.dart';

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '< ',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: AppTheme.cyanAccent,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            title.toUpperCase(),
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            ' />',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: AppTheme.cyanAccent,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
