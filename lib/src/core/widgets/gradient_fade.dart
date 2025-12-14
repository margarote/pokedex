import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_dimens.dart';

class GradientFade extends StatelessWidget {
  const GradientFade({
    super.key,
    this.height = AppDimens.gradientFadeHeight,
    this.color = AppColors.fillBackground,
  });

  final double height;
  final Color color;

  List<Color> get _gradientColors => [
        color.withValues(alpha: AppColors.opacityTransparent),
        color.withValues(alpha: AppColors.opacityMedium),
        color,
      ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: _gradientColors,
        ),
      ),
    );
  }
}
