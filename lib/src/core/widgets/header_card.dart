import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_dimens.dart';

class HeaderCard extends StatelessWidget {
  final Widget? child;
  final double? height;

  const HeaderCard({
    super.key,
    this.child,
    this.height = AppDimens.headerCardDefaultHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: AppDimens.paddingSmm,
        horizontal: AppDimens.md,
      ),
      height: height,
      decoration: BoxDecoration(
        color: AppColors.primaryDark,
        borderRadius: BorderRadius.circular(AppDimens.radiusMd),
      ),
      child: SafeArea(child: child!),
    );
  }
}
