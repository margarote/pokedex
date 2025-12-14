import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_dimens.dart';
import '../theme/app_typography.dart';

class FilterChipButton extends StatelessWidget {
  const FilterChipButton({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  static const _animationDuration = Duration(milliseconds: 200);
  static const _padding = EdgeInsets.symmetric(
    vertical: AppDimens.xxs,
    horizontal: AppDimens.sm,
  );
  static final _borderRadius = BorderRadius.circular(AppDimens.radiusLg);
  static const _border = BorderSide(
    color: AppColors.borderPure,
    width: AppDimens.borderWidth,
  );

  static const _closeIconDecoration = BoxDecoration(
    color: AppColors.fillMain,
    shape: BoxShape.circle,
  );

  static const _closeIcon = Icon(
    Icons.close,
    size: AppDimens.iconXs,
    color: AppColors.black,
  );

  static final _selectedTextStyle = AppTypography.bodyMedium.copyWith(
    color: AppColors.fillMain,
  );

  static final _unselectedTextStyle = AppTypography.bodyMedium.copyWith(
    color: AppColors.black,
  );

  Color get _backgroundColor =>
      isSelected ? AppColors.fillInteractionHighest : AppColors.fillMain;

  TextStyle get _textStyle =>
      isSelected ? _selectedTextStyle : _unselectedTextStyle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: _animationDuration,
        padding: _padding,
        decoration: BoxDecoration(
          color: _backgroundColor,
          borderRadius: _borderRadius,
          border: const Border.fromBorderSide(_border),
        ),
        child: Row(
          mainAxisSize: .min,
          children: [
            if (isSelected) ...[
              Container(
                padding: const EdgeInsets.all(AppDimens.xxs),
                decoration: _closeIconDecoration,
                child: _closeIcon,
              ),
              const SizedBox(width: AppDimens.xs),
            ],
            Text(label, style: _textStyle),
          ],
        ),
      ),
    );
  }
}
