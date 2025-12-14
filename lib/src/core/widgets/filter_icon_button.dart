import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/app_colors.dart';
import '../theme/app_dimens.dart';

class FilterIconButton extends StatelessWidget {
  const FilterIconButton({
    super.key,
    required this.icon,
    this.onTap,
  });

  final String icon;
  final VoidCallback? onTap;

  static final _borderRadius = BorderRadius.circular(AppDimens.radiusSm);
  static const _iconColorFilter = ColorFilter.mode(
    AppColors.fillMain,
    BlendMode.srcIn,
  );

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.fillInteractionHighest,
      borderRadius: _borderRadius,
      child: InkWell(
        onTap: onTap,
        borderRadius: _borderRadius,
        splashColor: AppColors.splashColor,
        highlightColor: AppColors.highlightColor,
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.md),
          child: SvgPicture.asset(
            icon,
            colorFilter: _iconColorFilter,
            width: AppDimens.iconMd,
            height: AppDimens.iconMd,
          ),
        ),
      ),
    );
  }
}
