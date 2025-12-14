import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_dimens.dart';
import '../theme/app_typography.dart';

class TypeChip extends StatelessWidget {
  const TypeChip({
    super.key,
    required this.type,
    this.onTap,
  });

  final String type;
  final VoidCallback? onTap;

  static const _padding = EdgeInsets.symmetric(
    horizontal: AppDimens.paddingSmm,
    vertical: AppDimens.xs,
  );

  static final _borderRadius = BorderRadius.circular(AppDimens.radiusFull);

  static final _textStyle = AppTypography.bodySmall.copyWith(
    color: AppColors.fillMain,
    fontWeight: FontWeight.w600,
  );

  @override
  Widget build(BuildContext context) {
    final chip = Container(
      padding: _padding,
      decoration: BoxDecoration(
        color: AppColors.getTypeColor(type),
        borderRadius: _borderRadius,
      ),
      child: Text(type, style: _textStyle),
    );

    if (onTap == null) return chip;

    return GestureDetector(
      onTap: onTap,
      child: chip,
    );
  }
}
