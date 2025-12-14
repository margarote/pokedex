import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_dimens.dart';
import '../theme/app_typography.dart';

class StateMessage extends StatelessWidget {
  const StateMessage({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.iconColor,
    this.action,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final Color? iconColor;
  final Widget? action;

  static const _iconDecoration = BoxDecoration(
    color: AppColors.fillNeutralLowest,
    shape: BoxShape.circle,
  );

  static final _titleStyle = AppTypography.titleMedium.copyWith(
    color: AppColors.black,
  );

  static final _subtitleStyle = AppTypography.bodySmall.copyWith(
    color: AppColors.textDisabled,
  );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.xl),
        child: Column(
          mainAxisSize: .min,
          children: [
            Container(
              padding: const EdgeInsets.all(AppDimens.lg),
              decoration: _iconDecoration,
              child: Icon(
                icon,
                size: AppDimens.iconXl,
                color: iconColor ?? AppColors.textDisabled,
              ),
            ),
            const SizedBox(height: AppDimens.md),
            Text(title, style: _titleStyle, textAlign: TextAlign.center),
            if (subtitle != null) ...[
              const SizedBox(height: AppDimens.xs),
              Text(
                subtitle!,
                style: _subtitleStyle,
                textAlign: TextAlign.center,
              ),
            ],
            if (action != null) ...[
              const SizedBox(height: AppDimens.lg),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}
