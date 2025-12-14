import 'package:flutter/material.dart';

import '../constants/app_strings.dart';
import '../theme/app_colors.dart';
import 'state_message.dart';

class ErrorState extends StatelessWidget {
  const ErrorState({
    super.key,
    required this.title,
    this.subtitle,
    this.onRetry,
  });

  final String title;
  final String? subtitle;
  final VoidCallback? onRetry;

  static final _retryButtonStyle = TextButton.styleFrom(
    foregroundColor: AppColors.primaryDark,
  );

  @override
  Widget build(BuildContext context) {
    return StateMessage(
      icon: Icons.error_outline_rounded,
      iconColor: AppColors.primaryDark,
      title: title,
      subtitle: subtitle,
      action: onRetry != null
          ? TextButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text(AppStrings.tryAgain),
              style: _retryButtonStyle,
            )
          : null,
    );
  }
}
