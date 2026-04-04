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
    bool isMobile = Responsive.isMobile(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile 
            ? MediaQuery.of(context).size.width * 0.06 
            : AppConstants.horizontalPadding,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppConstants.desktopMaxWidth,
          ),
          child: Padding(
            padding: EdgeInsets.only(
              top: isMobile ? topPadding * 0.5 : topPadding, 
              bottom: bottomPadding,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
