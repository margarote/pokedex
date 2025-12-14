import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/app_cached_image.dart';
import '../../../../core/widgets/highlighted_text.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({
    super.key,
    required this.name,
    required this.number,
    required this.imageUrl,
    this.onTap,
    this.searchText,
  });

  final String name;
  final int number;
  final String imageUrl;
  final VoidCallback? onTap;
  final String? searchText;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.fillMain,
      borderRadius: BorderRadius.circular(AppDimens.radiusMd),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimens.radiusMd),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.borderLowest,
              width: AppDimens.borderWidth,
            ),
            borderRadius: BorderRadius.circular(AppDimens.radiusMd),
          ),
          padding: const EdgeInsets.all(AppDimens.paddingSm),
          child: Column(
            mainAxisSize: .min,
            crossAxisAlignment: .start,
            children: [
              Center(
                child: AppCachedImage(
                  imageUrl: imageUrl,
                  height: AppDimens.pokemonImageHeight,
                ),
              ),
              HighlightedText(text: name, searchText: searchText),
              HighlightedText(
                text: '#$number',
                searchText: searchText,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textDisabled,
                ),
              ),
              const Align(
                alignment: Alignment.bottomRight,
                child: Icon(
                  Icons.add_circle_rounded,
                  color: AppColors.iconHighlight,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
