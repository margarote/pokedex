import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/app_colors.dart';
import '../theme/app_dimens.dart';
import '../theme/app_typography.dart';

class HeaderContent extends StatelessWidget {
  const HeaderContent({
    super.key,
    required this.title,
    this.icon,
    this.iconHeight = AppDimens.iconLg,
  });

  final String title;
  final String? icon;
  final double iconHeight;

  static final _titleStyle = AppTypography.displayMedium.copyWith(
    color: AppColors.fillMain,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      mainAxisAlignment: .end,
      children: [
        Text(title, style: _titleStyle),
        if (icon != null) ...[
          const SizedBox(height: AppDimens.paddingSmm),
          SvgPicture.asset(icon!, height: iconHeight),
        ],
      ],
    );
  }
}
