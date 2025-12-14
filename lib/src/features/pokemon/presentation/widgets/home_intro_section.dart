import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_typography.dart';

class HomeIntroSection extends StatelessWidget {
  final String title;
  final String subtitle;
  final String highlightText;
  final String highlightLabel;

  const HomeIntroSection({
    super.key,
    required this.title,
    required this.subtitle,
    required this.highlightText,
    required this.highlightLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.fillBackground,
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.md),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Text(
            title,
            style: AppTypography.displayMedium,
          ),
          const SizedBox(height: AppDimens.sm),
          Text(
            subtitle,
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppDimens.md),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '$highlightText ',
                  style: AppTypography.displayLarge.copyWith(
                    color: AppColors.primaryDark,
                  ),
                ),
                TextSpan(
                  text: highlightLabel,
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.primaryDark,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
