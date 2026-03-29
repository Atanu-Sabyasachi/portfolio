import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../layout/responsive.dart';

class SectionContainer extends StatelessWidget {
  final Widget child;
  final double topPadding;
  final double bottomPadding;

  const SectionContainer({
    super.key,
    required this.child,
    this.topPadding = 120,
    this.bottomPadding = 40,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.isMobile(context) 
            ? 24 
            : AppConstants.horizontalPadding,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppConstants.desktopMaxWidth,
          ),
          child: Padding(
            padding: EdgeInsets.only(top: topPadding, bottom: bottomPadding),
            child: child,
          ),
        ),
      ),
    );
  }
}
