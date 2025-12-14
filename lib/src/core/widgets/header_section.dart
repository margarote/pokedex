import 'package:flutter/material.dart';

import 'header_card.dart';

class HeaderSection extends StatelessWidget {
  final Widget? headerChild;
  final double? headerHeight;
  final Widget? child;

  const HeaderSection({
    super.key,
    this.headerChild,
    this.headerHeight,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        HeaderCard(
          height: headerHeight,
          child: headerChild,
        ),
        if (child != null) child!,
      ],
    );
  }
}
